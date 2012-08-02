PImage img;

void setup()
{
  size(100, 100);
  img = loadImage("G:/Images/map.png");
  image(img, 0, 0);
}
 
void draw()
{
  oneSortStep();
}

void oneSortStep()
{
  loadPixels();
  for (int i = 0; i < pixels.length - 1; i++)
  {
    if (blue(pixels[i + 1]) < blue(pixels[i]))
    {
      // Swap pixels
      color c = pixels[i];
      pixels[i] = pixels[i + 1];
      pixels[i + 1] = c;
    }
  }
  updatePixels();
}

