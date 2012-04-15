import java.awt.*;

PImage screenCapture;
 
void setup()
{
  size(800, 800);
  Robot robby = null;
  try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Oops: " + e);
  }
  java.awt.image.BufferedImage capture = robby.createScreenCapture(new Rectangle(0, 0, width, height));
  screenCapture = new PImage(capture);
  image(screenCapture, 0, 0);
}

void draw() {}

void mousePressed()
{
}

