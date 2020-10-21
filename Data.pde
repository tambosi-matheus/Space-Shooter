public void SetImageData()
{
  font = createFont("fonts/karma suture.ttf", 100);
  image_background = loadImage("images/background.png");
  image_menu_logo = loadImage("images/menu_logo.png");
  image_menu_play = loadImage("images/menu_play.png");
  image_menu_controls = loadImage("images/menu_controls.png");
  image_menu_madeby = loadImage("images/menu_madeby.png"); 

  image_cursor1 = loadImage("images/crosshair1.png");
  image_cursor2 = loadImage("images/crosshair2.png");

  image_player_left = loadImage("images/player/player left.png");
  image_player_middle = loadImage("images/player/player middle.png");
  image_player_right = loadImage("images/player/player right.png");   
  image_player_bullet = loadImage("images/player/player bullet.png");

  image_enemy_explosion_0 = loadImage("images/enemies/enemy explosion 0.png");
  image_enemy_explosion_1 = loadImage("images/enemies/enemy explosion 1.png");
  image_enemy_explosion_2 = loadImage("images/enemies/enemy explosion 2.png");
  image_enemy_explosion_3 = loadImage("images/enemies/enemy explosion 3.png");
  image_enemy_explosion_4 = loadImage("images/enemies/enemy explosion 4.png");
  image_enemy_explosion_5 = loadImage("images/enemies/enemy explosion 5.png");
  image_enemy_explosion_6 = loadImage("images/enemies/enemy explosion 6.png");
  image_enemy_explosion_7 = loadImage("images/enemies/enemy explosion 7.png");
  
  image_player_explosion_0 = loadImage("images/player/player explosion 0.png");
  image_player_explosion_1 = loadImage("images/player/player explosion 1.png");
  image_player_explosion_2 = loadImage("images/player/player explosion 2.png");
  image_player_explosion_3 = loadImage("images/player/player explosion 3.png");
  image_player_explosion_4 = loadImage("images/player/player explosion 4.png");
  image_player_explosion_5 = loadImage("images/player/player explosion 5.png");
  image_player_explosion_6 = loadImage("images/player/player explosion 6.png");
  image_player_explosion_7 = loadImage("images/player/player explosion 7.png");
  image_player_explosion_8 = loadImage("images/player/player explosion 8.png");
  image_player_explosion_9 = loadImage("images/player/player explosion 9.png");
  image_player_explosion_10 = loadImage("images/player/player explosion 10.png");
  image_player_explosion_11 = loadImage("images/player/player explosion 11.png");
  image_player_explosion_12 = loadImage("images/player/player explosion 12.png");
  image_player_explosion_13 = loadImage("images/player/player explosion 13.png");
  image_player_explosion_14 = loadImage("images/player/player explosion 14.png");
  image_player_explosion_15 = loadImage("images/player/player explosion 15.png");
  image_player_explosion_16 = loadImage("images/player/player explosion 16.png");
  image_player_explosion_17 = loadImage("images/player/player explosion 17.png");
  image_player_explosion_18 = loadImage("images/player/player explosion 18.png");
  image_player_explosion_19 = loadImage("images/player/player explosion 19.png");
  image_player_explosion_20 = loadImage("images/player/player explosion 20.png");
  image_player_explosion_21 = loadImage("images/player/player explosion 21.png");

  image_enemy_small = loadImage("images/enemies/enemy small.png");
  image_enemy_medium = loadImage("images/enemies/enemy medium.png");
  image_enemy_medium_bullet = loadImage("images/enemies/enemy medium bullet.png");
  image_enemy_big = loadImage("images/enemies/enemy big.png"); 
}

public void SetAudioData()
{
  audio_menu = new SoundFile(this, "audio/mainscreen.wav");
  audio_menu.amp(0.1f);
  
  audio_endscreen_best_score = new SoundFile(this, "audio/endscreen_best_score.wav");
  audio_endscreen_best_score.amp(0.1f);
  audio_endscreen_death = new SoundFile(this, "audio/endscreen_death.wav");
  audio_endscreen_death.amp(0.1f);
  
  audio_enemy_big_death = new SoundFile(this, "audio/enemy_big_death.wav");
  audio_enemy_big_death.amp(0.2f);
  audio_enemy_big_spawn = new SoundFile(this, "audio/enemy_big_spawn.wav");
  audio_enemy_big_spawn.amp(0.35f);
  audio_enemy_medium_death = new SoundFile(this, "audio/enemy_medium_death.wav");
  audio_enemy_medium_death.amp(0.15f);
  audio_enemy_medium_shot = new SoundFile(this, "audio/enemy_medium_shot.wav");
  audio_enemy_medium_shot.amp(0.2f);
  audio_enemy_small_death = new SoundFile(this, "audio/enemy_small_death.wav");
  audio_enemy_small_death.amp(0.3f);
  audio_enemy_small_explosion = new SoundFile(this, "audio/enemy_small_explosion.wav");
  audio_enemy_small_explosion.amp(0.4f);
  
  audio_player_shooting = new SoundFile(this, "audio/player_shot.wav");
  audio_player_shooting.amp(0.15f);
  audio_player_death = new SoundFile(this, "audio/player_death.wav");
  audio_player_death.amp(1f);
}
