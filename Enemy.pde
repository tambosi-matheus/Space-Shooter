enum EnemyType {
  small, medium, big
};

public class Enemy extends Solid
{
  private PVector pos, vel, acel, firePoint;
  private float fireOffset = 3, angle, 
        maxSpeed = 5, maxAcel = 5,
        range = 180f, fireRate = 5, fireCooldown;
  private boolean showRange;
  
  public Enemy(float x, float y, EnemyType type)
  {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acel = new PVector(0, 0);

    switch(type)
    {
    case small:

      break;

    case medium:
      
      break;

    case big:

      break;
    }
  }

  public void Update()
  {
    Movimentation();
    Shoot();
  }
  
  
  private void Movimentation()
  {
    angle = vel.heading() + HALF_PI;
    vel = vel.mult(0.95f);
    if (vel.mag() < 0.1f) vel = new PVector(0, 0);
    if(PVector.dist(pos, player.pos) > range)
    {
      acel = PVector.sub(player.pos, pos);
      acel.normalize().mult(maxAcel);
      vel.add(acel);
      if (vel.mag() > maxSpeed)       
        vel.add(acel).normalize().mult(maxSpeed);        
      PVector finalVel = vel.copy();
      finalVel.mult(deltaTime);
      pos.add(finalVel);
    }
    else
    {
       vel = new PVector(0, 0); 
    }
  }
  
  private void Shoot()
  {    
    fireCooldown += deltaTime;
    if(PVector.dist(pos, player.pos) < range && fireCooldown > 15 / fireRate)
    {
      //addSolids.add(new EnemyBullet(pos, 5, angle));
      firePoint = new PVector(0, -fireOffset).rotate(angle);
      fireCooldown = 0;
    }
  }
  
  public void Collision()
  {
 
  }
  

  public void Show()
  {
    Debug();
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(angle);
    image(image_enemy_medium, 0, 0);

    popMatrix();
  }
  
  
  private void Debug()
  {
    if(!keyE)
    {     
      noFill();
      stroke(255, 255, 255);
      
      circle(pos.x, pos.y, 2*range);      
    }
  }
}

class EnemyBullet extends Solid
{
  private PVector pos, vel;
  public EnemyBullet(PVector pos, float speed, float angle)
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
    //circle(pos.x, pos.y, 10);
  }
}
