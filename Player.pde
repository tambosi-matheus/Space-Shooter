public class Player extends Solid
{
  public PVector pos;
  private PVector vel, acel, firePoint;
  private float maxSpeed = 20, maxAcel= 10, angle, 
    fireRate = 8, fireCooldown, bulletSpeed = 50, 
    fireRandomness = 0.05f, fireOffset = 20;

  public Player()
  {
    pos = new PVector(size.x /2 , size.y/2);
    vel = new PVector(0, 0);
    acel = new PVector(0, 0);
    firePoint = new PVector(0, 0);
  }

  public void Update()
  {     
    if (keyQ)
    {   
      addSolids.add(new Enemy(0, 0, EnemyType.medium));
      //activeAnimations.add(new ExplosionAnim(new PVector(0, 0)));
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
    vel = vel.mult(0.95f);
    if (vel.mag() < 0.1f) vel = new PVector(0, 0);
    acel = new PVector((int(keyA) - int(keyD)), (int(keyW) - int(keyS)));
    acel.normalize().mult(maxAcel);
    vel.add(acel);
    if (vel.mag() > maxSpeed)       
      vel.add(acel).normalize().mult(maxSpeed);        
    PVector finalVel = vel.copy();
    finalVel.mult(deltaTime);
    pos.add(finalVel);
  }
  
  private void Shoot()
  {
    fireCooldown += deltaTime;
   if(mouseRight &&  fireCooldown > 10 / fireRate)
   {
     float fireAngle = angle + random(-fireRandomness, fireRandomness);
     firePoint = new PVector(0, -fireOffset).rotate(angle);
     
     addSolids.add(new PlayerBullet(PVector.add(pos, firePoint), bulletSpeed, fireAngle));
     fireCooldown = 0;
   }
  }
  
  public void Collision()
  {
    
  }

  public void Show()
  {
    pushMatrix();
    
    translate(pos.x, pos.y);
    rotate(angle);
    if(acel.x < 0.5)
      image(image_player_right, 0, 0);
    else if(acel.x > 0.5)
      image(image_player_left, 0, 0);
    else
      image(image_player_middle, 0, 0);

    popMatrix();
  }
}


class PlayerBullet extends Solid
{
  public PVector pos;
  private PVector vel;
  private float angle;
  
  public PlayerBullet(PVector pos, float speed, float angle)
  {
   this.pos = pos;
   this.angle = angle;
   vel = new PVector(0, -1);
   vel.rotate(angle).mult(speed);
  }
  public void Update()
  {
    PVector add = vel.copy();
    add.mult(deltaTime);
    pos.add(add);
  }
  
  public void Collision()
  {
    
  }

  public void Show()
  {
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);
    image(image_player_bullet, 0, 0);

    popMatrix();
  }
}
