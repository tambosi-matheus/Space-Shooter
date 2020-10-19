void Debug()
{
  //ShowSolidsDebug();
  //ShowMousePlayerPointer();
  //ShowCollisionGrid(4);
  //ShowCameraDebug();
}

//--------------------------------------------------------------------------------//

public void CheckDebugKeys()
{
  if (keyCode == '`')
    keyDebug = !keyDebug;
  if (keyCode == '1')
  {
  }
}

//--------------------------------------------------------------------------------//

public void ShowCollisionGrid(int gridSize)
{    
  for (int x = 0; x < gridSize; x++)
  {
    stroke(255, 255, 255);
    strokeWeight(1);
    line((size.x/gridSize * x), size.y, 0, (size.x/gridSize * x + 1), 0, 0);
  }  
  for (int y = 0; y < gridSize; y++)
  {
    stroke(255, 255, 255);
    strokeWeight(1);
    line(size.x, (size.x/gridSize * y), 0, 0, (size.x/gridSize * y + 1), 0);
  }
}

//--------------------------------------------------------------------------------//

public void ShowMousePlayerPointer()
{
  stroke(255, 255, 0);
  strokeWeight(1);
  line(mouse.x, mouse.y, 0, player.pos.x, player.pos.y, 0);
}

//--------------------------------------------------------------------------------//

public void ShowSolidsDebug()
{
  println("--------------------------------");
  println("Frame " + frameCount);
  println("Delta Time " + deltaTime);
  println("Active Solids: " + solids.size());
  println("Solids Added: " + addSolids.size());
  println("Solids Removed: " + removeSolids.size()); 
}

//--------------------------------------------------------------------------------//

public void ShowCameraDebug()
{
  //camera position
  fill(0, 255, 0);
  circle(camera.x, camera.y, 5);  
  
  //camera desired position
  fill(255, 0, 0);
  circle(camDesiredPos.x, camDesiredPos.y, 5);
}
