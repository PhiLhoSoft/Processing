XMLElement xml;
final int SPACING_X = 30;
final int SPACING_Y = 10;
final int MAX_HEIGHT = 200;

void setup()
{
  size(800, 800);
  smooth();
  noLoop();
  background(#AAFFEE);

  fill(#AAFF00);
  ReadMine1();
}

void ReadMine1()
{
  xml = new XMLElement(this, "mine1.xml");
  int numPics = xml.getChildCount();
  int posX = SPACING_X;
  int posY = SPACING_Y;
  int maxHeight = 0;
  for (int i = 0; i < numPics; i++)
  {
    XMLElement pic = xml.getChild(i);
    int w = pic.getIntAttribute("width");
    int h = pic.getIntAttribute("height");

    // If new rectangle doesn't fit in the remainder of the line
    if (posX + w > width - SPACING_X)
    {
      // Start a new line
      posX = SPACING_X;
      posY += SPACING_Y + maxHeight;
      maxHeight = 0;
    }
    // Keep track of tallest rectangle on this line
    // to get even spacing of lines (ie. smallest spacing)
    if (h > maxHeight) maxHeight = h;

    rect(posX, posY, w, h);
    posX += w + SPACING_X;
  }
}

