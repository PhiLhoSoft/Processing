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
  if (millis() - lastTime > TIME) // Don't update too frequently...
  {
    lastTime = millis();
    // Increase the level by the given factor
    level *= levelFactor;
    background(#FAFDFF);
    // Do the pixelization in the pixelized image
    pixelize();
    image(pixelized, 20, 20);
  }
}

void pixelize()
{
  // We will divide the images in n cells: iLevel cells horizontally and vertically
  int iLevel = int(level);
  // Width and height of a cell for this level (number of pixels on each dimension)
  int w = original.width / iLevel;
  int h = original.height / iLevel;
  // Are we gone too far? Cells smaller than a pixel are hard to compute and display :-)
  if (w < 1 || h < 1)
  {
    // Stop the display on the last image
    noLoop();
    // Warn...
    println("Done");
    return;
  }
  // Simple use feedback
  println(level + " -> " + w + "x" + h);
  // We have some extra pixels to distribute:
  // iLevel cells * width of a cell is smaller than the original width, because of integer rounding
  // The excessW is always smaller than w, of course.
  int excessW = original.width - w * iLevel;
  int excessH = original.height - h * iLevel;
  // We will distribute these extra pixels in the middle of the cell sucession
  int excPosX = (iLevel - excessW) / 2;
  int excPosY = (iLevel - excessH) / 2;
//  println(excessW + "x" + excessH + " - " + excPosX + "x" + excPosY);

  pixelized.beginDraw();
  pixelized.noStroke();
  // Position of each cell, horizontally
  int posX = 0;
  for (int i = 0; i < iLevel; i++)
  {
    // Current width of the this cell: by default, the width computed for all cells
    int cw = w;
    // If we reached excPosX, the point where we need to distribute extra pixels,
    // and if we still have such extra pixels to distribute
    if (i >= excPosX && excessW > 0)
    {
      // We just increase the cell width by one (that's enough)
      cw++;
      // And that's one extra pixel less to distribute
      excessW--;
    }
    // Extra pixels to distribute for this column
    int columnExcessH = excessH;
    // Position of each cell, vertically
    int posY = 0;
    for (int j = 0; j < iLevel; j++)
    {
      // Current height of the this cell: see above comments
      int ch = h;
      if (j >= excPosY && columnExcessH > 0)
      {
        ch++;
        columnExcessH--;
      }
      // The colors that can be found on this cell
      color[] colors = new color[cw * ch];
      // Get 'em all!
      for (int x = 0; x < cw; x++)
      {
        for (int y = 0; y < ch; y++)
        {
          // Position in the array of colors
          int pixelPos = x + cw * y;
          // Position in the image, combining the position of the cell itself, and the position in the cell
          int pos = (posX + x) + (posY + y) * original.width;
//println(posX + " " + posY + " - " + x + " " + y + " - " + cw + " " + ch);
          colors[pixelPos] = original.pixels[pos];
        }
      }
      // Average this list of colors
      color c = averageColors(colors);
      // Use this average as fill color
      pixelized.fill(c);
      // And draw a rectangle of the size of the cell
      pixelized.rect(posX, posY, cw, ch);

      // Next cell, vertically
      posY += ch;
    }
    // Next cell, horizontally
    posX += cw;
  }
  pixelized.endDraw();
}

// Colors must be averaged on each channel
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

