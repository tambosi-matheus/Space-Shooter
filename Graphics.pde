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

  image_enemy_explosion_0, image_enemy_explosion_1, image_enemy_explosion_2, image_enemy_explosion_3, 
  image_enemy_explosion_4, image_enemy_explosion_5, image_enemy_explosion_6, image_enemy_explosion_7, 

  image_player_explosion_0, image_player_explosion_1, image_player_explosion_2, image_player_explosion_3, 
  image_player_explosion_4, image_player_explosion_5, image_player_explosion_6, image_player_explosion_7, 
  image_player_explosion_8, image_player_explosion_9, image_player_explosion_10, image_player_explosion_11, 
  image_player_explosion_12, image_player_explosion_13, image_player_explosion_14, image_player_explosion_15, 
  image_player_explosion_16, image_player_explosion_17, image_player_explosion_18, image_player_explosion_19, 
  image_player_explosion_20, image_player_explosion_21, 

  image_enemy_small, image_enemy_medium, image_enemy_big, image_enemy_medium_bullet, 
  image_sound;

public ArrayList<PImage> enemy_explosion, player_explosion;

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
  noCursor();    
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  activeAnimations = new ArrayList<Animator>();
  desactiveAnimations = new ArrayList<Animator>();

  SetImageData();  
  textFont(font, 14);

  enemy_explosion = new ArrayList<PImage>();
  enemy_explosion.add(image_enemy_explosion_0);
  enemy_explosion.add(image_enemy_explosion_1);
  enemy_explosion.add(image_enemy_explosion_2);
  enemy_explosion.add(image_enemy_explosion_3);
  enemy_explosion.add(image_enemy_explosion_4);
  enemy_explosion.add(image_enemy_explosion_5);
  enemy_explosion.add(image_enemy_explosion_6);
  enemy_explosion.add(image_enemy_explosion_7);

  player_explosion = new ArrayList<PImage>();
  player_explosion.add(image_player_explosion_0);
  player_explosion.add(image_player_explosion_1);
  player_explosion.add(image_player_explosion_2);
  player_explosion.add(image_player_explosion_3);
  player_explosion.add(image_player_explosion_4);
  player_explosion.add(image_player_explosion_5);
  player_explosion.add(image_player_explosion_6);
  player_explosion.add(image_player_explosion_7);
  player_explosion.add(image_player_explosion_8);
  player_explosion.add(image_player_explosion_9);
  player_explosion.add(image_player_explosion_10);
  player_explosion.add(image_player_explosion_11);
  player_explosion.add(image_player_explosion_12);
  player_explosion.add(image_player_explosion_13);
  player_explosion.add(image_player_explosion_14);
  player_explosion.add(image_player_explosion_15);
  player_explosion.add(image_player_explosion_16);
  player_explosion.add(image_player_explosion_17);
  player_explosion.add(image_player_explosion_18);
  player_explosion.add(image_player_explosion_19);
  player_explosion.add(image_player_explosion_20);
  player_explosion.add(image_player_explosion_21);
}

//--------------------------------------------------------------------------------//

public void SetSize()
{
  howManyBackgrounds = (int)(width * 1.5 / bgSize);
  size = new PVector((howManyBackgrounds * bgSize), (howManyBackgrounds * bgSize));
}

//--------------------------------------------------------------------------------//

void CursorImage()
{  
  pushMatrix();
  switch(gameState)
  {
  case MAIN:
    translate(mouse.x, mouse.y);
    if (mouseRight)
      image(image_cursor1, 0, 0);
    else
      image(image_cursor2, 0, 0);
    break;

  default:
    translate((camera.x - width/2 + mouseX), (camera.y - height/2 + mouseY));
    if (mouseLeft || mouseRight)
      image(image_cursor1, 0, 0);
    else
      image(image_cursor2, 0, 0);
    break;
  }
  popMatrix();
}

//--------------------------------------------------------------------------------//

public void MenuGraphics()
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
  scale(-1, -1);
  fill(255, 255, 255);
  textSize(20);
  text("Score: " + score, 10, 0);
  popMatrix();

  activeAnimations.removeAll(desactiveAnimations);
}

//--------------------------------------------------------------------------------//

public void EndscreenGraphics()
{
  Background(howManyBackgrounds, bgSize); 
  pushMatrix();
  translate(camera.x, camera.y);
  image(image_menu_logo, titlePos.x, titlePos.y, 450, 75);  
  fill(255, 255, 255);
  textSize(80);
  text("You scored " + score, 0, 0);
  textSize(50);
  text("Max Score " + highScore, 0, 200);
  textSize(20);
  text("Press 'R' to try again!", 0, 300);
  popMatrix();
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
  if (gameState != GameStates.MAIN) return;
  PVector playerMousePointing = PVector.sub(mouse, player.pos);
  float mag = constrain(playerMousePointing.mag(), 1, 100);
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
