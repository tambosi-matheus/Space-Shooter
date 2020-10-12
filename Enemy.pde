enum EnemyType {
  small, medium, big
};

public ArrayList<PVector> spawns;

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

public class Enemy extends Solid
{    
  private PVector acel, firePoint;
  private float fireOffset = 3, angle, 
    maxSpeed = 8, maxAcel = 0.3, 
    range = 180f, fireRate = 5, fireCooldown;

  public Enemy()
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
      //addSolids.add(new EnemyBullet(pos, 5, angle));
      firePoint = new PVector(0, -fireOffset).rotate(angle);
      fireCooldown = 0;
    }
  }

  public void Collision(ArrayList<Solid> grid)
  {
  }


  public void Show()
  {
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);
    fill(0, 255, 0);
    image(image_enemy_medium, 0, 0);

    popMatrix();
  }
}

class EnemyBullet extends Solid
{ 
  public EnemyBullet(PVector pos, float speed, float angle)
  {
    this.pos = pos;
    vel = new PVector(0, -1);
    vel.rotate(angle).mult(speed);
    super.collRadius = 15;
  }

  public PVector getPos() {
    return pos;
  }

  void Update()
  {
    PVector add = vel.copy();
    add.mult(deltaTime);
    pos.add(add);
  }

  void Show()
  {
    //circle(pos.x, pos.y, 10);
  }
}
