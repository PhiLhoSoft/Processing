int lineNb = 50;
int lengthIncrement = 7;
boolean bDoBlend;

int currentBlendMode = ADD;

void setup()
{
  size(500, 500);
  smooth();
  noLoop();
  colorMode(HSB, 1000);

  // Try to make an interesting base image
  DrawImage();
}

void draw() {} // To handle events

// Choosing the operation to do
// Will add choice of blend mode...
void keyPressed()
{
  PImage img = get();

  switch (key)
  {
  case 'b':
    // Activate
    bDoBlend = !bDoBlend;
    println("Blend? " + bDoBlend);
    break;
  case 'i':
    if (bDoBlend)
    {
      BlendInverted(img);
    }
    else
    {
      DrawInverted(img);
    }
    break;
  case 'r':
    if (bDoBlend)
    {
      BlendReflected(img);
    }
    else
    {
      DrawReflected(img);
    }
    break;
  case 's':
    if (bDoBlend)
    {
      BlendShifted(img);
    }
    else
    {
      DrawShifted(img);
    }
    break;
  case 'c': // clear
    DrawImage();
    break;
  }
  redraw();
}

// Square spiral, slightly improved from yet another old sketch
void DrawImage()
{
  background(#99EEFF);
  strokeWeight(7);
//  stroke(#005080);
  int cH = 200, cS = 1000, cB = 500;
  int lineLength = 5;
  int x, y;
  int px, py;
  px = x = width / 2;
  py = y = height / 2;

  for (int i = 0; i < lineNb; i++)
  {
    switch (i % 4)
    {
    case 0:
      x -= lineLength;
      break;
    case 1:
      y -= lineLength;
      break;
    case 2:
      x += lineLength;
      break;
    case 3:
      y += lineLength;
      break;
    }
    stroke(cH, cS, cB);
    cH += 1000 / lineNb;
    cS -= 1000 / lineNb;
    cB += 10;
    line(px, py, x, y);
    px = x; py = y;
    lineLength += lengthIncrement;
  }
}

void DrawInverted(PImage img)
{
  println("DrawInverted");
  pushMatrix();
  translate(img.width, img.height);
  rotate(PI);
  image(img, 0, 0);
  popMatrix();
}

void DrawReflected(PImage img)
{
  println("DrawReflected");
  pushMatrix();
  translate(0, img.height);
  scale(1.00, -1.00);
  image(img, 0, 0);
  popMatrix();
}

void DrawShifted(PImage img)
{
  println("DrawShifted");
  float SCALE = 1.2;
  float ns = img.width * (SCALE - 1) / 2;
  pushMatrix();
  translate(-ns, -ns);
  scale(SCALE, SCALE);
  image(img, 0, 0);
  popMatrix();
}


// Copy the given image to a PGraphics of same size, to manipulate it
PGraphics GetCopy(PImage img)
{
  PGraphics copy = createGraphics(img.width, img.height, JAVA2D);
  copy.beginDraw();
  copy.image(img, 0, 0);
  copy.endDraw();

  return copy;
}

void BlendInverted(PImage img)
{
  println("BlendInverted");
  PGraphics copy = GetCopy(img);
  copy.beginDraw();
  copy.translate(img.width, img.height);
  copy.rotate(PI);
  copy.image(img, 0, 0);
  copy.endDraw();
  blend(copy, 0, 0, copy.width, copy.height, 0, 0, width, height, currentBlendMode);
}

void BlendReflected(PImage img)
{
  println("BlendReflected");
  PGraphics copy = GetCopy(img);
  copy.beginDraw();
  copy.translate(0, img.height);
  copy.scale(1.0, -1.0);
  copy.image(img, 0, 0);
  copy.endDraw();
  blend(copy, 0, 0, copy.width, copy.height, 0, 0, width, height, currentBlendMode);
}

void BlendShifted(PImage img)
{
  println("BlendShifted");
  float SCALE = 1.2;
  float ns = img.width * (SCALE - 1) / 2;
  PGraphics copy = GetCopy(img);
  copy.beginDraw();
  copy.translate(-ns, -ns);
  copy.scale(SCALE, SCALE);
  copy.endDraw();
  blend(copy, 0, 0, copy.width, copy.height, 0, 0, width, height, currentBlendMode);
}
