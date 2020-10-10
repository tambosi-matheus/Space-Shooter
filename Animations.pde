class ExplosionAnim extends Animator
{
  PVector pos;
  public Object[] sprites = explosion.toArray();
  int speed = 15;
 
 ExplosionAnim(PVector pos)
 {   
   anim = new Animation(speed, sprites);
   anim.Play(pos);
 }
}

class PlayerBulletAnim extends Animator
{
  PVector pos;
  public Object[] sprites = player_bullet.toArray();
  int speed = 15;
 
 PlayerBulletAnim(PVector pos)
 {   
   anim = new Animation(speed, true, sprites);
   anim.Play(pos);
 }
}
