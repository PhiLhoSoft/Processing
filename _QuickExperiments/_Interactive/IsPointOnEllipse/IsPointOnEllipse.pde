int ellipseW = 400;
int ellipseH = 300;
int ellipseX = 0, ellipseY = 0;

void setup()
{
  size(800, 800);
  smooth();
  ellipseX = width/2;
  ellipseY = height/2;
}

void draw()
{
  background(#FFFFFF);
  ellipse(ellipseX, ellipseY, ellipseW, ellipseH);
}

void mouseMoved()
{
  fill(
    IsPointInEllipse(mouseX, mouseY) ? #FF0000 : #00FF00
  );
}

boolean IsPointInEllipse(int x, int y)
{
  // Compute position of focal points
  float c = sqrt(ellipseW * ellipseW - ellipseH * ellipseH) / 2.0;
  float f1x = ellipseX - c;
  float f2x = ellipseX + c;
  float d1 = dist(x, y, f1x, ellipseY);
  float d2 = dist(x, y, f2x, ellipseY);
  return d1 + d2 <= ellipseW;
}

