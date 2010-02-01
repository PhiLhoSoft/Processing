// Intersection of a line defined by two points in a bounding box, with the sides of this BB
// Motivation: Extend a line segment to bounding box
// http://stackoverflow.com/questions/1520821/extend-a-line-segment-to-bounding-box

boolean USE_SIMPLE_METHOD = true;

int MARGIN = 10;
int POINT_SIZE = 7;

// Definition of the bouding box
float xMin, xMax;
float yMin, yMax;

// The two points inside the bounding box
// A PVector is just a pair of x and y coordinates
PVector pointA = new PVector();
PVector pointB = new PVector();

// The intersection points
PVector[] pointsI = new PVector[2];

void setup()
{
  size(800, 800);
  MakeBB();
  SetPoints();
  if (USE_SIMPLE_METHOD)
    FindSimpleIntersections();
  else
    FindIntersections();
}

void draw()
{
  background(#DDFFFF);
  stroke(#FFFF00);
  fill(#8000FF);
  rect(xMin, yMin, xMax - xMin, yMax - yMin);

  noStroke();
  fill(#FF8000);
  ellipse(pointA.x, pointA.y, POINT_SIZE, POINT_SIZE);
  fill(#FF8000);
  ellipse(pointB.x, pointB.y, POINT_SIZE, POINT_SIZE);
  stroke(#FFFF00);
  strokeWeight(5);
  line(pointA.x, pointA.y, pointB.x, pointB.y);

  noStroke();
  fill(#FF0000);
  ellipse(pointsI[0].x, pointsI[0].y, POINT_SIZE * 2, POINT_SIZE * 2);
  fill(#FF0000);
  ellipse(pointsI[1].x, pointsI[1].y, POINT_SIZE * 2, POINT_SIZE * 2);
  stroke(#FF8000);
  strokeWeight(1);
  line(pointsI[0].x, pointsI[0].y, pointsI[1].x, pointsI[1].y);
}

void keyPressed()
{
  MakeBB();
  SetPoints();
  FindIntersections();
}

// Make bounding box
void MakeBB()
{
  xMin = (int) random(MARGIN, width/2);
  xMax = (int) random(width/2, width - MARGIN);
  yMin = (int) random(MARGIN, height/2);
  yMax = (int) random(height/2, height - MARGIN);
}

void SetPoints()
{
  pointA.x = (int) random(xMin, xMax);
  pointA.y = (int) random(yMin, yMax);
  pointB.x = (int) random(xMin, xMax);
  pointB.y = (int) random(yMin, yMax);
}

void FindIntersections()
{
  println("BB " + xMin + " .. " + xMax + " / " + yMin + " .. " + yMax);
  // The corners of the BB
  PVector pTL = new PVector(xMin, yMin);
  PVector pBL = new PVector(xMin, yMax);
  PVector pTR = new PVector(xMax, yMin);
  PVector pBR = new PVector(xMax, yMax);
  // Against the sides of the BB
  PVector pT = IntersectLines(pTL, pTR);
  PVector pB = IntersectLines(pBL, pBR);
  PVector pL = IntersectLines(pTL, pBL);
  PVector pR = IntersectLines(pTR, pBR);
  println("T: " + pT);
  println("B: " + pB);
  println("L: " + pL);
  println("R: " + pR);

  int i = 0;
  // Eliminates the intersection points out of the segments
  if (pT != null && pT.x >= xMin && pT.x <= xMax) pointsI[i++] = pT;
  if (pB != null && pB.x >= xMin && pB.x <= xMax) pointsI[i++] = pB;
  if (pL != null && pL.y >= yMin && pL.y <= yMax) pointsI[i++] = pL;
  if (pR != null && pR.y >= yMin && pR.y <= yMax) pointsI[i++] = pR;
  println("=> " + i);
  println("1: " + pointsI[0].x + ", " + pointsI[0].y);
  println("2: " + pointsI[1].x + ", " + pointsI[1].y);
}

// Compute intersection of the line made of pointA and pointB
// with the given line defined by two points
// http://en.wikipedia.org/wiki/Line-line_intersection
PVector IntersectLines(PVector p1, PVector p2)
{
  PVector pRes = new PVector();
  float v1 = pointA.x * pointB.y - pointA.y * pointB.x;
  float v2 = p1.x * p2.y - p1.y * p2.x;
  float d = (pointA.x - pointB.x) * (p1.y - p2.y) -
      (pointA.y - pointB.y) * (p1.x - p2.x);
  if (d == 0)
  {
    println("Ouch!");
    return null;
  }
  pRes.x = (v1 * (p1.x - p2.x) - (pointA.x - pointB.x) * v2) / d;
  pRes.y = (v1 * (p1.y - p2.y) - (pointA.y - pointB.y) * v2) / d;
  return pRes;
}

void FindSimpleIntersections()
{
  println("BB " + xMin + " .. " + xMax + " / " + yMin + " .. " + yMax);
  // Test against the sides of the BB
  PVector pT = IntersectHorizontalSegment(yMin, xMin, xMax);
  PVector pB = IntersectHorizontalSegment(yMax, xMin, xMax);
  PVector pL = IntersectVecticalSegment(xMin, yMin, yMax);
  PVector pR = IntersectVecticalSegment(xMax, yMin, yMax);
  println("T: " + pT);
  println("B: " + pB);
  println("L: " + pL);
  println("R: " + pR);

  int i = 0;
  // Eliminates the non-intersecting solutions
  if (pT != null) pointsI[i++] = pT;
  if (pB != null) pointsI[i++] = pB;
  if (pL != null) pointsI[i++] = pL;
  if (pR != null) pointsI[i++] = pR;
  println("=> " + i);
  println("1: " + pointsI[0].x + ", " + pointsI[0].y);
  println("2: " + pointsI[1].x + ", " + pointsI[1].y);
}

PVector IntersectHorizontalSegment(float y, float xMin, float xMax)
{
  float d = pointA.y - pointB.y;
  if (d == 0)
    return null;  // Horizontal line doesn't intersect horizontal segment (unless they have same y)

  float x = -(pointA.x * pointB.y - pointA.y * pointB.x - y * (pointA.x - pointB.x)) / d;
  println("X: " + x);
  if (x < xMin || x > xMax)
    return null;  // Not in segement

  return new PVector(x, y);
}

PVector IntersectVecticalSegment(float x, float yMin, float yMax)
{
  float d = pointA.x - pointB.x;
  if (d == 0)
    return null;  // Vertical line doesn't intersect vertical segment (unless they have same x)

  float y = (pointA.x * pointB.y - pointA.y * pointB.x - x * (pointA.y - pointB.y)) / d;
  println("Y: " + y);
  if (y < yMin || y > yMax)
    return null;  // Not in segement

  return new PVector(x, y);
}

