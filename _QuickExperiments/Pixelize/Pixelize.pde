// https://forum.processing.org/topic/change-pixel

PImage original;
PGraphics pixelized;
final int TIME = 500;
int lastTime = -TIME;
float levelFactor = 1.1;
float level = 1.9 / levelFactor;

void setup()
{
  size(400, 400);
  original = loadImage("Hugh-Lauries.jpg");
  pixelized = createGraphics(original.width, original.height, JAVA2D);
}
 
void draw()
{
  if (millis() - lastTime > TIME)
  {
    lastTime = millis();
    level *= levelFactor;
    background(#FAFDFF);
    pixelize();
    image(pixelized, 20, 20);
  }
}
 
void pixelize()
{
  int iLevel = int(level);
  // Width and height of a cell for this level
  int w = original.width / iLevel;
  int h = original.height / iLevel;
  if (w < 1 || h < 1)
  {
    noLoop();
    println("Done");
    return;
  }
  println(level + " -> " + w + "x" + h);
  // We have some extra pixels to distribute
  int excessW = original.width - w * iLevel;
  int excessH = original.height - h * iLevel;
  // We will distribute them in the middle
  int excPosX = (iLevel - excessW) / 2;
  int excPosY = (iLevel - excessH) / 2;
//  println(excessW + "x" + excessH + " - " + excPosX + "x" + excPosY);
  
  pixelized.beginDraw();
  pixelized.noStroke();
  // Position of each cell
  int posX = 0;
  for (int i = 0; i < iLevel; i++)
  {
    int cw = w;
    if (i >= excPosX && excessW > 0)
    {
      cw++; excessW--;
    }
    int rowExcessH = excessH;
    int posY = 0;
    for (int j = 0; j < iLevel; j++)
    {
      int ch = h;
      if (j >= excPosY && rowExcessH > 0)
      {
        ch++; rowExcessH--;
      }
      color[] colors = new color[cw * ch];
      for (int x = 0; x < cw; x++)
      {
        for (int y = 0; y < ch; y++)
        {
          int pixelPos = x + cw * y;
          int pos = (posX + x) + (posY + y) * original.width;
//println(posX + " " + posY + " - " + x + " " + y + " - " + cw + " " + ch);
          colors[pixelPos] = original.pixels[pos];
        } 
      }
      color c = averageColors(colors);
      pixelized.fill(c);
      pixelized.rect(posX, posY, cw, ch);
      
      posY += ch;
    }
    posX += cw;
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
  int ar = int(r / len);
  int ag = int(g / len);
  int ab = int(b / len);
  return 0xFF000000 | (ar << 16) | (ag << 8) | ab;
}

