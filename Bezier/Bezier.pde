/**
Experiment with Bézier curves.
http://en.wikipedia.org/wiki/B%C3%A9zier_curve

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2008/04/28 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/
BezierCurve bc1, bc2;
boolean bUseNative = true; // If true, uses Processing's bezierTangent function, which is bugged in 0135. Allows to show the issue.

int canvasHeight = 400;
int canvasWidth = 400;
int margin1 = 20;
int margin2 = 50;

void setup()
{
  size(canvasHeight, canvasWidth);

  bc1 = new BezierCurve(
    new Point(margin1, canvasHeight - margin1), // Start point: bottom left
    new Point(margin1, margin2),     // Start control point: top left
    new Point(canvasWidth - margin1, margin2),  //End control point: top right
    new Point(canvasWidth - margin1, canvasHeight - margin1) // End point: bottom right
  );

  bc2 = new BezierCurve(
    new Point(margin1, canvasHeight - margin1), // Start point: bottom left
    new Point(canvasWidth - margin2, canvasHeight - margin1), // Start control point: bottom right
    new Point(margin1, margin1),     // End control point: top left
    new Point(canvasWidth - margin1, margin1)  // End point: top right
  );
}


/**
 * Simple 2D point class with float storage.
 */
class Point
{
  private float m_x, m_y;

  Point(float x, float y)
  {
    m_x = x; m_y = y;
  }

  Point(Point p)
  {
    m_x = p.GetX(); m_y = p.GetY();
  }

  void SetLocation(float x, float y)
  {
    m_x = x; m_y = y;
  }
  void SetLocation(Point p)
  {
    m_x = p.GetX(); m_y = p.GetY();
  }

  float GetX() { return m_x; }
  float GetY() { return m_y; }

  String toString()
  {
    return "x=" + m_x + ", y=" + m_y;
  }
}


class BezierCurve
{
  Point m_startPoint, m_endPoint;
  Point m_startControlPoint, m_endControlPoint;
//boolean bDump = true;

  BezierCurve(Point startPoint, Point startControlPoint, Point endControlPoint, Point endPoint)
  {
    m_startPoint = startPoint;
    m_endPoint = endPoint;
    m_startControlPoint = startControlPoint;
    m_endControlPoint = endControlPoint;
  }

  /**
   * Gets a point on the Bézier curve, given a relative "distance" from the starting point,
   * expressed as a float number between 0 (start point) and 1 (end point).
   */
  Point GetPoint(float pos)
  {
    float x = bezierPoint(m_startPoint.GetX(), m_startControlPoint.GetX(),
        m_endControlPoint.GetX(), m_endPoint.GetX(),
        pos);
    float y = bezierPoint(m_startPoint.GetY(), m_startControlPoint.GetY(),
        m_endControlPoint.GetY(), m_endPoint.GetY(),
        pos);
    return new Point(x, y);
  }

  // The fixed function as seen in SVN: http://dev.processing.org/source/index.cgi/trunk/processing/core/src/processing/core/PGraphics.java?rev=3787&view=markup
  public float newBezierTangent(float a, float b, float c, float d, float t)
  {
    return 3*t*t * (-a+3*b-3*c+d) +
        6*t * (a-2*b+c) +
        3 * (-a+b);
  }
  /**
   * Gets the tangent of a point (see GetPoint) on the Bézier curve, as an angle with positive x axis.
   * Uses Processing's bezierTangent, which is broken in 0135, and should be fixed for 0136 and higher.
   */
  float GetTangent(float pos)
  {
    float x = bezierTangent(m_startPoint.GetX(), m_startControlPoint.GetX(),
        m_endControlPoint.GetX(), m_endPoint.GetX(),
        pos);
    float y = bezierTangent(m_startPoint.GetY(), m_startControlPoint.GetY(),
        m_endControlPoint.GetY(), m_endPoint.GetY(),
        pos);
//if (bDump) { println(180*atan2(y, x)/PI); if (pos == 1.0) bDump = false; }
    return atan2(y, x);
  }

