int x, y;

void setup()
{
  size(400, 400);
  smooth();
  noStroke();
  
  x = width / 2;
  y = height / 2;
}

void draw()
{
  background(255);
  fill(#55AAFF);
  ellipse(x, y, 20, 20);
  if (kL) x--;
  if (kR) x++;
  if (kD) y++;
  if (kU) y--;
  if (kF)
  {
    stroke(#FFAA88);
    line(x, y, width / 2, height / 2);
  }
}

boolean kL, kD, kU, kR, kF;
void keyPressed()
{
  if (key == CODED)
  {
    switch (keyCode)
    {
      case LEFT: kL = true; break;
      case DOWN: kD = true; break;
      case UP: kU = true; break;
      case RIGHT: kR = true; break;
      case CONTROL: kF = true; break;
    }
  }
}

void keyReleased()
{
  if (key == CODED)
  {
    switch (keyCode)
    {
      case LEFT: kL = false; break;
      case DOWN: kD = false; break;
      case UP: kU = false; break;
      case RIGHT: kR = false; break;
      case CONTROL: kF = false; break;
    }
  }
}

