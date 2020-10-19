// two main time variables
// delta time gives the amount of time passed between each update (frame)
// time gives the time past since the start of the program
float deltaTime;
float time;
float score;

void SetMain()
{
  solids = new ArrayList<Solid>();  
  addSolids = new ArrayList<Solid>();
  removeSolids = new ArrayList<Solid>();
  player = new Player();
  solids.add(player);
  audio_main_background = new SoundFile(this, "audio/background" + (int)random(1, 6) + ".wav");
  audio_main_background.loop(1, 0.15f);
}

void MainUpdate()
{
  clear();
  //
  addSolids = new ArrayList<Solid>();
  removeSolids = new ArrayList<Solid>();
  deltaTime = (millis()- time)/100;
  time = millis();

  // main game objects loop
  for (Solid s : solids)
  {   
    s.Update();
  }

  // collision check
  Util.IterateCollisionList(Util.CreateCollisionGrid(solids, 40));

  //if (random(1) < 0.03)
    //addSolids.add(new MediumEnemy());

  // graphics loop
  MainGraphics();
  
  // audio loop
  Audio();
  
  WaveUpdate();
  
  // game objects array maneuvering
  solids.removeAll(removeSolids);
  for (Solid s : addSolids)
  {
    solids.add(s);
  }    
}
