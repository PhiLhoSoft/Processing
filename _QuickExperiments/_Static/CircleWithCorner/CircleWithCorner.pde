// Ratio for perfect circle
float pcr = 0.5522847498;

void setup()
{
  size(800, 550);
  smooth();
}

void draw()
{
  background(222);

  fill(0x8800EE00);
  stroke(#2288FF);
  DrawCircle(50, 50, 20);
  DrawCircle(110, 140, 80);
  DrawCircle(220, 350, 150);

  fill(0x880000EE);
  stroke(#22FF88);
  DrawShape(450, 50, 20);
  DrawShape(510, 140, 80);
  DrawShape(620, 350, 150);
  
  // Checking curvature
  fill(0x50EE0000);
  noStroke();
  DrawCircle(620, 350, 150);
}

// First step: draw a circle
void DrawCircle(float x, float y, float r)
{
  float l = (1 - pcr) * r;
  float d = 2 * r;
  // Assume here default CENTER mode
  x -= r; y -= r;

  beginShape();
  vertex(x, y + r); // Left
  bezierVertex(x, y + l,
      x + l, y,
      x + r, y); // Top
  bezierVertex(x + d - l, y,
      x + d, y + l,
      x + d, y + r); // Right
  bezierVertex(x + d, y + d - l,
      x + d - l, y + d,
      x + r, y + d); // Bottom
  bezierVertex(x + l, y + d,
      x, y + d - l,
      x, y + r); // Back to left
  endShape();
}

// Second step: change some sides
void DrawShape(float x, float y, float r)
{
  // Not sure why I have to increase l
  float l = 1.2 * (1 - pcr) * r;
  float d = 2 * r;
  // Assume here default CENTER mode
  // I put x and y to top-left
  x -= r; y -= r;

  beginShape();
  vertex(x + r, y); // Top
  vertex(x + d, y); // Top-Right
  vertex(x + d, y + r); // Right
  bezierVertex(x + d, y + r + l,
      x + r + l, y + d,
      x + r, y + d); // Bottom
  bezierVertex(x + r - l, y + d,
      x, y + r + l,
      x, y + r); // Left
  bezierVertex(x, y + r - l,
      x + r - l, y,
      x + r, y); // Back to Top
  endShape();
}

