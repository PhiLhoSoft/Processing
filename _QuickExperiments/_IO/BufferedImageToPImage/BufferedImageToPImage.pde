import java.awt.image.*;

void setup()
{
  size(200, 200);
  byte[] bytes = loadBytes("H:/Documents/Images/KM200.png");
  try 
  {
    ByteArrayInputStream bis = new ByteArrayInputStream(bytes); 
    BufferedImage bimg = javax.imageio.ImageIO.read(bis); 
    PImage img = new PImage(bimg.getWidth(), bimg.getHeight(), PConstants.ARGB);
    bimg.getRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);
    img.updatePixels();
    image(img, 0, 0);
  }
  catch (Exception e) 
  {
    System.err.println("Cannot create image from buffer");
    e.printStackTrace();
  }
}

