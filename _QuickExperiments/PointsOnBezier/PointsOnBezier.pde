BezierCurve bc1, bc2;

int margin1 = 20;
int margin2 = 50;

void setup()
{
  size(400, 400);

  bc1 = new BezierCurve(
    new PVector(margin1, height - margin1), // Start point: bottom left
    new PVector(margin1, margin2),     // Start control point: top left
    new PVector(width - margin1, margin2),  //End control point: top right
    new PVector(width - margin1, height - margin1) // End point: bottom right
  );

  bc2 = new BezierCurve(
    new PVector(margin1, height - margin1), // Start point: bottom left
    new PVector(width - margin2, height - margin1), // Start control point: bottom right
    new PVector(margin1, margin1),     // End control point: top left
    new PVector(width - margin1, margin1)  // End point: top right
  );
}

class BezierCurve
{
  PVector m_startPoint, m_endPoint;
  PVector m_startControlPoint, m_endControlPoint;
//boolean bDump = true;

  BezierCurve(PVector startPoint, PVector startControlPoint, PVector endControlPoint, PVector endPoint)
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
  PVector GetPoint(float pos)
  {
    float x = bezierPoint(m_startPoint.x, m_startControlPoint.x,
        m_endControlPoint.x, m_endPoint.x,
        pos);
    float y = bezierPoint(m_startPoint.y, m_startControlPoint.y,
        m_endControlPoint.y, m_endPoint.y,
        pos);
    return new PVector(x, y);
  }

  void Draw()
  {
    bezier(m_startPoint.x, m_startPoint.y,
        m_startControlPoint.x, m_startControlPoint.y,
        m_endControlPoint.x, m_endControlPoint.y,
        m_endPoint.x, m_endPoint.y);
  }

  void DrawDetailsNb(int pointNb)
  {
    if (pointNb <= 1) pointNb = 2;
    stroke(#FF0000);
    strokeWeight(1);

    for (int i = 0; i < pointNb; i++)
    {
      float pos = (float) i / (pointNb - 1);

      PVector pt = GetPoint(pos);
      ellipse(pt.x, pt.y, 3, 3);
    }
  }

  void DrawDetailsDist(float dist)
  {
    stroke(#FFFF00);
    strokeWeight(1);

    // Use an arbitrary number of points, it is hard to estimate
    // the length of a curve
    int pointNb = 1000;
    float totalDist = 0;
    PVector prevPt = m_startPoint;
    ellipse(prevPt.x, prevPt.y, 7, 7);
    for (int i = 1; i < pointNb; i++)
    {
      float pos = (float) i / (pointNb - 1);

      PVector pt = GetPoint(pos);
      totalDist += dist(pt.x, pt.y, prevPt.x, prevPt.y);
      if (totalDist >= dist)
      {
        ellipse(pt.x, pt.y, 7, 7);
        totalDist = 0;
      }
      prevPt = pt;
    }
  }
}

void draw()
{
  background(#AACCFF);
  noFill();

  stroke(#80A0FF);
  strokeWeight(3);
  bc1.Draw();

  bc1.DrawDetailsNb(10);
  bc1.DrawDetailsDist(60);

  stroke(#80FF80);
  strokeWeight(3);
  bc2.Draw();

  bc2.DrawDetailsNb(10);
  bc2.DrawDetailsDist(60);
}

