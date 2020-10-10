void MainUpdate()
{
  clear();
  addSolids = new ArrayList<Solid>();
  removeSolids = new ArrayList<Solid>();
  deltaTime = (millis() - time)/100;
  time = millis();
  
  //main solid loop
  for(Solid s : solids)
  {   
      s.Update();     
  }
  
  for(Solid s : solids)
  {   
      s.Collision();     
  }
  
  solids.remove(removeSolids);
  for(Solid s : addSolids)
  {
    solids.add(s);  
  }
  
  //collision check
  
  
  Graphics();
}
