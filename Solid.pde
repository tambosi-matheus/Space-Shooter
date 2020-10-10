public abstract class Solid
{  
  public PVector pos;
  
  //main method for non-static objects, use to update
  //position, velocity, angle, etc
  public void Update(){};
  
  
  public void Collision(){};
  
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
