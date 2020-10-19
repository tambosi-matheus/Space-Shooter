PVector soundPos, titlePos, controlsPos, creditsPos, 
  playSize, playMaxSize, playMinSize, soundSize;
boolean mouseUp;

public void SetMenu()
{
  audio_menu.loop();
  playSize = new PVector(120, 40);
  playMaxSize = new PVector(132, 44);
  playMinSize = new PVector(120, 40);
  soundPos = new PVector(width / 5, height/4);
  titlePos = new PVector(0, - height/2 + height/10);
  controlsPos = new PVector(0, + height/4);
  creditsPos= new PVector(0, + height/2 - height/10);
  soundSize = new PVector(32, 32);
  audioOption = 1;
  image_sound = loadImage("images/sound_medium.png");
  s.volume(0.5f);
}

public void MenuUpdate()
{
  clear();
  MenuGraphics();
  if (mouse.x > camera.x - playSize.x/2 && mouse.x < camera.x + playSize.x/2
    && mouse.y > camera.y - playSize.y/2 && mouse.y < camera.y + playSize.y/2)
  {
    if (mouseRight || mouseLeft)
    {
      audio_menu.stop();
      gameState = GameStates.MAIN;
      SetMain();
    }
    playSize = PVector.lerp(playSize, playMaxSize, 0.1);
  } else
    playSize = PVector.lerp(playSize, playMinSize, 0.1);
}

public void MenuSound()
{
  if (mouse.x > camera.x - soundPos.x - 16 && mouse.x < camera.x - soundPos.x + 16
    && mouse.y > camera.y - soundPos.y - 16 && mouse.y < camera.y - soundPos.y + 16)
  {
    audioOption++;
    if (audioOption > 2)
    {        
      audioOption = 0;
      s.volume(0f);
      image_sound = loadImage("images/sound_mute.png");
    } else if (audioOption == 1)
    {          
      s.volume(0.5f);
      image_sound = loadImage("images/sound_medium.png");
    } else if (audioOption == 2)
    {          
      s.volume(1f);
      image_sound = loadImage("images/sound_high.png");
    }

    playSize = PVector.lerp(playSize, playMaxSize, 0.1);
  }
}
