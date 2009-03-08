// PImage testing
PImage bigImage;
int n = 6;
int IMAGE_SIZE = 48;

void setup()
{
  PGraphics bigImage = createGraphics(IMAGE_SIZE, IMAGE_SIZE * n, JAVA2D);
  bigImage.beginDraw();
  for (int i = 0; i < n; i++)
  {
    PImage tpi = loadImage("E:/temp/testImage" + (i + 1) + ".png");
    bigImage.image(tpi, 0, i * IMAGE_SIZE);
  }
  bigImage.endDraw();
  bigImage.save("BigImage.png");
  exit();
}

