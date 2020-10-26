// two main time variables
// delta time gives the amount of time passed between each update (frame)
// time gives the time past since the start of the program
float deltaTime, time;
int score, highScore = -1, gridSize = 10;

void SetMain()
{
  score = 0;
  solids = new ArrayList<Solid>();  
  addSolids = new ArrayList<Solid>();
  removeSolids = new ArrayList<Solid>();
  player = new Player();
  solids.add(player);
  camera = player.pos.copy();
  if (audio_main_background != null)audio_main_background.stop();
  audio_main_background = new SoundFile(this, "audio/background" + (int)random(1, 6) + ".wav");
  audio_main_background.loop(1, 0.15f);
}

void MainUpdate()
{
  clear();
  addSolids = new ArrayList<Solid>();
  removeSolids = new ArrayList<Solid>();
  deltaTime = (millis()- time)/100;
  time = millis();

  for (Solid s : solids)
  {   
    s.Update();
  }

  // collision check
  Util.IterateCollisionList(Util.CreateCollisionGrid(solids, gridSize));

  MainGraphics();

  WaveUpdate();
  
  removeSolids.addAll(Util.RemoveExternalSolids(solids));

  // game objects array maneuvering
  solids.removeAll(removeSolids);
  for (Solid s : addSolids)
  {
    solids.add(s);
  }
}
