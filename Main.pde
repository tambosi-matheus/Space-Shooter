void MainUpdate()
{
  clear();
  //
  addSolids = new ArrayList<Solid>();
  removeSolids = new ArrayList<Solid>();
  deltaTime = (millis() - time)/100;
  time = millis();
  
  // main game objects loop
  for(Solid s : solids)
  {   
      s.Update();     
  }
 
   // collision check
   Util.IterateCollisionList(Util.CreateCollisionGrid(solids, 40));

  if(random(1) < 0.05)
    addSolids.add(new Enemy());
  
  // graphics loop
  Graphics();
  
  // game objects array maneuvering
  solids.removeAll(removeSolids);
  for(Solid s : addSolids)
  {
    solids.add(s);  
  }
  
}
