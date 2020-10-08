import java.io.*; 
import java.util.List; 
import java.util.ArrayList; 

ArrayList<Animator> activeAnimations, desactiveAnimations;

//create image variables here ('image_' prefix)
PImage 
  image_player_left, image_player_middle, image_player_right, image_player_laser, 
  image_cursor, image_background, 
  image_explosion_0, image_explosion_1, image_explosion_2, image_explosion_3, 
  image_explosion_4, image_explosion_5, image_explosion_6, image_explosion_7;

ArrayList<PImage> explosion;

//class that every animation should derive from
//as all game animations graphic arrays are managed based on 
abstract class Animator {
  public Animation anim;
}

//basic graphics function called on the processing setup
//use here to load imaged, set constants and change primitive behaviours
void SetGraphics()
{    
  imageMode(CENTER);

  activeAnimations = new ArrayList<Animator>();
  desactiveAnimations = new ArrayList<Animator>();

  image_player_left = loadImage("images/player left.png");
  image_player_middle = loadImage("images/player middle.png");
  image_player_right = loadImage("images/player left.png");   
  image_player_laser = loadImage("images/player shot.png");
  image_cursor = loadImage("images/crosshair.png");
  cursor(image_cursor);
  image_explosion_0 = loadImage("images/player explosion 0.png");
  image_explosion_1 = loadImage("images/player explosion 1.png");
  image_explosion_2 = loadImage("images/player explosion 2.png");
  image_explosion_3 = loadImage("images/player explosion 3.png");
  image_explosion_4 = loadImage("images/player explosion 4.png");
  image_explosion_5 = loadImage("images/player explosion 5.png");
  image_explosion_6 = loadImage("images/player explosion 6.png");
  image_explosion_7 = loadImage("images/player explosion 7.png");
  image_background = loadImage("images/background.png");

  explosion = new ArrayList<PImage>();
  explosion.add(image_explosion_0);
  explosion.add(image_explosion_1);
  explosion.add(image_explosion_2);
  explosion.add(image_explosion_3);
  explosion.add(image_explosion_4);
  explosion.add(image_explosion_5);
  explosion.add(image_explosion_6);
  explosion.add(image_explosion_7);
}


//main graphics function, called to show the game graphics
void Graphics()
{
  Background();
  for (Solid s : solids)
  {    
    s.Show();
  }
  desactiveAnimations = new ArrayList<Animator>();
  for (Animator animator : activeAnimations)
  {
    animator.anim.Animator(animator);
  } 
  activeAnimations.remove(desactiveAnimations);
}


private void Background()
{
  image(image_background, -1000, -1000, 1000, 1000);
  image(image_background, -1000, 0, 1000, 1000);
  image(image_background, -1000, 1000, 1000, 1000);
  image(image_background, 0, -1000, 1000, 1000);
  image(image_background, 0, 0, 1000, 1000);
  image(image_background, 0, 1000, 1000, 1000);
  image(image_background, 1000, -1000, 1000, 1000);
  image(image_background, 1000, 0, 1000, 1000);
  image(image_background, 1000, 1000, 1000, 1000);
}


//main animation class that make the basic animation system
public class Animation
{
  PVector pos;
  Object[] sprites;  
  int speed, counter, animCounter;
  boolean playing;

  public Animation(int speed, Object... sprites)
  {
    this.speed = 20 - speed;
    this.sprites = sprites;
  }

  public void Play(PVector pos)
  {
    if (!playing)
    {
      playing = true;
      this.pos = pos;
    } else
      println("already playing this animation!");
  } 

  public void Animator(Animator a)
  {
    if (!playing) return;

    image((PImage)sprites[animCounter], pos.x, pos.y);

    if ((counter % speed) == 0)
    { 
      animCounter++;
      if (animCounter >= sprites.length) 
      {
        desactiveAnimations.add(a);
        playing = false;
        animCounter = 0;
        counter = 0;
        return;
      }
    } 
    counter++;
  }
}
