XMLElement xml;
final int SPACING = 30;

void setup()
{
  size(800, 300);
  smooth();
  noLoop();
  background(#AAFFEE);

  fill(#AAFF00);
  ReadMine1();
  fill(#BBEE00);
  ReadMine2();
  fill(#CCDD00);
  ReadOriginal();
}

void ReadMine1()
{
  xml = new XMLElement(this, "mine1.xml");
  int numPics = xml.getChildCount();
  int pos = SPACING;
  for (int i = 0; i < numPics; i++)
  {
    XMLElement pic = xml.getChild(i);
    int w = pic.getIntAttribute("width");
    int h = pic.getIntAttribute("height");
//    println("Got: " + w + " " + h);

    rect(pos, SPACING, w, h);
    pos += w + SPACING;
  }
}

void ReadMine2()
{
  xml = new XMLElement(this, "mine2.xml");
  int numPics = xml.getChildCount();
  int pos = 2 * SPACING;
  for (int i = 0; i < numPics; i++)
  {
    XMLElement pic = xml.getChild(i);
    XMLElement wEl = pic.getChild(0);
    XMLElement hEl = pic.getChild(1);
    int w = int(wEl.getContent());
    int h = int(hEl.getContent());
//    println("Got: " + w + " " + h);

    rect(pos, 2 * SPACING, w, h);
    pos += w + SPACING;
  }
}

void ReadOriginal()
{
  xml = new XMLElement(this, "original.xml");
  int numPics = xml.getChildCount();
  int pos = 3 * SPACING;
  for (int i = 0; i < numPics; i++)
  {
    XMLElement pic = xml.getChild(i);
    XMLElement wEl = pic.getChild(0);
    XMLElement hEl = pic.getChild(1);
    int w = wEl.getIntAttribute("pw");
    int h = hEl.getIntAttribute("ph");
    println("Got: " + w + " " + h);

    rect(pos, 3 * SPACING, w, h);
    pos += w + SPACING;
  }
}

