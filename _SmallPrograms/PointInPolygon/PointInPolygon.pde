// Based on classical Paul Bourke geometry articles
// http://paulbourke.net/geometry/lineline2d/
// http://paulbourke.net/geometry/insidepoly/

List<PVector> polygonPoints = new ArrayList<PVector>();
List<PVector> holePoints = new ArrayList<PVector>();

final color BG_COLOR = #DDEEFF;

final String POLYGON_POINT = "PP";
final String HOLE_POINT = "HP";
final String SEP = "\t";

void setup()
{
  size(500, 500);
  smooth();
}

void draw()
{
  background(BG_COLOR);

  fill(255);
  stroke(#0044FF);
  strokeWeight(4);

  beginShape();
  for (PVector point : polygonPoints)
  {
    vertex(point.x, point.y);
  }
  if (polygonPoints.size() > 2 && holePoints.size() > 0)
  {
    // Close shape
    PVector firstPoint = polygonPoints.get(0);
    vertex(firstPoint.x, firstPoint.y);
    // Start the hole (works only in Java2D!)
    breakShape();
    for (PVector point : holePoints)
    {
      vertex(point.x, point.y);
    }
  }
  endShape(CLOSE);
}

void mousePressed()
{
  PVector point = new PVector((float) mouseX, (float) mouseY);
  if (mouseButton == LEFT)
  {
    polygonPoints.add(point);
  }
  else
  {
    holePoints.add(point);
  }
}

void keyReleased()
{
  switch (key)
  {
  case 't':
//~     DoTriangulation();
    break;
  case 'c':
    polygonPoints.clear();
    holePoints.clear();
    break;
  case 's':
    savePoints();
    break;
  case 'l':
    loadPoints();
    break;
  }
}

void savePoints()
{
  String savePath = selectOutput();
  if (savePath == null)
    return;  // Cancelled

  String[] lines = new String[polygonPoints.size() + holePoints.size()];
  int c = 0;
  for (PVector point : polygonPoints)
  {
//println("ShPt: " + point);
    float x = point.x;
    float y = point.y;
    lines[c++] = POLYGON_POINT + SEP + x + SEP + y;
  }
  for (PVector point : holePoints)
  {
//println("ShPt: " + point);
    float x = point.x;
    float y = point.y;
    lines[c++] = HOLE_POINT + SEP + x + SEP + y;
  }
  saveStrings(savePath, lines);
}

void loadPoints()
{
  String loadPath = selectInput();
  if (loadPath == null)
    return;  // Cancelled

  polygonPoints.clear();
  String[] lines = loadStrings(loadPath);
  for (String line : lines)
  {
    String[] values = line.split(SEP);
    float x = float(values[1]);
    float y = float(values[2]);
    PVector point = new PVector(x, y);
    if (values[0].equals(HOLE_POINT))
    {
      holePoints.add(point);
    }
    else
    {
      polygonPoints.add(point);
    }
  }
}

