public abstract class Solid
{  
  protected PVector pos = new PVector(), vel = new PVector();
  public float collRadius;
  
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
