import java.awt.image.BufferedImage;
import com.jhlabs.image.*;

PImage sourceImage;
PImage filteredImage1;
PImage filteredImage2;
PImage filteredImage3;

void setup() 
{
  size(1000, 800); // Hoping it is big enough...
  sourceImage = loadImage("http://www.sallesobscures.com/stars/69-6.jpg");

  BufferedImage javaImage = (BufferedImage) sourceImage.getImage();
  GaussianFilter gaussian = new GaussianFilter(12);
  BufferedImage filteredJavaImage = gaussian.filter(javaImage, null);
  filteredImage1 = new PImage(filteredJavaImage);

  QuantizeFilter quantizer = new QuantizeFilter();
  filteredImage2 = createImage(sourceImage.width, sourceImage.height, RGB);
  int numColors = 16;
  boolean dither = true;
  boolean serpentine = true;
  // I have to make a copy as quantize uses the orignal image's pixels to store information!
  PImage inImage = sourceImage.get();
  quantizer.quantize(inImage.pixels, filteredImage2.pixels, sourceImage.width, sourceImage.height, 
      numColors, dither, serpentine);
      
  filteredImage3 = createImage(sourceImage.width, sourceImage.height, RGB);
  numColors = 16;
  dither = false;
  serpentine = false;
  inImage = sourceImage.get();
  quantizer.quantize(inImage.pixels, filteredImage3.pixels, sourceImage.width, sourceImage.height, 
      numColors, dither, serpentine);
}

void draw() 
{
  image(sourceImage,   0, 0);
  image(filteredImage1, sourceImage.width, 0);
  image(filteredImage2, 0, sourceImage.height);
  image(filteredImage3, sourceImage.width, sourceImage.height);
}


