void Debug()
{
  println("Solids: " + solids.size());
  
  rectMode(CENTER);
  fill(0, 0, 255);
  rect(mouse.x, mouse.y, 200, 200);
  
}

public void CheckDebugKeys()
{
  if(keyCode == '`')
    keyDebug = !keyDebug;
  if(keyCode == '1')
  {
    
  }
  
}
