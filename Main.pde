void MainUpdate()
{
  clear();
  addSolids = new ArrayList<Solid>();
  removeSolids = new ArrayList<Solid>();
  deltaTime = (millis() - time)/100;
  time = millis();
  for(Solid s : solids)
  {   
      s.Update();     
  }
  solids.remove(removeSolids);
  for(Solid s : addSolids)
  {
    solids.add(s);  
  }
  
  
  
  Graphics();
}
