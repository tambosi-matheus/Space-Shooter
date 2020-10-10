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
 
   //Util.IterateCollisionList(Util.CreateCollisionGrid(solids, 4));
   ArrayList<ArrayList<Solid>> sa = new ArrayList<ArrayList<Solid>>();
   sa.add(solids);
   Util.IterateCollisionList(sa);
  
  solids.remove(removeSolids);
  for(Solid s : addSolids)
  {
    solids.add(s);  
  }
  
  //collision check
  
  
  Graphics();
}
