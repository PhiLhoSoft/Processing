// [foumula: Define nice Bezier from 2 anchor points? - Processing 2.x and 3.x Forum](http://forum.processing.org/two/discussion/9638/foumula-define-nice-bezier-from-2-anchor-points#latest)
// By Chrisir

final float FACTOR = 0.5;

void setup()
{
  size(600, 500);
  background(255);
  stroke(255, 200, 120);
  strokeWeight(3);
  noFill();
}

void draw()
{
  background(255);

  // anchors
  PVector a1 = new PVector(mouseX, mouseY);
  PVector a2 = new PVector(width / 2, height / 2);

  drawBezier (a1, a2);
}

void drawBezier(PVector a1, PVector a2)
{
  float w = a2.x - a1.x;
  float h = a2.y - a1.y;

  if (abs(w) < 4 || abs(h) < 4)
  {
    line(a1.x, a1.y, a2.x, a2.y);
    return;
  }
  
  PVector c1 = new PVector();
  PVector c2 = new PVector();
  if (abs(w) > abs(h))
  {
    c1.x = a1.x + FACTOR * w;
    c1.y = a1.y;
    c2.x = a2.x - FACTOR * w;
    c2.y = a2.y;
  }
  else
  {
    c1.x = a1.x;
    c1.y = a1.y + FACTOR * h;
    c2.x = a2.x;
    c2.y = a2.y - FACTOR * h;
  }
  
  bezier(
    a1.x, a1.y,
    c1.x, c1.y,
    c2.x, c2.y,
    a2.x, a2.y 
  );
}
