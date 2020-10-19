// set the game canva size
// note that the background quantity is for both x and y, so a size 3 means 3x3
// bgSize sets each background size
// for example, howMany = 3 and bgSize = 100 means a 300x300 canvas
int howManyBackgrounds = 5, bgSize = 500;

float scale = 0.8;

public static PVector size;

public PVector camera = new PVector(0, 0), camDesiredPos;

public ArrayList<Animator> activeAnimations, desactiveAnimations;

public PFont font;
//create image variables here ('image_' prefix)
public PImage 
  image_menu_logo, image_menu_madeby, image_menu_controls, image_menu_play,
  image_player_left, image_player_middle, image_player_right, image_player_bullet, 
  image_cursor1, image_cursor2, image_background, 
  image_explosion_0, image_explosion_1, image_explosion_2, image_explosion_3, 
  image_explosion_4, image_explosion_5, image_explosion_6, image_explosion_7, 
  image_enemy_small, image_enemy_medium, image_enemy_big, image_enemy_medium_bullet,
  image_sound;

public ArrayList<PImage> explosion, player_bullet;

//class that every animation should derive from
//as all game animations graphic arrays are managed based on 
abstract class Animator {
  public Animation anim;
}

//--------------------------------------------------------------------------------//

//basic graphics function called on the processing setup
//use here to load imaged, set constants and change primitive behaviours
void SetGraphics()
{
  //camera = new PVector(size.x/2, size.y/2);
  camera = new PVector(width/2, height/2);
  camDesiredPos = camera;
  rectMode(CENTER);
  imageMode(CENTER);

  activeAnimations = new ArrayList<Animator>();
  desactiveAnimations = new ArrayList<Animator>();
  
  font = createFont("fonts/karma suture.ttf", 20);
  textFont(font, 14);

  image_menu_logo = loadImage("images/menu_logo.png");
  image_menu_play = loadImage("images/menu_play.png");
  image_menu_controls = loadImage("images/menu_controls.png");
  image_menu_madeby = loadImage("images/menu_madeby.png"); 
  
  image_player_left = loadImage("images/player left.png");
  image_player_middle = loadImage("images/player middle.png");
  image_player_right = loadImage("images/player right.png");   
  image_player_bullet = loadImage("images/player bullet.png");
  image_cursor1 = loadImage("images/crosshair1.png");
  image_cursor2 = loadImage("images/crosshair2.png");  
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
  image_enemy_medium_bullet = loadImage("images/enemy medium bullet.png");
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

//--------------------------------------------------------------------------------//

public void SetSize()
{
  howManyBackgrounds = (int)(displayWidth * 1.5 / bgSize);
  size = new PVector((howManyBackgrounds * bgSize), (howManyBackgrounds * bgSize));
}

//--------------------------------------------------------------------------------//

void CursorImage()
{
  noCursor();
  pushMatrix();        
   if(gameState == GameStates.MENU)
   {
     translate((camera.x - width/2 + mouseX), (camera.y - height/2 + mouseY));
     if(mouseLeft || mouseRight)
       image(image_cursor1, 0, 0);
     else
       image(image_cursor2, 0, 0);
   }
   else if(gameState == GameStates.MAIN)
   {
     translate(mouse.x, mouse.y);
     if(mouseRight)
       image(image_cursor1, 0, 0);
     else
       image(image_cursor2, 0, 0);
   }
   else if(gameState == GameStates.ENDSCREEN)
   {
     translate((camera.x - width/2 + mouseX), (camera.y - height/2 + mouseY));
     if(mouseLeft || mouseRight)
       image(image_cursor1, 0, 0);
     else
       image(image_cursor2, 0, 0);
   }
 popMatrix();
}

void MenuGraphics()
{
  Background(howManyBackgrounds, bgSize); 
  pushMatrix();
    translate(camera.x, camera.y);
    image(image_menu_logo, titlePos.x, titlePos.y, 450, 75);
    image(image_menu_play, 0, 0, playSize.x, playSize.y);
    image(image_menu_controls, controlsPos.x, controlsPos.y, 400, 25);
    image(image_menu_madeby, creditsPos.x, creditsPos.y, 200, 20);
    image(image_sound, soundPos.x, soundPos.y, soundSize.x, soundSize.y);    
  popMatrix();
  camera(camera.x, camera.y, (height/2.0) / tan(PI*30.0 / 180.0), camera.x, camera.y, 0, 0, 1, 0);
}

//--------------------------------------------------------------------------------//

void MainGraphics()
{
  Camera();
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
  
  pushMatrix();
    translate(camera.x + width/2 - width/20, camera.y + + height/2 - height/20);
    scale(-1,  -1);
    fill(255, 255, 255);    
    text("Score: " + (int)score, 0, 0);
  popMatrix();
  
  activeAnimations.removeAll(desactiveAnimations);
}

//--------------------------------------------------------------------------------//

private void Background(int howManyBg, float bgSize)
{  
  imageMode(CORNER);
  for (int x = 0; x < howManyBg; x++)
  {
    for (int y = 0; y < howManyBg; y++)
    {
      image(image_background, (x * bgSize), (y * bgSize), bgSize, bgSize);
    }
  }
  imageMode(CENTER);
}

//--------------------------------------------------------------------------------//

public void Camera()
{
  PVector playerMousePointing = PVector.sub(mouse, player.pos);
  float mag = constrain(playerMousePointing.mag(), 1, 50);
  camDesiredPos = PVector.add(player.pos, playerMousePointing.normalize().mult(mag));
  PVector nextCamPos = PVector.lerp(camera, camDesiredPos, 0.05);
  if (width/2 + 150 < nextCamPos.x && nextCamPos.x < size.x - width/2 - 150)
    camera.x = nextCamPos.x;
  if (height/2 + 150 < nextCamPos.y && nextCamPos.y < size.y - height/2 - 150)    
    camera.y = nextCamPos.y;  
  camera(camera.x, camera.y, ((height/2.0) / tan(PI*30.0 / 180.0)), camera.x, camera.y, 0, 0, -1, 0);
}

//--------------------------------------------------------------------------------//

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
