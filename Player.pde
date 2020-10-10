public class Player extends Solid
{ 
  private PVector vel, acel, firePoint;
  private float maxSpeed = 20, maxAcel= 10, angle, 
    fireRate = 8, fireCooldown, bulletSpeed = 5, 
    fireRandomness = 0.05f, fireOffset = 20;

  public Player()
  {
    super.pos = new PVector(size.x /2 , size.y/2);
    vel = new PVector(0, 0);
    acel = new PVector(0, 0);
    firePoint = new PVector(0, 0);
    super.collWidth = 5;
    super.collHeight = 5;
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
    Camera();
  }

  private void Movimentation()
  {
    //calc rotation
    if(mouseRight) angle = mouse.heading() - HALF_PI;    
    else if(vel.mag() > 0.1f) angle = vel.heading() + HALF_PI;
    
    //set camera
    camDesiredPos = pos;
      
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
    rect(pos.x, pos.y, collWidth, collHeight);
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


public class PlayerBullet extends Solid
{
  private PVector vel;
  private float angle;
  
  public PlayerBullet(PVector pos, float speed, float angle)
  {
   super.pos = pos;
   this.angle = angle;
   vel = new PVector(0, -1);
   vel.rotate(angle).mult(speed);
   super.collWidth = 15;
   super.collHeight = 15;
  }
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
        break;
      if(Util.CheckCollision(pos, collWidth, collHeight, s.pos, s.collWidth, s.collHeight))
      {
       if(s.getClass().toGenericString() == "Enemy")
       {
         
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
    rect(0, 0, collWidth, collHeight);
    image(image_player_bullet, 0, 0);

    popMatrix();
  }
}
