// PImage testing
PImage niceImage;

void setup()
{
  size(500, 800);
  smooth();
  noLoop();

  niceImage = loadImage("D:/_PhiLhoSoft/images/Globe.png");
  image(niceImage, 0, 0, niceImage.width, niceImage.height);

  // Dimension to image size
  //size(niceImage.width,  niceImage.height);
  DrawTint(niceImage);
  DrawGray(niceImage);

/*
  // Display whole image
  image(niceImage, 0, 0);
  // Create a sub-image
  int posX = int(niceImage.width * 0.2);
  int posY = int(niceImage.height * 0.2);
  int subWidth = int(niceImage.width * 0.6);
  int subHeight = int(niceImage.height * 0.6);

  if (false)
  {
    PImage subImage = createImage(subWidth, subHeight, RGB);
    subImage.copy(niceImage, posX, posY, subWidth, subHeight, 0, 0, subWidth, subHeight);
    subImage.filter(INVERT);
    image(subImage, posX, posY, subWidth, subHeight);
  }
  else
  {
    // Simpler
    PImage subImage = get(posX, posY, subWidth, subHeight);
    subImage.filter(INVERT);
    set(posX, posY, subImage);
  }
*/
}

void DrawInverted(PImage img)
{
  pushMatrix();
  translate(img.width, img.height * 2);
  rotate(PI);
  image(img, 0, 0, img.width, img.height);
  popMatrix();
}

void DrawReflected(PImage img)
{
  pushMatrix();
  translate(0, img.height);
  scale(1.00, -1.00);
  image(img, 0, -img.height, img.width, img.height);
  popMatrix();
}

void DrawGray(PImage img)
{
  PGraphics gr = createGraphics(img.width, img.height, P2D);
  gr.beginDraw();
  gr.image(img, 0, 0, img.width, img.height);
  gr.resize(256, 256);
  gr.filter(GRAY);
  gr.filter(POSTERIZE, 4);
  gr.endDraw();

  pushMatrix();
  translate(0, img.height);
  image(gr, 0, 0);
  popMatrix();
}

void DrawTint(PImage img)
{
  PGraphics gr = createGraphics(img.width, img.height, P2D);
  gr.beginDraw();
  gr.tint(255, 126);
  gr.image(img, 0, 0, img.width, img.height);
  gr.endDraw();

  pushMatrix();
  translate(0, img.height);
  image(gr, 0, 0);
  popMatrix();
}

