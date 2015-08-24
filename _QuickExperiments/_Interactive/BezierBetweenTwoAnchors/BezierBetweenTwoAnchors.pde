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
  PVector delta = PVector.sub(a2, a1);
  float w = delta.x;
  float h = delta.y;

  PVector c1 = a1.copy();
  PVector c2 = a2.copy();
  if (abs(w) > abs(h))
  {
    c1.add(FACTOR * w, 0, 0);
    c2.add(-FACTOR * w, 0, 0);
  }
  else
  {
    
    c1.add(0, FACTOR * h, 0);
    c2.add(0, -FACTOR * h, 0);
  }
  
  bezier(
    a1.x, a1.y,
    c1.x, c1.y,
    c2.x, c2.y,
    a2.x, a2.y 
  );
}
