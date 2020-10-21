public static class Util
{
  public static Util Instance = new Util();

  private Util() {
  };  

  public static ArrayList<ArrayList<Solid>> CreateCollisionGrid(ArrayList<Solid> generalArray, int gridSize)
  {
    ArrayList<Solid> arrayClone = (ArrayList)generalArray.clone();

    ArrayList<ArrayList<Solid>> collArrays = new ArrayList<ArrayList<Solid>>();

    for (int x = 0; x < gridSize; x++)
    {
      for (int y = 0; y < gridSize; y++)
      {
        ArrayList<Solid> array = new ArrayList<Solid>();
        for (int i = arrayClone.size() - 1; i >= 0; i--)
        {
          Solid obj = arrayClone.get(i);
          if ((size.x/gridSize * x) < obj.pos.x && obj.pos.x < (size.x/gridSize * (x + 1)) &&
            (size.y/gridSize * y) < obj.pos.y && obj.pos.y < (size.y/gridSize * (y + 1)))
          {
            array.add(obj);
            arrayClone.remove(i);
          }
        }
        collArrays.add(array);
      }
    }   
    return collArrays;
  }

  public static void IterateCollisionList(ArrayList<ArrayList<Solid>> grid)
  {
    for (ArrayList<Solid> cell : grid)
    {
      for (Solid solid : cell)
      {
        solid.Collision(cell);
      }
    }
  }

  public static boolean CheckCollision(PVector pos1, float r1, PVector pos2, float r2)
  {
    if (PVector.dist(pos1, pos2) < r1 + r2)    
      return true;

    else return false;
  }

  public static ArrayList<PVector> SetEnemySpawns()
  {
    ArrayList<PVector> s = new ArrayList<PVector>();
    s.add(new PVector(0, 0));
    s.add(new PVector(size.x/2, 0));
    s.add(new PVector(size.x, 0));
    s.add(new PVector(0, size.y/2));
    s.add(new PVector(size.x, size.y));
    s.add(new PVector(0, size.y));
    s.add(new PVector(size.x/2, size.y));
    s.add(new PVector(size.x, size.y));
    return s;
  }
}
