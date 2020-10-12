public static PVector size;

public PVector camera = new PVector(0, 0), camDesiredPos;

public ArrayList<Animator> activeAnimations, desactiveAnimations;

//create image variables here ('image_' prefix)
public PImage 
  image_player_left, image_player_middle, image_player_right, image_player_bullet, 
  image_cursor, image_background, 
  image_explosion_0, image_explosion_1, image_explosion_2, image_explosion_3, 
  image_explosion_4, image_explosion_5, image_explosion_6, image_explosion_7,
  image_enemy_small, image_enemy_medium, image_enemy_big;

public ArrayList<PImage> explosion, player_bullet;

//class that every animation should derive from
//as all game animations graphic arrays are managed based on 
abstract class Animator {public Animation anim;}

//basic graphics function called on the processing setup
//use here to load imaged, set constants and change primitive behaviours
void SetGraphics()
{
  camera = new PVector(size.x/2, size.y/2);
  camDesiredPos = camera;
  rectMode(CENTER);
  imageMode(CENTER);

  activeAnimations = new ArrayList<Animator>();
  desactiveAnimations = new ArrayList<Animator>();

  image_player_left = loadImage("images/player left.png");
  image_player_middle = loadImage("images/player middle.png");
  image_player_right = loadImage("images/player right.png");   
  image_player_bullet = loadImage("images/player bullet.png");
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
  image_enemy_small = loadImage("images/enemy small.png");
  image_enemy_medium = loadImage("images/enemy medium.png");
  image_enemy_big = loadImage("images/enemy big.png");


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

public void SetSize(int howManyBg, float bgSize)
{
  size = new PVector((howManyBg * bgSize), (howManyBg * bgSize));
}

//main graphics function, called to show the game graphics
void Graphics()
{
  Background(howManyBackgrounds, bgSize);
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

private void Background(int howManyBg, float bgSize)
{  
  imageMode(CORNER);
  for(int x = 0; x < howManyBg; x++)
  {
    for(int y = 0; y < howManyBg; y++)
    {
      image(image_background, (x * bgSize), (y * bgSize), bgSize, bgSize);
    }
  }
  imageMode(CENTER);  
}

public void Camera()
{   
  PVector nextCamPos = PVector.lerp(camera, camDesiredPos, 0.05);
  if(0 + width/2 < nextCamPos.x && nextCamPos.x < size.x - width/2)
    camera.x = nextCamPos.x;
  if(0 + height/2 < nextCamPos.y && nextCamPos.y < size.y - height/2)    
      camera.y = nextCamPos.y;  
  camera(camera.x,camera.y, (height/2.0) / tan(PI*30.0 / 180.0), camera.x, camera.y, 0, 0, -1, 0); 
}


//main animation class that make the basic animation system
public class Animation
{
  private PVector pos;
  private Object[] sprites;  
  private int speed, counter, animCounter;
  private boolean playing;

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
    }
  } 

  public void Animator(Animator a)
  {
    if (!playing) return;

    if ((counter % speed) == 0)
    { 
      animCounter++;
      if (animCounter >= sprites.length) 
      {       
        desactiveAnimations.add(a);                 
        return;
      }
    } 
    counter++;
    image((PImage)sprites[animCounter], pos.x, pos.y);
  }
}
