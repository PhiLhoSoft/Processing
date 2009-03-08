class Bubble
{
  float diam;
  float x;
  float y;
   
  Bubble()
  {
    diam = random(80);
    x = diam / 2 + random(width - diam);
    y = height / 2;
  }    
  void draw() // Not the global draw!
  {
    fill(132, 22, 88, 6);
    ellipse(x, y, diam, diam);
  }
}
 
ArrayList bubbles;
 
void setup() {
  size(200, 100);
  background(255);
  smooth();
 
  bubbles = new ArrayList();
}
 
void draw() {
  background(255);
  if (frameCount % 4 == 0)
  {
    bubbles.add(new Bubble());
  }
  Iterator it = bubbles.iterator();
  while (it.hasNext())
  {
    Bubble b = (Bubble) it.next();
    b.draw();
  }
  if (bubbles.size() > 10 && frameCount % 4 == 0)
  {
    bubbles.remove(0);
  }
} 

