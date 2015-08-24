// Just reusing two old sketches

class FillWithCircles extends DefaultDrawer
{
  int MIN_RAD = 10;
  int MAX_RAD = 100;
  int circleNb;
  int radius;

  FillWithCircles(int radius, int circleNb)
  {
    this.radius = radius;
    this.circleNb = circleNb;
  }

  @Override
  public void draw()
  {
    background(255);
    noStroke();

    int centerX = width / 2;
    int centerY = height / 2;

    for (int i = 0; i < circleNb; i++)
    {
      float d = random(0, radius - MIN_RAD);
      float a = random(0, TWO_PI);
      float x = centerX + d * cos(a);
      float y = centerY + d * sin(a);
      float r = random(MIN_RAD, min(MAX_RAD, radius - d));
      color c = lerpColor(#00FF00, #0000FF, (1 + cos(a))/2);

      fill(c);
      ellipse(x, y, r * 2, r * 2);
    }
  }
}

class PulsatingCircles extends DefaultDrawer
{
  int rMove = +5;
  int slowDown = 1;
  int minRadius = 5, maxRadius = 100;
  int radius = minRadius;
  int xPos = 200;
  int yPos = 200;
  color c1 = #005599, c2 = #00AA99;

  PulsatingCircles() {}

  @Override
  public void draw()
  {
    background(240);
    fill(lerpColor(c1, c2, (float) radius / (float) maxRadius));

    ellipse(xPos, yPos, radius, radius);
    if (frameCount % slowDown == 0)
    {
      radius += rMove;
      if (radius > maxRadius)
        rMove = -1;
      else if (radius < minRadius)
        rMove = +1;
    }
  }
}