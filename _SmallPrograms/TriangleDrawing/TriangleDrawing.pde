// Inspiration: https://forum.processing.org/topic/help-21-5-2012

float MIN_DIST = 20;
float MAX_DIST = 30;

PVector lastPoint = new PVector();
List<Line> lines = new ArrayList<Line>();

void setup()
{
  size(800, 800);
  smooth();

  PVector sp1 = new PVector(30, 20);
  PVector sp2 = new PVector(10, 30);
  addLines(sp1, sp2);
}

void draw()
{
  background(255);
  for (Line line : lines)
  {
    line.draw();
  }
}

void mouseMoved()
{
  if (dist(mouseX, mouseY, lastPoint.x, lastPoint.y) > MIN_DIST)
  {
    if (findClosestPoints())
    {
      addLines(closestPoint1, closestPoint2);
    }
  }
}

void addLines(PVector c1, PVector c2)
{
  lastPoint.x = mouseX;
  lastPoint.y = mouseY;
  Line line = new Line(lastPoint, c1);
  lines.add(line);
  line = new Line(lastPoint, c2);
  lines.add(line);
}

// Lazy multiple return: use two global variables. OK here, not in multithread, etc.
PVector closestPoint1, closestPoint2;
boolean findClosestPoints()
{
  PVector mouse = new PVector(mouseX, mouseY);
  TreeMap<Float, PVector> distances = new TreeMap<Float, PVector>();
  for (Line line : lines)
  {
    float dist = squareDist(mouse, line.p1);
    distances.put(dist, line.p1);
    dist = squareDist(mouse, line.p2);
    distances.put(dist, line.p2);
  }
  Set<Float> navig = distances.keySet();
  int count = 0;
  float maxDist = MAX_DIST * MAX_DIST;
  Iterator<Float> iter = navig.iterator();
  while (iter.hasNext() && count < 2)
  {
    Float sqD = iter.next();
    if (sqD < maxDist)
    {
      PVector pv = distances.get(sqD);
      if (count == 0)
      {
        closestPoint1 = pv;
      }
      else if (count == 1)
      {
        closestPoint2 = pv;
      }
      count++;
    }
  }
  return count == 2;
}

// square dist is faster than dist() and enough to compare distances.
float squareDist(PVector v1, PVector v2)
{
  float x = v1.x - v2.x;
  float y = v1.y - v2.y;
  return x * x + y + y;
}
