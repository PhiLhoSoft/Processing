XMLElement xml;

void setup()
{
  size(800, 800);
  smooth();
  noLoop();
  background(#AAFFEE);

  fill(#AAFF00);
  ReadXMLData();
}

void ReadXMLData()
{
  xml = new XMLElement(this, "rss.xml"); // rss
  println(xml.getName());
  XMLElement e = xml.getChild(0); // channel
  println(e.getName());
  e = e.getChild(0); // title
  println(e.getName());
  String t = e.getContent();
  println(t);
}

