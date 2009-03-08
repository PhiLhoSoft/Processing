void DrawCircle(float x, float y, float w, float h, float ratio)
{
  float l = 1 - ratio;
  float hw = w / 2, hh = h / 2;
  float lx = l * hw, ly = l * hh;
  // Assume here default CENTER mode
  x -= hw; y -= hh;

  beginShape();
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
  endShape();
}

float ratio = 0.0;
int direction = 1;
float angle = 0.0;
int hw, hh;
boolean bWholeAnimation = false;

void setup()
{
  size(500, 500);
  hw = width / 2;
  hh = height / 2;
  smooth();
}

void draw()
{
  background(222);
  
  noStroke();
  if (bWholeAnimation)
  {
    pushMatrix();
    translate(hw, hh);
    rotate(angle);
    fill(0x33995500);
    rect(100 - hw, 100 - hh, width - 200, height - 200);
    pushMatrix();
    rotate(angle);
    fill(0x660000EE);
    DrawCircle(-hw/2, -hh/2, 200, 200, 3.0 - ratio);
    DrawCircle(hw/2, hh/2, 200, 200, 1.0 - ratio);
    popMatrix();
    rotate(HALF_PI + angle);
    DrawCircle(-hw/2, -hh/2, 200, 200, 2.0 - ratio);
    DrawCircle(hw/2, hh/2, 200, 200, -ratio);
    angle += PI/180;
    popMatrix();
  }
  
  fill(0x8800EE00);
  stroke(#2288FF);
  DrawCircle(hw, hh, 400, 400, ratio);
  ratio += 0.01 * direction;
  if (ratio > 2.0 || ratio < -2.0) direction *= -1;
}

