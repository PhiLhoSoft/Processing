import java.awt.*;

size(1000, 800);
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
PImage screenImage = new PImage(screenshot);
image(screenImage, 0, 0, screenImage.width, screenImage.height);

