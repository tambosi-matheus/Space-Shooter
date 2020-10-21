import processing.sound.*;

int audioOption = 2;

Sound s;

SoundFile audio_main_background, audio_menu, audio_endscreen_best_score, audio_endscreen_death,
          audio_player_shooting, audio_player_death,
          
          audio_enemy_big_death, audio_enemy_big_spawn,
          audio_enemy_medium_death, audio_enemy_medium_shot, 
          audio_enemy_small_death, audio_enemy_small_explosion;
          
ArrayList<Sound> sounds;

void SetAudio() 
{
  s = new Sound(this);  
  SetAudioData();
}

void Audio() 
{  

}
