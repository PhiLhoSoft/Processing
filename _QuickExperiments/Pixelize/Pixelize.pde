PImage original;
PGraphics pixelized;
final int TIME = 2000;
int lastTime = -TIME;
int level = 1;
 
void setup()
{
  size(400, 400);
  original = loadImage("G:/Images/Hugh-Lauries.jpg");
  pixelized = createGraphics(original.width, original.height, JAVA2D);
}
 
void draw()
{
  if (millis() - lastTime > TIME)
  {
    lastTime = millis();
    level *= 2;
    background(255);
    pixelize();
    image(pixelized, 20, 20);
  }
}
 
void pixelize()
{
  int w = original.width / level;
  int h = original.height / level;
  if (w < 1 || h < 1)
  {
    noLoop();
    return;
  }
  color[] colors = new color[w * h];
  println(level + " " + w + "x" + h);
  
  pixelized.beginDraw();
  pixelized.noStroke();
  for (int i = 0; i < level; i++)
  {
    for (int j = 0; j < level; j++)
    {
      int cellPos = i * w + j * h;
      for (int x = 0; x < w; x++)
      {
        for (int y = 0; y < h; y++)
        {
          int pixelPos = x + w * y;
          int pos = (i * w + x) + (j * h + y) * original.width;
          colors[pixelPos] = original.pixels[pos];
        } 
      }
      color c = averageColors(colors);
      pixelized.fill(c);
      pixelized.rect(i * w, j * h, w, h);
    }
  }
  pixelized.endDraw();
}
 
color averageColors(color[] colors)
{
  long r = 0;
  long g = 0;
  long b = 0;
  for (color c : colors)
  {
    r += (c >> 16) & 0xFF;
    g += (c >> 8) & 0xFF;
    b += c & 0xFF;
  }
  int len = colors.length;
  int ar = (int) (r / len);
  int ag = (int) (g / len);
  int ab = (int) (b / len);
  return 0xFF000000 | (ar << 16) | (ag << 8) | ab;
}

