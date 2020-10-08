class Explosion extends Animator
{
  PVector pos;
  public Object[] sprites = explosion.toArray();
  int speed = 15;
 
 Explosion(PVector pos)
 {   
   anim = new Animation(speed, sprites);
   anim.Play(pos);
 }
}
