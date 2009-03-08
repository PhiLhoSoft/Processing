PImage smallImage;
Map palette;
int minHue = 256, maxHue = 0;
int minSat = 256, maxSat = 0;
int minBri = 256, maxBri = 0;

void setup()
{
  size(600, 400);
  smooth();
  noLoop();
  colorMode(HSB);

  smallImage = loadImage("E:/Dev/PhiLhoSoft/Processing/me_red.png");
  palette = new HashMap();

  // Create a list of unique colors (ie. eliminates duplicate colors)
  smallImage.loadPixels();
  for (int i = 0; i < smallImage.pixels.length; i++)
  {
    color c = smallImage.pixels[i];
    ColorByBrightness cbb = new ColorByBrightness(c);
    palette.put(c, cbb);

    minHue = min(minHue, cbb.hue);
    maxHue = max(maxHue, cbb.hue);
    minSat = min(minSat, cbb.saturation);
    maxSat = max(maxSat, cbb.saturation);
    minBri = min(minBri, cbb.brightness);
    maxBri = max(maxBri, cbb.brightness);
  }
  // Then sort it
//~   map = new TreeMap(map); // Not needed, after all. So compareTo method is unused.

  println("Hue - Min: " + minHue + ", Max: " + maxHue);
  println("Sat - Min: " + minSat + ", Max: " + maxSat);
  println("Bri - Min: " + minBri + ", Max: " + maxBri);

  background(230);

  image(smallImage, 0, 0);

  shiftColors(smallImage);
  smallImage.updatePixels();

  image(smallImage, smallImage.width, 0);
}

void shiftColors(PImage someImage)
{
  // Pre-condition: loadPixels have been done
  for (int i = 0; i < someImage.pixels.length; i++)
  {
    color oc = someImage.pixels[i];  // Eliminate alpha
    ColorByBrightness cbb = (ColorByBrightness) palette.get(oc);
    int hue = int(map(cbb.brightness, minBri, maxBri,
        0,  // hue = 0 => red
        85));  // 85 => green
    // Keep original saturation and brightness (can be mapped too)
    color nc = color(hue,
        cbb.saturation,
        cbb.brightness);
    someImage.pixels[i] = nc;
  }
}

/**
 * Color class which is sortable by brightness.
 */
class ColorByBrightness implements Comparable
{
  color baseColor;
  int hue, saturation, brightness;

  ColorByBrightness(color c)
  {
    baseColor = c;
    // Pre-compute values
    hue = int(hue(c));
    saturation = int(saturation(c));
    brightness = int(brightness(c));
  }

  public int compareTo(Object o)
  {
    if (this == o) return 0; // Identity
    if (!(o instanceof ColorByBrightness)) throw new ClassCastException(); // Wrong type
    ColorByBrightness cbb = (ColorByBrightness) o;
    if (brightness > cbb.brightness) return  1;
    if (brightness < cbb.brightness) return -1;
    return 0; // Equal
  }
  public boolean equals(Object cbb)
  {
     if (this == cbb) return true;  // Identity
     if (!(cbb instanceof ColorByBrightness)) return false; // Wrong type
     if (baseColor == ((ColorByBrightness) cbb).baseColor) return true;
     return false;
  }
}
