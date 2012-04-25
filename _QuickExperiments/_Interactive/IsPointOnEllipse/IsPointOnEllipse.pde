int ellipseW = 350;
int ellipseH = 150;
int ellipse1X, ellipse1Y;
int ellipse2X, ellipse2Y;

void setup()
{
  size(500, 500);
  smooth();
  noStroke();
  
  ellipse1X = width / 2;
  ellipse1Y = height / 3;
  ellipse2X = width / 2;
  ellipse2Y = 2 * height / 3;
}

void draw()
{
  background(#FFFFFF);

  fill(
    IsPointInEllipse(mouseX, mouseY) ? #FF0000 : #00FF00
  );
  ellipse(ellipse1X, ellipse1Y, ellipseW, ellipseH);

  float r = getR();
  if (r < 1) fill(#FF0000); else fill(#AABB00);
  ellipse(ellipse2X, ellipse2Y, ellipseW, ellipseH);
}

boolean IsPointInEllipse(int x, int y)
{
  // Compute position of focal points
  float c = sqrt(ellipseW * ellipseW - ellipseH * ellipseH) / 2.0;
  float f1x = ellipse1X - c;
  float f2x = ellipse1X + c;
  float d1 = dist(x, y, f1x, ellipse1Y);
  float d2 = dist(x, y, f2x, ellipse1Y);
  return d1 + d2 <= ellipseW;
}

// Another way
float getR()
{
  float hw = ellipseW / 2;
  float hh = ellipseH / 2;
  float dX = ellipse2X - mouseX;
  float dY = ellipse2Y - mouseY;
  float r = dX * dX / hw / hw + dY * dY / hh / hh;
  return r;
}

