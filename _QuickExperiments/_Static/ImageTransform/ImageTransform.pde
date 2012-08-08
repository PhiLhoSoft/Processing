// PImage testing
PImage niceImage;
color bgColor = #AAFFDD;

void setup()
{
  size(1200, 800);
  smooth();
  noLoop();
  background(bgColor);

  // 393x500
  niceImage = loadImage("Globe.png");
  niceImage.resize(400, 400);
  image(niceImage, 0, 0, niceImage.width, niceImage.height);

  translate(0, niceImage.height);
  drawReflected(niceImage);
  translate(niceImage.width, 0);
  drawInverted(niceImage);

  translate(0, -niceImage.height);
  drawTint(niceImage);
  translate(niceImage.width, 0);
  drawGray(niceImage);
  translate(0, niceImage.height);
  drawBlend(niceImage);

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

void drawInverted(PImage img)
{
  pushMatrix();
  rotate(PI);
  translate(-img.width, -img.height);
  image(img, 0, 0, img.width, img.height);
  popMatrix();
}

void drawReflected(PImage img)
{
  pushMatrix();
  scale(1.00, -1.00);
  image(img, 0, -img.height, img.width, img.height);
  popMatrix();
}

// Except tint(), these alterations are not available directly in the renderer,
// but it will take in account images generated in another buffer.

void drawGray(PImage img)
{
  PGraphics gr = createGraphics(img.width, img.height, P2D);
  gr.beginDraw();
  gr.background(bgColor);
  gr.image(img, 0, 0, img.width, img.height);
  gr.filter(GRAY);
  gr.filter(POSTERIZE, 4);
  gr.endDraw();

  image(gr, 0, 0);
}

void drawTint(PImage img)
{
  PGraphics gr = createGraphics(img.width, img.height, P2D);
  gr.beginDraw();
  gr.background(bgColor);
  gr.tint(255, 126);
  gr.image(img, 0, 0, img.width, img.height);
  gr.endDraw();

  image(gr, 0, 0);
}

void drawBlend(PImage img)
{
  PGraphics gr = createGraphics(img.width, img.height, P2D);
  gr.beginDraw();
  gr.background(bgColor);
  gr.rotate(HALF_PI);
  gr.translate(0, -img.height);
  gr.image(img, 0, 0);
  gr.blend(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height, BLEND);
  gr.endDraw();

  image(gr, 0, 0);
}

