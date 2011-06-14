void setup()
{
  size(640, 480);
  // Image found at http://www.parc-causses-du-quercy.org/index.php/photos/paysage_typique_causse
  PImage image = loadImage("G:/Images/References/paysage_typique_causse.jpg");
  image(image, (width - image.width) / 2, (height - image.height) / 2);
  xRtoL = width - 1;
  yBtoT = height - 1;
}

int xLtoR, xRtoL, yTtoB, yBtoT;
void draw()
{
  loadPixels();
  for (int i = 0; i < height; i++)
  {
    int pos = i * width + xLtoR;
    pixels[pos] &= 0xFFFFFF00;
    pos = i * width + xRtoL;
    pixels[pos] &= 0xFFFF00FF;
  }
  xLtoR++;
  xRtoL--;
  for (int i = 0; i < width; i++)
  {
    int pos = yTtoB * width + i;
    pixels[pos] &= 0xFF00FFFF;
    pos = yBtoT * width + i;
    pixels[pos] &= 0xFF0000FF;
  }
  yTtoB++;
  yBtoT--;
  updatePixels();
  if (xRtoL < width / 2 || yBtoT < height / 2) 
  {
    noLoop();
    println("Done");
  }
}

