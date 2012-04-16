import java.awt.*;

PImage screenImage;
PGraphics[] graphicalMask = new PGraphics[4];

int hw, hh;

void setup()
{
  size(1024, 768);
  hw = width / 2;
  hh = height / 2;

  captureScreen();
  screenImage.resize(width, height);
  image(screenImage, 0, 0);

  for (int i = 0; i < graphicalMask.length; i++)
  {
    graphicalMask[i] = createGraphics(width, height, JAVA2D);
    createMask(graphicalMask[i], i);
  }
}

void draw() {}

int count;
void mousePressed()
{
  background(0);

  for (int i = 0; i < graphicalMask.length; i++)
  {
    PGraphics finalImage = applyMask(i);
    // Display the result
    image(finalImage, 0, 0);
  }
}

void captureScreen()
{
  Dimension size = Toolkit.getDefaultToolkit().getScreenSize();
  Rectangle screenRect = new Rectangle(size);
  Robot robby = null;
  try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Exception: " + e);
  }
  java.awt.image.BufferedImage screenshot = robby.createScreenCapture(screenRect);
  screenImage = new PImage(screenshot);
}

void createMask(PGraphics pg, int n)
{
  pg.beginDraw();

  // Erase graphics with black background
  pg.background(0);
  // Draw the mask in white
  pg.fill(255);
  pg.noStroke();
  // A triangle
  switch (n)
  {
    case 0: // Left
      pg.triangle(hw, hh, 0, height, 0, 0);
      break;
    case 1: // Top
      pg.triangle(hw, hh, 0, 0, width, 0);
      break;
    case 2: // Right
      pg.triangle(hw, hh, width, 0, width, height);
      break;
    case 3: // Bottom
      pg.triangle(hw, hh, width, height, 0, height);
      break;
  }

  pg.endDraw();
}

PGraphics applyMask(int n)
{
  PGraphics finalImage = createGraphics(width, height, P2D);
  // Copy the original image (kept as reference)
  PImage maskedImage = screenImage.get();

  switch (n)
  {
    case 0: // Left
      maskedImage.resize(height, hw);
      finalImage.beginDraw();
      finalImage.translate(float(height), 0);
      finalImage.rotate(-PI / 2);
      finalImage.translate(-float(height), -height);
      finalImage.image(maskedImage, 0, 0);
      // Apply the mask
      finalImage.mask(graphicalMask[count++]);
      finalImage.endDraw();
      break;
    case 1: // Top
      maskedImage.resize(width, hh);
      finalImage.beginDraw();
      break;
    case 2: // Right
      maskedImage.resize(height, hw);
      finalImage.beginDraw();
      finalImage.rotate(PI / 2);
      finalImage.translate(0, -width);
      break;
    case 3: // Bottom
      maskedImage.resize(width, hh);
      finalImage.beginDraw();
      finalImage.rotate(PI);
      finalImage.translate(-width, -2 * hh);
      break;
  }
  finalImage.image(maskedImage, 0, 0);
  // Apply the mask
  finalImage.mask(graphicalMask[n]);
  finalImage.endDraw();

  return finalImage;
}

