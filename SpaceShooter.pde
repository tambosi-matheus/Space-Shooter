// arrays with game objects
ArrayList<Solid> solids;
ArrayList<Solid> addSolids, removeSolids;

Player player;

float deltaTime;
float time;

void setup()
{
  size(500, 500, P3D);
  SetGraphics();
  
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
}
