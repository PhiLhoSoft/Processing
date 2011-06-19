void setup()
{
  size(650, 650);
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
    pixels[pos] = mapColor(pixels[pos], B, xLtoR, width / 2);

    pos = i * width + xRtoL;
    pixels[pos] = mapColor(pixels[pos], G, width - 1 - xRtoL, width / 2);
  }
  xLtoR++;
  xRtoL--;
  for (int i = 0; i < width; i++)
  {
    int pos = yTtoB * width + i;
    pixels[pos] = mapColor(pixels[pos], R, yTtoB, height / 2);

    pos = yBtoT * width + i;
    pixels[pos] = mapColor(pixels[pos], R, height - 1 - yBtoT, height / 2);
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

int mapColor(color clr, int channel, int cur, int max)
{
  int chan = 0;
  switch (channel)
  {
  case R: // Red
    chan = (clr & 0x00FF0000) >> 16;
    clr &= 0xFF00FFFF;
    break;
  case G: // Green
    chan = (clr & 0x0000FF00) >> 8;
    clr &= 0xFFFF00FF;
    break;
  case B: // Blue
    chan = clr & 0x000000FF;
    clr &= 0xFFFFFF00;
    break;
  }
  chan = int(1.0 * chan * cur / max) & 0xFF;
  switch (channel)
  {
  case R: // Red
    clr |= chan << 16;
    break;
  case G: // Green
    clr |= chan << 8;
    break;
  case B: // Blue
    clr |= chan;
    break;
  }
  return clr;
}

