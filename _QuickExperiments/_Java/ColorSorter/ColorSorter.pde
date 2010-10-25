// http://processing.org/discourse/yabb2/YaBB.pl?num=1276151592

final int GRANULARITY = 16;

class SmallColor
{
  final int r;
  final int g;
  final int b;
  
  SmallColor(int pr, int pg, int pb)
  {
    r = pr; g = pg; b = pb;
  }
  
  color GetColor()
  {
    return color(r, g, b); 
  }
  
  int hashCode()
  {
    return (r * GRANULARITY + g) * GRANULARITY + b;
  }
  boolean equals(Object o)
  {
    SmallColor sc = (SmallColor) o;
    return r == sc.r && g == sc.g && b == sc.b;
  }
}

void setup()
{
  size(500, 500);
  background(255);
  println(GRANULARITY);
  colorMode(RGB, GRANULARITY);
  
  HashMap colors = new HashMap(GRANULARITY * GRANULARITY * GRANULARITY);
  PImage img = loadImage("D:/Dev/PhiLhoSoft/images/map.jpg");
  image(img, 0, 0);
  for (int i = 0; i < img.pixels.length; i++) 
  {
    SmallColor sc = new SmallColor(
        (int) red(img.pixels[i]),
        (int) green(img.pixels[i]),
        (int) blue(img.pixels[i]));
    Integer frequency = (Integer) colors.get(sc);
    if (frequency == null)
    {
      // Not in map yet
      Integer value = Integer.valueOf(1);
      colors.put(sc, value);
    }
    else
    {
      Integer value = Integer.valueOf(1 + frequency);
      colors.put(sc, value);
    }
  }
  int colorNb = colors.size();
  println(colorNb + " colors ranges found");

  ArrayList listOfColors = new ArrayList(colors.entrySet());
  Collections.sort(listOfColors, new Comparator()
  {
    public int compare(Object o1, Object o2)
    {
      Map.Entry entry1 = (Map.Entry) o1;
      Map.Entry entry2 = (Map.Entry) o2;
      int val1 = (Integer) entry1.getValue();
      int val2 = (Integer) entry2.getValue();
      if (val1 == val2)
        return 0;
      if (val1 < val2)
        return 1;
      return -1;
    }
  });
  final int diam = 20;
  noStroke();
  fill(GRANULARITY);
  rect(width - 2 * diam, 0, 2 * diam, height);
  for (int i = 0; i < 10; i++)
  {
    Map.Entry me = (Map.Entry) listOfColors.get(i);
    SmallColor top = (SmallColor) me.getKey();
    println((Integer) me.getValue() + " " + hex(top.GetColor()));
    fill(top.GetColor());
    ellipse(width - diam, diam + i * diam * 2, diam, diam);
  }
}

