import java.awt.image.BufferedImage;

PImage original;
PImage result;

void setup()
{
  size(900, 400);
  
  original = loadImage("oranges.jpg");

  background(255);  
  image(original, 0, 0);
} 

void draw()
{
  noLoop();
  
  SmartBlurFilter smartFilter = new SmartBlurFilter();
  BufferedImage filtered = smartFilter.filter((BufferedImage) original.getNative());
  result = new PImage(filtered);
  image(result, 450, 0);
}

