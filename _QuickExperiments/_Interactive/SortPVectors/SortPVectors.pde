int SIZE = 20;
int centerX, centerY;
PVector centerDot;
ArrayList<PVector> dots = new ArrayList<PVector>();

void setup()
{
  size(400, 400);
  centerX = width / 2;
  centerY = height / 2;
  centerDot = new PVector(centerX, centerY);
  
  noStroke();
  smooth();
}

void mousePressed()
{
  PVector dot = new PVector(mouseX, mouseY);
  // Trick: store dist in z to avoid computing it too often
  float d = dot.dist(centerDot);
  dot.z = d;
  dots.add(dot);
}

void keyPressed()
{
  noLoop();
  background(255);
  drawCenter();
  
  float max = dist(0, 0, centerX, centerY);
  // Do the sort
  Collections.sort(dots, new CompareToCenter());
  
  int i = 0;
  int nb = dots.size();
  for (PVector v : dots)
  {
    // This doesn't prove anything!
//    fill(map(v.z, 0, max, 0, 255));
    fill(map(i, 0, nb, 50, 250));
    drawDot(v);
    fill(#00FF00);
    text("" + i, v.x, v.y);
    i++;
  }
}

void draw()
{
  background(255);
  drawCenter();
  
  for (PVector v : dots)
  {
    drawDot(v);
  }
}

void drawDot(PVector dot)
{
  ellipse(dot.x, dot.y, SIZE, SIZE);
}
void drawCenter()
{
  fill(#FF0000);
  ellipse(centerX, centerY, SIZE, SIZE);
  fill(0);
}

class CompareToCenter implements Comparator<PVector>
{
  //@Override
  int compare(PVector v1, PVector v2)
  {
    return int(v1.z - v2.z);
  }
}

