class AnimationEnemyExplosion extends Animator
{
  PVector pos;
  public Object[] sprites = enemy_explosion.toArray();
  int speed = 15;
 
 AnimationEnemyExplosion(PVector pos)
 {   
   anim = new Animation(speed, sprites);
   anim.Play(pos);
 }
}

//--------------------------------------------------------------------------------//

class AnimationPlayerExplosion extends Animator
{
  PVector pos;
  public Object[] sprites = player_explosion.toArray();
  int speed = 15;
 
 AnimationPlayerExplosion(PVector pos)
 {   
   anim = new Animation(speed, sprites);
   anim.Play(pos);
 }
}
