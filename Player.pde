public class Player extends Solid
{ 
  private PVector acel, firePoint;
  private float maxSpeed = 20, maxAcel= 10, angle, 
    fireRate = 8, fireCooldown, bulletSpeed = 50, 
    fireRandomness = 0.05f, fireOffset = 20;

  public Player()
  {
    pos = new PVector(size.x /2, size.y/2);
    vel = new PVector();
    collRadius = 50;

    acel = new PVector();
    firePoint = new PVector();
  }
  
  public PVector getPos(){return pos;}

  public void Update()
  {     
    Movimentation();
    Shoot();
    Camera();
  }

  private void Movimentation()
  {
    //calc rotation
    if (mouseRight) angle = PVector.sub(mouse, pos).heading() + HALF_PI;    
    else if (vel.mag() > 0.1f) angle = vel.heading() + HALF_PI;

    //set camera
    camDesiredPos = pos;

    //set acceleration and velocity
    vel = vel.mult(0.9f);
    if (vel.mag() < 0.1f) vel = new PVector(0, 0);
    acel = new PVector((int(keyA) - int(keyD)), (int(keyW) - int(keyS)));
    acel.normalize().mult(maxAcel);
    vel.add(acel);
    if (vel.mag() > maxSpeed)       
      vel.normalize().mult(maxSpeed);        
    PVector finalVel = vel.copy();
    finalVel.mult(deltaTime);
    pos.add(finalVel);
  }

  private void Shoot()
  {
    fireCooldown += deltaTime;
    if (mouseRight &&  fireCooldown > 10 / fireRate)
    {
      float fireAngle = angle + random(-fireRandomness, fireRandomness);
      firePoint = new PVector(0, -fireOffset).rotate(angle);
      addSolids.add(new PlayerBullet(PVector.add(pos, firePoint), bulletSpeed, fireAngle));
      fireCooldown = 0;
    }
  }

  public void Collision(ArrayList<Solid> grid)
  {   
    for (Solid s : grid)
    {
      if (s == this)     
        continue;

      if (Util.CheckCollision(pos, vel, collRadius, s.pos, new PVector(), s.collRadius))
      {        
        if (s.getClass().toGenericString().equals("public class SpaceShooter$Enemy"))
        {
          println("player colliding with enemy");
        }
      }
    }
  }

  public void Show()
  {
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);
    if (acel.x < 0.5)
      image(image_player_right, 0, 0);
    else if (acel.x > 0.5)
      image(image_player_left, 0, 0);
    else
      image(image_player_middle, 0, 0);

    popMatrix();
  }
}


public class PlayerBullet extends Solid
{
  private float angle;

  public PlayerBullet(PVector pos, float speed, float angle)
  {
    this.pos = pos;    
    super.collRadius = 15;
    vel = new PVector(0, -1);
    vel.rotate(angle).mult(speed);

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
        if (s.getClass().toGenericString().equals("public class SpaceShooter$Enemy"))
        {
          removeSolids.add(this);
          removeSolids.add(s);
          activeAnimations.add(new AnimationEnemyExplosion(pos));
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
    image(image_player_bullet, 0, 0);

    popMatrix();
  }
}
