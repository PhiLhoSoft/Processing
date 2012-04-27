int x1, y1;
int x2, y2;
boolean bFirst = true;
final float DIST = 20;
final float FACTOR = 0.6;

void setup()
{
  size(500, 500);
  smooth();
}

void draw()
{
  background(255);
  if (bFirst)
  {
    stroke(0);
    line(x1, y1, x2, y2);

    float lineLength = dist(x1, y1, x2, y2);
    float pointNb = lineLength / DIST;

    // First find out where to put the lines  
    fill(#FF5555, 64);
    noStroke();
    float dx = (x2 - x1) / pointNb;
    float dy = (y2 - y1) / pointNb;
    for (int i = 0; i < pointNb; i++)
    {
      ellipse(x1 + dx * i, y1 + dy * i, 8, 8);
    }
    
    stroke(0);
    for (int i = 1; i < pointNb; i++)
    {
      float px = x1 + dx * i;
      float py = y1 + dy * i;
      line(px + dy * FACTOR, py - dx * FACTOR, px - dy * FACTOR, py + dx * FACTOR);
    }
  }
}

void mousePressed()
{
  if (bFirst)
  {
    x1 = mouseX;
    y1 = mouseY;
  }
  else
  {
    x2 = mouseX;
    y2 = mouseY;
  }
  bFirst = !bFirst;
}

