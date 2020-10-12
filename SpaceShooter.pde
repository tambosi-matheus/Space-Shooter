import java.io.*; 
import java.util.List; 
import java.util.ArrayList;
import java.math.*;

// arrays with game objects
ArrayList<Solid> solids;
ArrayList<Solid> addSolids, removeSolids;

// set the game canva size
// note that the background quantity is for both x and y, so a size 3 means 3x3
// bgSize sets each background size
// for example, howMany = 3 and bgSize = 100 means a 300x300 canvas
int howManyBackgrounds = 3, bgSize = 500;

Player player;

// two main time variables
// delta time gives the amount of time passed between each update
// time gives the time past since the start of the program
float deltaTime;
float time;

void setup()
{
  size(900, 900, P3D);
  SetSize(howManyBackgrounds, bgSize);
  SetGraphics();
  spawns = Util.SetEnemySpawns();
  
  solids = new ArrayList<Solid>();  
  addSolids = new ArrayList<Solid>();
  removeSolids = new ArrayList<Solid>();
  player = new Player();
  solids.add(player);

}

void draw()
{    
  Mouse();
  MainUpdate();  
  Debug();
}
