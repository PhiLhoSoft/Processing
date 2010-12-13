PVector point1, point2;
boolean bFirst = true;

void setup()
{
  size(800, 800);
  point1 = new PVector(width/5, width/3);
  point2 = new PVector(4*width/5, 2*width/3);
}

void draw()
{
  background(#ABCDEF);
  
  // Draw main vector
  stroke(#002244);
  strokeWeight(3);
  line(point1.x, point1.y, point2.x, point2.y);
  ellipse(point1.x, point1.y, 7, 7);
  
  // Compute perpendicular vector: (y, -x)
  PVector perp = new PVector(point2.y - point1.y, point1.x - point2.x);
  // Length 1
  perp.normalize();
  // Length to n pixels
  perp.mult(100);  // Put 10 for 10 pixels
  // Move to point1
  perp.add(point1);
  // Draw it
  stroke(#AA2244);
  strokeWeight(2);
  line(point1.x, point1.y, perp.x, perp.y);
}

void mousePressed()
{
  if (bFirst)
  {
    point1 = new PVector(mouseX, mouseY);
  }
  else
  {
    point2 = new PVector(mouseX, mouseY);
  }
  bFirst = !bFirst;
}
void mouseDragged()
{
}
void mouseReleased()
{
}

void keyReleased()
{
}
