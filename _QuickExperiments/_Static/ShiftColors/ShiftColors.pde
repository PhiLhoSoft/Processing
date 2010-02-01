PImage testImage;
int minHue = 256, maxHue = 0;
int minSat = 256, maxSat = 0;
int minBri = 256, maxBri = 0;

void setup()
{
  size(600, 400);
  smooth();
  noLoop();
  colorMode(HSB);

  testImage = loadImage("E:/Dev/PhiLhoSoft/Processing/me_red.png");

  testImage.loadPixels();
  analyzeImage(testImage);

  background(230);

  image(testImage, 0, 0);

  shiftColors(testImage);
  testImage.updatePixels();

  image(testImage, testImage.width, 0);
}

void analyzeImage(PImage someImage)
{
  // Pre-condition: loadPixels have been done
  for (int i = 0; i < someImage.pixels.length; i++)
  {
    color c = someImage.pixels[i];

    int hue = int(hue(c));
    minHue = min(minHue, hue);
    maxHue = max(maxHue, hue);

    int saturation= int(saturation(c));
    minSat = min(minSat, saturation);
    maxSat = max(maxSat, saturation);

    int brightness= int(brightness(c));
    minBri = min(minBri, brightness);
    maxBri = max(maxBri, brightness);
  }

  println("Hue - Min: " + minHue + ", Max: " + maxHue);
  println("Sat - Min: " + minSat + ", Max: " + maxSat);
  println("Bri - Min: " + minBri + ", Max: " + maxBri);
}

void shiftColors(PImage someImage)
{
  // Pre-condition: loadPixels have been done
  for (int i = 0; i < someImage.pixels.length; i++)
  {
    color oc = someImage.pixels[i];  // Eliminate alpha
    int hue = int(map(brightness(oc), minBri, maxBri,
        0,  // hue = 0 => red
        85));  // 85 => green
    // Keep original saturation and brightness (can be mapped too)
    color nc = color(hue,
        saturation(oc),
        brightness(oc));
    someImage.pixels[i] = nc;
  }
}
