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
  if (kh) x--;
  if (kl) x++;
  if (kj) y++;
  if (kk) y--;
}

boolean kh, kj, kk, kl;
void keyPressed()
{
  switch (key)
  {
    case 'h': kh = true; break;
    case 'j': kj = true; break;
    case 'k': kk = true; break;
    case 'l': kl = true; break;
  }
}
void keyReleased()
{
  switch (key)
  {
    case 'h': kh = false; break;
    case 'j': kj = false; break;
    case 'k': kk = false; break;
    case 'l': kl = false; break;
  }
}

