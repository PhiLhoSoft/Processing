boolean bWholeAnimation = false;
boolean bShowCircle = true;

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

// Could make it procedural but just for fun I make it recursive
// Plus the symbolism of the stack of calls winding up then unwinding
// is close of the concept of spiral spring...
void DrawSpiral(float cx, float cy, float diameter, float ratio, float interval, boolean bStart)
{
  float radius = diameter / 2;
  float ctrlLen = (1 - ratio) * radius;
  float x = cx - radius, y = cy - radius;
  float step = interval / 4;
  float rrs = (1 - ratio) * step / 2;

  if (bStart)
  {
    beginShape();
    vertex(x, y + radius); // Left
  }
  bezierVertex(x + 2 * step, y + ctrlLen,
      x + ctrlLen, y + step,
      x + radius, y + step); // Top
  bezierVertex(x + diameter - ctrlLen - rrs, y + step,
      x + diameter - 2 * step, y + ctrlLen + 2 * rrs,
      x + diameter - 2 * step, y + radius); // Right
  bezierVertex(x + diameter - 2 * step, y + diameter - ctrlLen - 2 * rrs,
      x + diameter - ctrlLen - 3 * rrs, y + diameter - 3 * step,
      x + radius, y + diameter - 3 * step); // Bottom
  bezierVertex(x + ctrlLen + 3 * rrs, y + diameter - 3 * step,
      x + 4 * step, y + diameter - ctrlLen - 4 * rrs,
      x + 4 * step, y + radius); // Back to left
  if (radius > interval)
  {
    DrawSpiral(cx, cy, diameter - interval, ratio, interval, false);
  }
  else
  {
    endShape();
  }
}

// Ratio for perfect circle
float pcr = 0.5522847498;
float ratio = 0.0;
int direction = 1;
float angle = 0.0;
int halfW, halfH;

void setup()
{
  size(800, 800);
  halfW = width / 2;
  halfH = height / 2;
  //smooth();
}

void draw()
{
  background(222);

  noStroke();
  if (bWholeAnimation)
  {
    pushMatrix();
    translate(halfW, halfH);
    rotate(angle);
    fill(0x33995500);
    rect(100 - halfW, 100 - halfH, width - 200, height - 200);
    pushMatrix();
    rotate(angle);
    fill(0x660000EE);
    DrawCircle(-halfW/2, -halfH/2, 200, 200, 3.0 - ratio);
    DrawCircle(halfW/2, halfH/2, 200, 200, 1.0 - ratio);
    popMatrix();
    rotate(HALF_PI + angle);
    DrawCircle(-halfW/2, -halfH/2, 200, 200, 2.0 - ratio);
    DrawCircle(halfW/2, halfH/2, 200, 200, -ratio);
    angle += PI/180;
    popMatrix();
  }

  fill(0x8800EE00);
  stroke(#2288FF);
  if (bShowCircle) ratio = pcr;
  DrawCircle(halfW, halfH, 700, 700, ratio);
  if (bShowCircle)
  {
    fill(0x480000EE);
    stroke(0x402288FF);
    ellipse(halfW, halfH, 700, 700);

    noFill();
    stroke(#FF0000);
    strokeWeight(1);
    DrawSpiral(halfW, halfH, 700, pcr, 21, true);

    noLoop();
  }
  ratio += 0.01 * direction;
  if (ratio > 2.0 || ratio < -2.0) direction *= -1;
}

