PImage niceImage;
SortableColor[] colors;
PImage sortedImage;
boolean bSortOnHue;

void setup()
{
  size(1000, 800);
  noLoop();

  niceImage = loadImage("G:/Images/backdrop.png");

  image(niceImage, 0, 0);
}

void draw() {} // Enable events

void mousePressed()
{
  bSortOnHue = mouseButton == RIGHT;
  
  niceImage.loadPixels();
  int colorNb = niceImage.pixels.length;
  colors = new SortableColor[colorNb];
  println("Making sortable color array");
  for (int i = 0; i < colorNb; i++)
  {
    colors[i] = new SortableColor(niceImage.pixels[i]);
  }
  println("Sorting the array");
  Arrays.sort(colors, new ColorComparator());
  println("Done, making the sorted image");
  sortedImage = niceImage.get(); // Clone as quick creation way
  sortedImage.loadPixels();
  for (int i = 0; i < colorNb; i++)
  {
    sortedImage.pixels[i] = colors[i].originalColor;
  }
  sortedImage.updatePixels();
  image(sortedImage, width - sortedImage.width, height - sortedImage.height);
  println("Done");
  redraw();
}

class SortableColor
{
  color originalColor;
  float brightness;
  float hue;

  SortableColor(color c)
  {
    originalColor = c;
    brightness = brightness(c);
    hue = hue(c);
  }
}

class ColorComparator implements Comparator<SortableColor>
{
  int compare(SortableColor sc1, SortableColor sc2)
  {
    if (bSortOnHue)
      return int(sc1.hue - sc2.hue);
    return int(sc1.brightness - sc2.brightness);
  }
}

