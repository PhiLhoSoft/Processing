String TEST_FILE = "Test.jpg";
String URL = "https://ccrma.stanford.edu/~crg/images/open_mouth.jpg";
PImage img;

void setup()
{
  size(400, 350);
  
  img = loadImage(TEST_FILE);
  if (img == null) // Not downloaded yet
  {
    img = loadImage(URL);
    img.save(TEST_FILE); // Cache of the file
  }  
  image(img, 0, 0);
}

void mousePressed()
{
  float low = 255, high = 0;
  for (int i = 0; i < img.pixels.length; i++)
  {
    float b = brightness(img.pixels[i]);
    if (b < low)
    {
      low = b;
    }
    if (b > high)
    {
      high = b;
    }
  }
  println(low + " " + high);
  
  PGraphics halftone = createGraphics(img.width, img.height, JAVA2D);
  halftone.beginDraw();
  halftone.fill(0);
  halftone.noStroke();
  halftone.smooth();
  for (int i = 0; i < 2 * img.width; i += 20)
  {
//    halftone.line(, 0, i, img.height);
    for (int x = i - img.width; x < i; x++)
    {
      int y = int(map(x, i - img.width, i, 0, img.height));
      if (x < 0)
        continue;
      float b = brightness(get(x, y)); // Might do an average of the region
      float d = map(b, low, high, 0, 10);
      halftone.ellipse(x, y, d, d); 
    }
  }
  halftone.endDraw();
  background(255);
  image(halftone, 0, 0);
}

void draw() {} // Needed for mousePressed
