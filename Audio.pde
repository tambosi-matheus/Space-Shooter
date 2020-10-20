import processing.sound.*;

int audioOption = 2;

Sound s;

SoundFile audio_main_background, audio_menu, audio_endscreen_best_score, audio_endscreen_death,
          audio_player_shooting,
          audio_enemy_big_death, audio_enemy_big_spawn,
          audio_enemy_medium_death, audio_enemy_medium_shot, 
          audio_enemy_small_death, audio_enemy_small_explosion;
ArrayList<Sound> sounds;



void SetAudio() 
{
  s = new Sound(this);  
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



}

void Audio() 
{  

  if(key2)
    s.volume(1);
}
