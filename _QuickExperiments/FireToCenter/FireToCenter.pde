boolean bFiring;
float x, y;
float xSpeed, ySpeed;

float targetX, targetY;

void setup()
{
  size(500, 300);
  targetX = width / 2;
  targetY = height / 2;
}

void draw()
{
  background(255);
  fill(#00FF00);
  ellipse(targetX, targetY, 8, 8);
  if (bFiring)
  {
    x += xSpeed;
    y += ySpeed;
    fill(#FF0000);
    ellipse(x, y, 4, 4);
    if (abs(x - targetX) < abs(xSpeed) && abs(y - targetY) < abs(ySpeed))
    {
      bFiring = false;
    }
  }
}

void mousePressed()
{
  x = mouseX;
  y = mouseY;
  float xDist = targetX - x;
  float yDist = targetY - y;
  PVector dist = new PVector(xDist, yDist);
  dist.normalize();
  xSpeed = dist.x * 3;
  ySpeed = dist.y * 3;
  println("Speed: " + xSpeed + " " + ySpeed);
  bFiring = true;
}

