public static class Util
{
 public static ArrayList<ArrayList<Solid>> CreateCollisionGrid(ArrayList<Solid> generalArray, int gridSize)
 {
   ArrayList<Solid> arrayClone = (ArrayList)generalArray.clone();
   ArrayList<Solid> toRemoveArray = (ArrayList)generalArray.clone();
   
   ArrayList<ArrayList<Solid>> collArrays = new ArrayList<ArrayList<Solid>>();
   
   for(int x = 0; x < gridSize; x++)
   {
     for(int y = 0; y < gridSize; y++)
     {
       ArrayList<Solid> array = new ArrayList<Solid>();
       for(Solid obj : arrayClone)
       {
         if((size.x/gridSize * x) < obj.pos.x && obj.pos.x < (size.x/gridSize * (x + 1)))
         {
           if((size.y/gridSize * y) < obj.pos.y && obj.pos.y < (size.y/gridSize * (y + 1)))
           {
             array.add(obj);
             toRemoveArray.add(obj);
           }
         }
       }
       collArrays.add(array);
     }     
   }   
   return collArrays;
 }
 
 public static void IterateCollisionList(ArrayList<ArrayList<Solid>> grid)
 {
   for(ArrayList<Solid> cell : grid)
   {
    for(Solid s : cell)
    {
      s.Collision(cell); 
    }
   }
 }
 
 public static boolean CheckCollision(PVector pos1, float w1,float h1, PVector pos2, float w2, float h2)
 {
    if(pos1.x + w1/2 > pos2.x - w2/2 && 
        pos1.x - w1/2 < pos2.x + w2/2 &&
        pos1.y + h1/2 > pos2.y - h2/2 && 
        pos1.y - h1/2 < pos2.y + h2/2)
    {
     return true;
    }
    else return false;
 }
}
