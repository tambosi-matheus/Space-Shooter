enum EnemyType {
  small, medium, big
};

public PVector GetRandomSpawn()
{
  int rand = (int) random(4);
  switch(rand)
  {
  default:
    return new PVector();
  case 0: 
    return new PVector(random(size.x), -50); 
  case 1:
    return new PVector(random(size.x), size.y + 50);
  case 2: 
    return new PVector(-50, random(size.y)); 
  case 3:
    return new PVector(size.x + 50, random(size.y));
  }
}

//--------------------------------------------------------------------------------//

public class SmallEnemy extends Solid
{
  private PVector acel;  
  private float maxAcel = 1, maxSpeed = 20, angle, 
    explosionTimer = 12, explosionCounter = 0, range = height / 8, explosionRange = 300;
  private boolean isExploding;

  public SmallEnemy()
  {
    pos = GetRandomSpawn();
    vel = new PVector();
    acel = new PVector();
  }
  public SmallEnemy(PVector pos)
  {
    this.pos = pos;
    vel = new PVector();
    acel = new PVector();
  }

  public void Update()
  {
    Movimentation();
    Explosion();
  }

  private void Movimentation()
  {
    if (isExploding) return;
    angle = PVector.sub(player.pos, pos).heading() + HALF_PI;
    if (vel.mag() < 0.1f)
      vel = new PVector(0, 0);
    if (PVector.dist(pos, player.pos) > range)
    {
      acel = PVector.sub(player.pos, pos);
      acel.normalize().mult(maxAcel);
      vel.add(acel);
      if (this.vel.mag() > maxSpeed)       
        this.vel.normalize().mult(maxSpeed);        
      PVector finalVel = this.vel.copy();
      finalVel.mult(deltaTime);
      this.pos.add(finalVel);
    } else
    {
      vel = new PVector(0, 0);
      isExploding = true;
    }
  }

  private void Explosion()
  {
    if (!isExploding) return;

    if (explosionCounter > explosionTimer)
    {
      audio_enemy_small_explosion.stop();
      audio_enemy_small_explosion.play();
      removeSolids.add(this);
      activeAnimations.add(new AnimationEnemyExplosion(pos));
    }
    else
      explosionCounter += deltaTime;
  }

  public void Show()
  {
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);    
    image(image_enemy_small, 0, 0);
    
    if(isExploding)
    {
     noFill();
     stroke(map(explosionCounter, 0, explosionTimer, 0, 255), 0, 0);
     circle(0, 0, explosionRange);
    }

    popMatrix();
  }
}

//--------------------------------------------------------------------------------//

public class MediumEnemy extends Solid
{    
  private PVector acel, firePoint;
  private float fireOffset = 3, angle, 
    maxSpeed = 12, maxAcel = 0.8, 
    range = height / 4, bulletSpeed = 20,
    fireRate = 2, fireCooldown;

  public MediumEnemy()
  {
    pos = GetRandomSpawn(); 
    collRadius = 15;

    vel = new PVector();
    acel = new PVector();
  }


  public void Update()
  {
    Movimentation();
    Shoot();
  }


  private void Movimentation()
  {
    angle = PVector.sub(player.pos, pos).heading() + HALF_PI;
    if (vel.mag() < 0.1f)
      vel = new PVector(0, 0);
    vel = vel.mult(0.95f);
    if (PVector.dist(pos, player.pos) > range)
    {
      acel = PVector.sub(player.pos, pos);
      acel.normalize().mult(maxAcel);
      vel.add(acel);
      if (this.vel.mag() > maxSpeed)       
        this.vel.normalize().mult(maxSpeed);        
      PVector finalVel = this.vel.copy();
      finalVel.mult(deltaTime);
      this.pos.add(finalVel);
    } else
    {
      vel = new PVector(0, 0);
    }
  }

  private void Shoot()
  {    
    fireCooldown += deltaTime;
    if (PVector.dist(pos, player.pos) < range && fireCooldown > 15 / fireRate)
    { 
      audio_enemy_medium_shot.stop();
      audio_enemy_medium_shot.play();
      firePoint = new PVector(0, -fireOffset).rotate(angle);
      PVector bulletPos = pos.copy();
      addSolids.add(new MediumEnemyBullet(bulletPos, bulletSpeed, angle));
      fireCooldown = 0;
    }
  }

  public void Show()
  {
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);
    image(image_enemy_medium, 0, 0);

    popMatrix();
  }
}

//--------------------------------------------------------------------------------//

class MediumEnemyBullet extends Solid
{
  private float angle;

  public MediumEnemyBullet(PVector pos, float speed, float angle)
  {
    this.pos = pos;    
    super.collRadius = 15;
    vel = new PVector(0, -1);
    this.vel.rotate(angle).mult(speed);

    this.angle = angle;
  }
  
  public PVector getPos(){return pos;}
  
  public void Update()
  {
    PVector add = vel.copy();
    add.mult(deltaTime);
    pos.add(add);
  }

  public void Collision(ArrayList<Solid> grid)
  {   
    for (Solid s : grid)
    {
      if (s == this)     
        continue;

      if (Util.CheckCollision(pos, vel, collRadius, s.pos, new PVector(), s.collRadius))
      {        
        if (s.getClass().toGenericString().equals(""))
        {
          break;
        }
      }
    }
  }

  public void Show()
  {
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);
    fill(255, 0, 0);
    image(image_enemy_medium_bullet, 0, 0);

    popMatrix();
  }
}

//--------------------------------------------------------------------------------//

public class BigEnemy extends Solid
{    
  private PVector acel;
  private float spawnOffset = 10, angle, 
    maxSpeed = 8, maxAcel = 0.3,
    range = height / 3, spawnRate = 5, spawnCooldown;

  public BigEnemy()
  {
    pos = GetRandomSpawn(); 
    collRadius = 15;

    vel = new PVector();
    acel = new PVector();
  }


  public void Update()
  {
    Movimentation();
    Spawn();
  }


  private void Movimentation()
  {
    angle = PVector.sub(player.pos, pos).heading() + HALF_PI;
    if (vel.mag() < 0.1f)
      vel = new PVector(0, 0);
    vel = vel.mult(0.95f);
    if (PVector.dist(pos, player.pos) > range)
    {
      acel = PVector.sub(player.pos, pos);
      acel.normalize().mult(maxAcel);
      vel.add(acel);
      if (this.vel.mag() > maxSpeed)       
        this.vel.normalize().mult(maxSpeed);        
      PVector finalVel = this.vel.copy();
      finalVel.mult(deltaTime);
      this.pos.add(finalVel);
    } else
    {
      vel = new PVector(0, 0);
    }
  }

  private void Spawn()
  {
    spawnCooldown += deltaTime;
    if (PVector.dist(pos, player.pos) < range && spawnCooldown > 50/spawnRate)
    {
        audio_enemy_big_spawn.play();
        PVector spawnPos = pos.copy();
        spawnPos.add(new PVector(random(-spawnOffset, spawnOffset), random(-spawnOffset, spawnOffset)));
        addSolids.add(new SmallEnemy(spawnPos));
        spawnCooldown = 0;
    }
  }
  
  public void Show()
  {
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);
    image(image_enemy_big, 0, 0);

    popMatrix();
  }
}
