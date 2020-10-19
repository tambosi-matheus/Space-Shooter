import java.io.*; 
import java.util.List; 
import java.util.ArrayList;

enum GameStates {
  MENU, MAIN, ENDSCREEN
};
private GameStates gameState = GameStates.MENU;

void setup()
{
  fullScreen(P3D);
  SetSize(); 
  SetGraphics();
  SetAudio();
  SetMenu();
}

void draw()
{
  Mouse();
  switch(gameState)
  {
  case MENU:    
    MenuUpdate();
    break;
  case MAIN:    
    MainUpdate();
    Debug();
    break;
  case ENDSCREEN:    
    EndscreenUpdate();
    break;
  }   
  CursorImage();
}
