public static class Util
{
 public static ArrayList<ArrayList<Solid>> CreateGridCollision(ArrayList<Solid> generalArray, int gridSize)
 {
   ArrayList<Solid> arrayClone = (ArrayList)generalArray.clone();
   ArrayList<Solid> toRemoveArray = (ArrayList)generalArray.clone();
   
   ArrayList<ArrayList<Solid>> collArrays = new ArrayList<ArrayList<Solid>>();
   
   for(int x = 0; x < gridSize; x++)
   {
     for(int y = 0; y < gridSize; y++)
     {
       ArrayList<Solid> a = new ArrayList<Solid>();
       for(Solid obj : arrayClone)
       {
         if((size.x/gridSize * x) < obj.pos.x && obj.pos.x < (size.x/gridSize * (x + 1)))
         {
           if((size.y/gridSize * y) < obj.pos.y && obj.pos.y < (size.y/gridSize * (y + 1)))
           {
             a.add(obj);
             toRemoveArray.add(obj);
           }
         }
       }
       collArrays.add(a);
     }     
   }   
   return collArrays;
 }
 
 public static void CheckCollisions(ArrayList<Solid> solids)
 {
   
 }
}
