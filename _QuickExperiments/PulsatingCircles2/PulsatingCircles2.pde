int rMove = +5;
int slowDown = 1;
int minRadius = 5, maxRadius = 100;
int radius = minRadius;
int xPos = 200;
int yPos = 200;
color c1 = #005599, c2 = #00AA99;

void setup()
{
  size(400, 400);
}

void draw()
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

void keyPressed()
{
  exit();
}

/*
void draw()
{
  background(240);
  fill(lerpColor(c1, c2, (float) radius / (float) maxRadius));

  rMove = -rMove;
  for (int radius = minRadius; radius <= maxRadius && radius >= minRadius; radius += rMove)
  {
    ellipse(xPos, yPos, radius, radius);
    delay(1000);
  }
}
*/
