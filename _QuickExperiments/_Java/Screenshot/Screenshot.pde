import java.awt.*;

PImage screenImage;
PImage maskedImage;
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
  // Copy the original image (kept as reference)
  maskedImage = screenImage.get();
  /*
  maskedImage.resize(height, hw);
  PGraphics finalImage = createGraphics(width, height, JAVA2D);
  rotate(PI / 2);
  translate(-float(height), 0);
  finalImage.beginDraw();
  finalImage.image(maskedImage, 0, 0);
  */
  // Apply the mask
  maskedImage.mask(graphicalMask[count++]);
//  finalImage.endDraw();
  // Display the result
  image(maskedImage, 0, 0);
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
    case 0:
      pg.triangle(hw, hh, 0, height, 0, 0);
      break;
    case 1:
      pg.triangle(hw, hh, 0, 0, width, 0);
      break;
    case 2:
      pg.triangle(hw, hh, width, 0, width, height);
      break;
    case 3:
      pg.triangle(hw, hh, width, height, 0, height);
      break;
  }
  
  pg.endDraw();
}

