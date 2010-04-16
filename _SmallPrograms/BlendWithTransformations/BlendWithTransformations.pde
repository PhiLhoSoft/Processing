PFont font;

int IMAGE_W = 500;
int IMAGE_H = 500;
int CHOICE_T = 50;
int CHOICE_L = 50;
int CHOICE_W = 200;
int CHOICE_SPACING = 25;
PGraphics baseImage;
PGraphics resultImage;
int lineNb = 50;
int lengthIncrement = 7;
boolean bDoBlend;

int currentBlendMode = ADD;
class BlendMode
{
  int blendMode;
  String blendName;
  BlendMode(int bm, String bn) { blendMode = bm; blendName = bn; }
}
ArrayList<BlendMode> blendModes = new ArrayList<BlendMode>();

void setup()
{
  size(700, 500);
  smooth();
//  noLoop();
  font = loadFont("Tahoma-Bold-14.vlw");
  textFont(font);

  blendModes.add(new BlendMode(REPLACE, "REPLACE"));
  blendModes.add(new BlendMode(BLEND, "BLEND"));
  blendModes.add(new BlendMode(ADD, "ADD"));
  blendModes.add(new BlendMode(SUBTRACT, "SUBTRACT"));
  blendModes.add(new BlendMode(LIGHTEST, "LIGHTEST"));
  blendModes.add(new BlendMode(DARKEST, "DARKEST"));
  blendModes.add(new BlendMode(DIFFERENCE, "DIFFERENCE"));
  blendModes.add(new BlendMode(EXCLUSION, "EXCLUSION"));
  blendModes.add(new BlendMode(MULTIPLY, "MULTIPLY"));
  blendModes.add(new BlendMode(SCREEN, "SCREEN"));
  blendModes.add(new BlendMode(OVERLAY, "OVERLAY"));
  blendModes.add(new BlendMode(HARD_LIGHT, "HARD_LIGHT"));
  blendModes.add(new BlendMode(SOFT_LIGHT, "SOFT_LIGHT"));
  blendModes.add(new BlendMode(DODGE, "DODGE"));
  blendModes.add(new BlendMode(BURN, "BURN"));

  baseImage = createGraphics(IMAGE_W, IMAGE_H, JAVA2D);
  DrawImage();
  resultImage = createGraphics(IMAGE_W, IMAGE_H, JAVA2D);
  resultImage.beginDraw();
  resultImage.image(baseImage, 0, 0);
  resultImage.endDraw();
}

void draw()
{
  background(#99EEFF);
  ShowBlendChoices();
  image(resultImage, CHOICE_W, 0);
}

// Choosing the operation to do
// Will add choice of blend mode...
void keyPressed()
{
  // Update base image with current screen
  baseImage.beginDraw();
  baseImage.image(g, CHOICE_W, 0);
  baseImage.endDraw();

PImage img = null;
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

// Try to make an interesting base image
// Square spiral, slightly improved from yet another old sketch
void DrawImage()
{
  baseImage.beginDraw();
  baseImage.colorMode(HSB, 1000);
  baseImage.fill(#DDEEFF);
  baseImage.rect(0, 0, IMAGE_W, IMAGE_H);
  baseImage.strokeWeight(7);
//  stroke(#005080);
  int cH = 200, cS = 1000, cB = 500;
  int lineLength = 5;
  int x, y;
  int px, py;
  px = x = baseImage.width / 2;
  py = y = baseImage.height / 2;

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
    baseImage.stroke(cH, cS, cB);
    cH += 1000 / lineNb;
    cS -= 1000 / lineNb;
    cB += 10;
    baseImage.line(px, py, x, y);
    px = x; py = y;
    lineLength += lengthIncrement;
  }
  baseImage.endDraw();
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

void ShowBlendChoices()
{
  int posY = CHOICE_T;
  for (BlendMode blendMode : blendModes)
  {
    if (IsMouseOverChoice(posY))
    {
      fill(#C05080);
    }
    else
    {
      fill(#005080);
    }
    text(blendMode.blendName, CHOICE_L, posY);
    posY += CHOICE_SPACING;
  }
}

boolean IsMouseOverChoice(int posY)
{
  if (mouseX < CHOICE_L - 20 ||
      mouseX > CHOICE_W - 20)
    return false;
  if (mouseY < CHOICE_T - CHOICE_SPACING ||
      mouseY > CHOICE_T + CHOICE_SPACING * blendModes.size())
    return false;
  if (mouseY < posY - CHOICE_SPACING ||
      mouseY > posY)
    return false;
  return true;
}
