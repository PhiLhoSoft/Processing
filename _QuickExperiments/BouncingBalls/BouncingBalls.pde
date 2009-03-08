int radius1 = 23, radius2 = 31;
int speedX1 = -5, speedX2 = 7, speedY1 = 8, speedY2 = -3;
int posX1 = 20, posX2 = 120, posY1 = 50, posY2 = 150;

void setup()
{
  size(600, 400);
  smooth();
  noStroke();
}

void draw()
{
  background(#AAFFEE);
  MoveBall1();
  MoveBall2();
  DrawBall1();
  DrawBall2();
}

void MoveBall1()
{
  posX1 += speedX1;
  if (posX1 < radius1 || posX1 > width - radius1)
  {
    speedX1 = -speedX1;
    posX1 += speedX1;
  }
  posY1 += speedY1;
  if (posY1 < radius1 || posY1 > height - radius1)
  {
    speedY1 = -speedY1;
    posY1 += speedY1;
  }
}

void MoveBall2()
{
  posX2 += speedX2;
  if (posX2 < radius2 || posX2 > width - radius2)
  {
    speedX2 = -speedX2;
    posX2 += speedX2;
  }
  posY2 += speedY2;
  if (posY2 < radius2 || posY2 > height - radius2)
  {
    speedY2 = -speedY2;
    posY2 += speedY2;
  }
}

void DrawBall1()
{
  fill(#007722);
  ellipse(posX1, posY1, radius1 * 2, radius1 * 2);
}

void DrawBall2()
{
  fill(#002277);
  ellipse(posX2, posY2, radius2 * 2, radius2 * 2);
}



