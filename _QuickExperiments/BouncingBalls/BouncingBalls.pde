Ball ball1, ball2;

void setup()
{
  size(600, 400);
  smooth();
  noStroke();

  ball1 = new Ball(20, 50, -5, 8, 23, #002277);
  ball2 = new Ball(120, 150, 7, -3, 31, #007722);
}

void draw()
{
  background(#AAFFEE);
  ball1.Move();
  ball2.Move();
  ball1.Display();
  ball2.Display();
}


class Ball
{
  float posX, posY; // Position
  float speedX, speedY; // Movement (linear)
  float radius;
  color ballColor;

  Ball(float px, float py, float sX, float sY, float r, color c)
  {
    posX = px; posY = py;
    speedX = sX; speedY = sY;
    radius = r; ballColor = c;
  }

  void Move()
  {
    posX += speedX;
    if (posX < radius || posX > width - radius)
    {
      speedX = -speedX;
      posX += speedX;
    }
    posY += speedY;
    if (posY < radius || posY > height - radius)
    {
      speedY = -speedY;
      posY += speedY;
    }
  }

  void Display()
  {
    fill(ballColor);
    ellipse(posX, posY, radius * 2, radius * 2);
  }
}
