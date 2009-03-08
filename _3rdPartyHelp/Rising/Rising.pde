PImage pi; // Background image
PGraphics pg; // Off-screen graphic buffer

int x = 0, sz = 80;
int cx = 50, cy = 70;

void setup()
{
  size(200, 200);
  smooth();
  pi = loadImage("../../Globe.png"); // Any graphic will do, this is to show it is hidden only by the real graphics
  image(pi, 0, 0); // Draw background on display

  pg = createGraphics(width, height, JAVA2D);
  pg.beginDraw();
  pg.ellipseMode(CORNER);
  pg.image(pi, 0, 0); // Draw background in graphic
// draw a green ellipse and a red rectangle
// in point cy
  pg.stroke(0); pg.fill(20, 200, 10);
  pg.ellipse(cx, cy, sz, sz);//green ellipse
  pg.fill(200, 20, 20);
  pg.rect(cx, cy+30, sz/2, sz/2); // red rectangle
  pg.endDraw();
}

void draw()
{
  if (x > sz)
  {
      println("End");
      noLoop(); // Stop
      return;
  }
  copy(pg, cx, cy, sz, x, cx, cy+sz-x, sz+1, x+1);
  x++;
}
