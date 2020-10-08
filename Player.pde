public class Player implements Solid
{
  public PVector pos;
  private PVector vel, acel, firePoint;
  private float maxSpeed = 20, maxAcel= 10, angle, 
    fireRate = 4, fireCooldown, bulletSpeed = 50, 
    fireRandomness = 0.1f, fireOffset = 20;

  public Player()
  {
    pos = new PVector(0, 0);
    vel = new PVector(0, 0);
    acel = new PVector(0, 0);
    firePoint = new PVector(0, 0);
  }

  public void Update()
  {     
    if (keyQ)
    {      
      activeAnimations.add(new Explosion(new PVector(0, 0)));
    }
    Movimentation();
    Shoot();
  }

  private void Movimentation()
  {
    //calc rotation
    if(mouseRight) angle = mouse.heading() - HALF_PI;    
    else if(vel.mag() > 0.1f) angle = vel.heading() + HALF_PI;
    
    //set camera
    camera(pos.x, pos.y, 
      (height/2.0) / tan(PI*30.0 / 180.0), 
      pos.x, pos.y, 0, 0, -1, 0);
      
    //set acceleration and velocity
    vel = vel.mult(0.99f);
    if (vel.mag() < 0.1f) vel = new PVector(0, 0);
    acel = new PVector((int(keyA) - int(keyD)), (int(keyW) - int(keyS)));
    acel.normalize().mult(maxAcel);
    vel.add(acel);
    if (vel.mag() > maxSpeed)    
      vel.add(acel).normalize().mult(maxSpeed);
    vel.mult(deltaTime);
    pos.add(vel);
  }
  
  private void Shoot()
  {
    fireCooldown += deltaTime;
   if(mouseRight &&  fireCooldown > 10 / fireRate)
   {
     firePoint = new PVector(0, -fireOffset).rotate(angle);
     addSolids.add(new PlayerBullet(PVector.add(pos, firePoint), bulletSpeed, angle));
     fireCooldown = 0;
   }
  }

  public void Show()
  {
    fill(0, 255, 0);

    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);
    image(image_player_middle, 0, 0);

    popMatrix();
  }
}


class PlayerBullet implements Solid
{
  
  PVector pos, vel;
  public PlayerBullet(PVector pos, float speed, float angle)
  {
   this.pos = pos;
   vel = new PVector(0, -1);
   vel.rotate(angle).mult(speed);
  }
  void Update()
  {
    PVector add = vel.copy();
    add.mult(deltaTime);
    pos.add(add);
  }

  void Show()
  {
    circle(pos.x, pos.y, 10);
  }
}
