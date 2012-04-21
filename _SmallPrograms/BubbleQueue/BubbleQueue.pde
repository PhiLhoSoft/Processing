class Bubble
{
  float diam;
  float x;
  float y;
   
  Bubble()
  {
    diam = random(80);
    x = random(diam / 2, width - diam / 2);
    y = height / 2;
  }    
  void draw() // Not the global draw!
  {
    fill(88, 22, 133, 6);
    ellipse(x, y, diam, diam);
  }
}
 
ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
 
void setup() 
{
  size(200, 100);
  background(255);
  smooth();
}
 
void draw() 
{
  background(255);
  if (frameCount % 4 == 0)
  {
    // Add a new bubble every 4 frames
    bubbles.add(new Bubble());
  }
  for (Bubble bubble : bubbles)
  {
    bubble.draw();
  }
  if (bubbles.size() > 10 && frameCount % 4 == 2)
  {
    // Once we have enough bubbles, start removing them,
    // removing the oldest one every 4 frames
    bubbles.remove(0);
  }
} 

