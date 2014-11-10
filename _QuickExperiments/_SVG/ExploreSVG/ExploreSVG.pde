PShape file;
 
void setup() 
{
  size(800,600);
  file = loadShape("Simple.svg");
  println(file);
 
  println(file.getVertexCount());
  println(file.getChildCount());
  println();
  println(getFamilyName(file.getChild(1).getFamily()));
  println(file.getChild(1).getChildCount());
  println();
  PShape c = file.getChild(1).getChild(1).getChild(0); 
  println(c);
  println(c.getChildCount());
  println(getFamilyName(c.getFamily()));
  println(getKindName(c.getKind()));
  println(c.getParams());
}
 
void draw() 
{
  background(50);
  shape(file);
}

String getFamilyName(int family) 
{
  switch (family) 
  {
  case GROUP:
    return "GROUP";
  case PShape.PRIMITIVE:
    return "PRIMITIVE";
  case PShape.GEOMETRY:
    return "GEOMETRY";
  case PShape.PATH:
    return "PATH";
  }
  return "unknown: " + family;
}

String getKindName(int kind) 
{
  switch (kind) 
  {
  case LINE:
    return "LINE";
  case PShape.ELLIPSE:
    return "ELLIPSE";
  case PShape.RECT:
    return "RECT";
  case 0:
    return "(PATH)";
  }
  return "unknown: " + kind;
}

