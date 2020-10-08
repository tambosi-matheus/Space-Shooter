enum EnemyType {
  small, medium, big
};

public class Enemy implements Solid
{
  private PVector pos, vel, acel, firePoint;
  private float fireOffset = 3, angle, 
        maxSpeed = 5, maxAcel = 5,
        range, fireRate = 5, fireCooldown;
  
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
  }
  
  private void Shoot()
  {    
    fireCooldown += deltaTime;
    if(PVector.dist(pos, player.pos) < range && fireCooldown > 15 / fireRate)
    {
      firePoint = new PVector(0, -fireOffset).rotate(angle);
      fireCooldown = 0;
    }
  }
  

  public void Show()
  {
  }
}

class EnemyBullet implements Solid
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
