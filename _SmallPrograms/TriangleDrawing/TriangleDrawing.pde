// Inspiration: https://forum.processing.org/topic/help-21-5-2012

float MIN_DIST = 20;

PVector lastPoint = new PVector();
List<Triangle> triangles = new ArrayList<Triangle>();

void setup()
{
  size(800, 800);
  smooth();

  PVector ctp1 = new PVector(30, 20);
  PVector ctp2 = new PVector(10, 30);
  addTriangle(ctp1, ctp2);
}

void draw()
{
  background(255);
  for (Triangle tri : triangles)
  {
    tri.draw();
  }
}

void mouseMoved()
{
  if (dist(mouseX, mouseY, lastPoint.x, lastPoint.y) > MIN_DIST)
  {
    if (findClosestCorners())
    {
      addTriangle(closestCorner1, closestCorner2);
    }
  }
}

void addTriangle(PVector c1, PVector c2)
{
  lastPoint.x = mouseX;
  lastPoint.y = mouseY;
  Triangle tri = new Triangle(lastPoint, c1, c2);
  triangles.add(tri);
}

// Lazy multiple return: use two global variables. OK here, not in multithread, etc.
PVector closestCorner1, closestCorner2;
boolean findClosestCorners()
{
  PVector mouse = new PVector(mouseX, mouseY);
  TreeMap<Float, Triangle>

  float smallestDist1 = Float.MAX_VALUE;
  float smallestDist2 = Float.MAX_VALUE;
  for (Triangle tri : triangles)
  {
    float dist = squareDist(mouse, tri.c1);

  }
}

// square dist is faster than dist() and enough to compare distances.
float squareDist(PVector v1, PVector v2)
{
  float x = v1.x - v2.x;
  float y = v1.y - v2.y;
  return x * x + y + y;
}
