import java.io.*; 
import java.util.List; 
import java.util.ArrayList;

enum GameStates {
  MENU, MAIN, END
};
private GameStates gameState = GameStates.MENU;

void setup()
{
  //size(1000, 1000, P3D);
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
  case END:    
    EndscreenUpdate();
    break;
  }   
  CursorImage();
}
