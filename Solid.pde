public abstract class Solid
{  
  public PVector pos = new PVector(0, 0);
  public float collWidth = 0, collHeight = 0;
  
  //main method for non-static objects, use to update
  //position, velocity, angle, etc
  public void Update(){};
  
  
  public void Collision(ArrayList<Solid> grid){};
  
  //use this if the object doesnt have animation
  //if it has, leave this blank
  public void Show(){};
}

public class Collision
{  
 public Solid[] solidsInCollision;
 
 Collision(Solid... solids)
 {
    solidsInCollision = solids;
 }
}
