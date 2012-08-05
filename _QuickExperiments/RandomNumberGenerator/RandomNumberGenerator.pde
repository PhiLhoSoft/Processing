// That's also the seed!
float currentRandom = 0.1717;
 
int NB = 100;
float[] handRandom = new float[NB];
float[] procRandom = new float[NB];
 
float interval;
 
void setup()
{
  size(800, 400);
  smooth();
  noStroke();
  
  interval = width / NB / 2;
  println(interval);
}
 
void draw()
{
  background(255);
  
  // Add a new item with our generator
  int rndH = int(getRandom(0, NB));
//  println(rndH);
  handRandom[rndH]++;
  // Add a new item with the Processing's generator
  int rndP = int(random(NB));
  procRandom[rndP]++;
  if (handRandom[rndH] == height || procRandom[rndP] == height)
    noLoop(); // Stop
  
  for (int i = 0; i < NB; i++)
  {
    fill(#55AAFF);
    rect(interval * (2 * i), height - handRandom[i], interval, handRandom[i]);
    
    fill(#FFEE55);
    rect(interval * (2 * i + 1), height - procRandom[i], interval, height);
  }
}
 
/** Returns a random number between 0 (included) and 1 (excluded). */
float getRandom()
{
  currentRandom = sq(PI / (currentRandom + 1)) % 1;
  return currentRandom;
}
 
float getRandom(float a, float b)
{
  return (b - a) * getRandom() + a;
}

