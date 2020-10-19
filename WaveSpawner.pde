ArrayList<Solid> addInWave;
int waveEnemies;
float baseIncrement = 100, wavePoints;

public void SetWave()
{
  baseIncrement += random(baseIncrement/10);
  wavePoints += baseIncrement + random(-1, 1) * baseIncrement/2;

  while (wavePoints > 0)
  {
    float i = random(10);
    if (i < 4) addSolids.add(new SmallEnemy());
    else if (i < 9.5) addSolids.add(new MediumEnemy());
    else addSolids.add(new BigEnemy());
    wavePoints -= i;
  }
}

public void WaveUpdate()
{  
  GetEnemiesInWave();
  if (waveEnemies > 0) return;
  SetWave();
}

private void GetEnemiesInWave()
{
  waveEnemies = 0;
  for (Solid s : solids)
  {
    if (s.getClass().toGenericString().equals("public class SpaceShooter$SmallEnemy")||
      s.getClass().toGenericString().equals("public class SpaceShooter$MediumEnemy")||
      s.getClass().toGenericString().equals("public class SpaceShooter$BigEnemy")) 
      waveEnemies++;
  }
}
