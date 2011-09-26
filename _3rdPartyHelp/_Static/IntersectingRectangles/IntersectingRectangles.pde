float x1, y1, w1, h1;
float x2, y2, w2, h2;

void setup()
{
  size(500, 500);
  noStroke();
  MakeRectangles();
}

void draw()
{
  if (AreIntersecting())
  {
    background(200);
  }
  else
  {
    background(255);
  }
  fill(0x8000FF00);
  rect(x1, y1, w1, h1);
  fill(0x800000FF);
  rect(x2, y2, w2, h2);
}

void MakeRectangles()
{
  float xbr, ybr;
  x1 = random(5, 2*width/3);
  y1 = random(5, 2*height/3);
  xbr = random(x1 + 5, 4*width/5);
  ybr = random(y1 + 5, 4*height/5);
  w1 = xbr - x1;
  h1 = ybr - y1;

  x2 = random(5, 2*width/3);
  y2 = random(5, 2*height/3);
  xbr = random(x2 + 5, width - 5);
  ybr = random(y2 + 5, height - 5);
  w2 = xbr - x2;
  h2 = ybr - y2;
}

boolean AreIntersecting()
{
  return x1 < x2 + w2 && y1 < y2 + h2 &&
      x2 < x1 + w1 && y2 < y1 + h1;
}

void keyPressed()
{
  MakeRectangles();
}

