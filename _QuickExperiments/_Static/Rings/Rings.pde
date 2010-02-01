// Clockwise
void drawCircleCW(float x, float y, float w, float h)
{
  // Java draws circles using four cubic curves too, with ratio of length of control vector
  // against radius of 0.552. I compute the complement of this ratio for convenience.
  float l = 1 - 0.552;
  float hw = w / 2, hh = h / 2;
  float lx = l * hw, ly = l * hh;
  // Assume here default CENTER mode
  x -= hw; y -= hh;

  vertex(x, y + hh); // Left
  bezierVertex(x, y + ly,
      x + lx, y,
      x + hw, y); // Top
  bezierVertex(x + w - lx, y,
      x + w, y + ly,
      x + w, y + hh); // Right
  bezierVertex(x + w, y + h - ly,
      x + w - lx, y + h,
      x + hw, y + h); // Bottom
  bezierVertex(x + lx, y + h,
      x, y + h - ly,
      x, y + hh); // Back to left
}

// Counter Clockwise
void drawCircleCCW(float x, float y, float w, float h)
{
  float l = 1 - 0.552;
  float hw = w / 2, hh = h / 2;
  float lx = l * hw, ly = l * hh;
  // Assume here default CENTER mode
  x -= hw; y -= hh;

  vertex(x, y + hh); // Left
  bezierVertex(x, y + h - ly,
      x + lx, y + h,
      x + hw, y + h); // Bottom
  bezierVertex(x + w - lx, y + h,
      x + w, y + h - ly,
      x + w, y + hh); // Right
  bezierVertex(x + w, y + ly,
      x + w - lx, y,
      x + hw, y); // Top
  bezierVertex(x + lx, y,
      x, y + ly,
      x, y + hh); // Back to left
}

// Draw a ring, assuming it is circular (not an ellipse),
// but accepting that the internal circle isn't centered on the external one
void drawRing(
    float xx, float xy, float xd, // Center of external circle and its diameter
    float ix, float iy, float id) // Center of internal circle and its diameter
{
  beginShape();
  drawCircleCW(xx, xy, xd, xd);
  drawCircleCCW(ix, iy, id, id);
  endShape();
}

void setup()
{
  size(500, 500);
  noLoop();

  noStroke();
  background(222);
  // To verify it fits to a circle
  fill(#FF0000);
  ellipse(width/2, height/2, 200, 200);
  // Draw test ring
  fill(0x8800EE00);
  drawRing(width/2, height/2, 200,
    width/2, height/2, 100);
  // Draw some others
  fill(0x440000EE);
  for (int i = 0; i < 5; i++)
  {
    float rxd = width / random(1.5, 5);
    float rxx = random(rxd / 2, width - rxd / 2);
    float rxy = random(rxd / 2, height - rxd / 2);
    float rid = rxd / random(2, 4);
    float rix = rxx + rid * random(-0.9, 0.9) / 4;
    float riy = rxy + rid * random(-0.9, 0.9) / 4;
    drawRing(rxx, rxy, rxd, rix, riy, rid);
  }
}

/*
A rule of 2D graphics states that to draw holes in an object, the hole must be drawn in the reverse order of the outer shape.
Ie. for a circle, you draw the outer diameter clockwise, and the inner one counter-clockwise. Or the reverse.
That said, how to draw a circle in a defined direction? I recently discovered that Java draws them using four CubicCurves, our Bézier curves, with a ratio between control vector and radius of 0.552.
I tried and indeed it matches closely the drawing of an ellipse.

The remainder was then quite simple to do. :-) It seems to work well.
*/

