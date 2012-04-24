int SIZE_W = 100;
int SIZE_H = 200;

void setup()
{
  size(500, 500);
  smooth();
  noStroke();
}

void draw()
{
  background(255);
  float r = getR();
  if (r < 1) fill(#FF0000); else fill(#AABB00);
  ellipse(width / 2, height / 2, SIZE_W, SIZE_H);
}

float getR()
{
  float hw = SIZE_W / 2;
  float hh = SIZE_H / 2;
  float dX = width / 2 - mouseX;
  float dY = height / 2 - mouseY;
  float r = dX * dX / hw / hw + dY * dY / hh / hh;
  return r;
}

