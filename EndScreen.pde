public void SetEndscreen()
{
  if(score > highScore)
  { 
    highScore = score;
    audio_endscreen_best_score.play(); 
  }
  else
    audio_endscreen_death.play();
  camera = new PVector(width/2, height/2);
  camDesiredPos = camera;
  camera(camera.x, camera.y, ((height/2.0) / tan(PI*30.0 / 180.0)), camera.x, camera.y, 0, 0, 1, 0);
}

public void EndscreenUpdate()
{
  clear();
  EndscreenGraphics();
  if(keyR)
  {
    if(audio_endscreen_best_score.isPlaying())
      audio_endscreen_best_score.stop();
    else if(audio_endscreen_death.isPlaying())
      audio_endscreen_death.stop();
    ChangeGameState(GameStates.MENU);
  }
}