  /**
   * Gets the tangent of a point (see GetPoint) on the Bézier curve, as an angle with positive x axis.
   * Uses fixed routine...
   */
  float GetRealTangent(float pos)
  {
    float x = newBezierTangent(m_startPoint.GetX(), m_startControlPoint.GetX(),
        m_endControlPoint.GetX(), m_endPoint.GetX(),
        pos);
    float y = newBezierTangent(m_startPoint.GetY(), m_startControlPoint.GetY(),
        m_endControlPoint.GetY(), m_endPoint.GetY(),
        pos);
//if (bDump) { println(180*atan2(y, x)/PI); if (pos == 1.0) bDump = false; }
    return atan2(y, x);
  }

  void Draw()
  {
    bezier(m_startPoint.GetX(), m_startPoint.GetY(),
        m_startControlPoint.GetX(), m_startControlPoint.GetY(),
        m_endControlPoint.GetX(), m_endControlPoint.GetY(),
        m_endPoint.GetX(), m_endPoint.GetY());
  }

  /**
   * Visualizes control points.
   */
  void DrawControls()
  {
    noFill();
    stroke(#FF8000);
    strokeWeight(1);

    line(m_startPoint.GetX(), m_startPoint.GetY(), m_startControlPoint.GetX(), m_startControlPoint.GetY());
    ellipse(m_startControlPoint.GetX(), m_startControlPoint.GetY(), 4, 4);

    line(m_endPoint.GetX(), m_endPoint.GetY(), m_endControlPoint.GetX(), m_endControlPoint.GetY());
    ellipse(m_endControlPoint.GetX(), m_endControlPoint.GetY(), 4, 4);
  }

  void DrawDetails(int pointNb, float tanLength)
  {
    if (pointNb <= 1) pointNb = 2;
    stroke(#FF0000);
    strokeWeight(1);

    for (int i = 0; i < pointNb; i++)
    {
      float pos = (float) i / (pointNb - 1);

      Point pt = GetPoint(pos);
      float x = pt.GetX(), y = pt.GetY();
      float a = bUseNative ? GetTangent(pos) : GetRealTangent(pos);

      line(x, y, cos(a) * tanLength + x, sin(a) * tanLength + y);
      ellipse(x, y, 3, 3);

      ellipse(x, y, 3, 3);
    }
  }
}


void draw()
{
  if (dragging == 1)
  {
    p1x = mouseX; p1y = mouseY;
  }
  else if (dragging == 2)
  {
    h1x = mouseX; h1y = mouseY;
  }
  else if (dragging == 3)
  {
    h2x = mouseX; h2y = mouseY;
  }
  else if (dragging == 4)
  {
    p2x = mouseX; p2y = mouseY;
  }

  background(#AAAAAA);

  bc1.DrawControls();

  // Show Bézier curve
  stroke(#8080FF);
  strokeWeight(3);
  bc1.Draw();

  bc1.DrawDetails(10, 30);

  bc2.DrawControls();

  // Show Bézier curve
  stroke(#80FF80);
  strokeWeight(3);
  bc2.Draw();

  bc2.DrawDetails(10, 60);
}

float p1x, p1y, h1x, h1y, h2x, h2y, p2x, p2y;
int dragging = 0;

void mousePressed()
{
  if (mouseX > p1x-3 && mouseX < p1x+3 && mouseY > p1y-3 && mouseY < p1y+3)
  {
    dragging = 1;
  }
  else if (mouseX > h1x-3 && mouseX < h1x+3 && mouseY > h1y-3 && mouseY < h1y+3)
  {
    dragging = 2;
  }
  else if (mouseX > h2x-3 && mouseX < h2x+3 && mouseY > h2y-3 && mouseY < h2y+3)
  {
    dragging = 3;
  }
  else if (mouseX > p2x-3 && mouseX < p2x+3 && mouseY > p2y-3 && mouseY < p2y+3)
  {
    dragging = 4;
  }
}

void mouseReleased()
{
  dragging = 0;
}
