/**
See if mouse cursor is over a Bézier curve.

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.01.000 -- 2008/09/03 (PL) -- Bad algo in some corner cases. Using awt.geom instead!
 1.00.000 -- 2008/08/27 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/

import java.awt.geom.*;

private static final int CURVE_NB = 7;
private static final boolean RANDOM_CURVES = true;
private static final int margin1 = 20;
private static final int margin2 = 50;

// Make some curves, for testing
BezierCurve[] curves = new BezierCurve[CURVE_NB];

void setup()
{
  size(700, 700);

  if (RANDOM_CURVES)
  {
    for (int i = 0; i < CURVE_NB; i++)
    {
      curves[i] = new BezierCurve(
          // Start point
          random(margin1, width - margin1), random(margin1, height - margin1),
          // First control point
          random(width), random(height),
          // Second control point
          random(width), random(height),
          // End point
          random(margin1, width - margin1), random(margin1, height - margin1)
      );
    }
  }
  else
  {
    int i = 0;
    curves[i++] = new BezierCurve(
        width / 2 - margin1, height - margin1,
        margin1, 2 * margin2,
        width - margin1, 2 * margin2,
        width / 2 + margin1, height - margin1
    );

    curves[i++] = new BezierCurve(
        width / 3, margin1,
        margin1, 2 * margin2,
        width - margin1, 2 * margin2,
        2 * width / 3, margin1
    );

    curves[i++] = new BezierCurve(
        margin1, height - margin1,
        margin1, margin2,
        width - margin1, margin2,
        width - margin1, height - margin1
    );

    curves[i++] = new BezierCurve(
        margin1, height - margin1,
        width - margin2, height - margin1,
        margin1, margin1,
        width - margin1, margin1
    );

    curves[i++] = new BezierCurve(
        width - margin1, margin1,
        width - margin2, height - margin1,
        margin1, margin1,
        margin1, height - margin1
    );

    curves[i++] = new BezierCurve(
        margin1, margin1,
        width - margin2, margin1,
        margin1, height - margin1,
        width - margin1, height - margin1
    );

    curves[i++] = new BezierCurve(
        width - margin1, height - margin1,
        width - margin2, margin1,
        margin1, height - margin1,
        margin1, margin1
    );
  }
}


/**
 * Cubic Bézier curve, defined by two end points and two control points.
 */
// I started as making an independent class, then I discovered that Sun has made already most of the work,
// so I just extend Sun's class to avoid re-inventing the wheel in an inefficient way! :-)
class BezierCurve extends CubicCurve2D.Float // float is good enough for most Processing sketches...
{
  protected static final int CONTROL_POINT_SIZE = 4;
  protected static final int CONTROL_LINE_WIDTH = 1;
  protected static final int CONTROL_COLOR = #FF8000;

  protected static final int INTERNAL_POINT_SIZE = 3;
  protected static final int TANGENT_WIDTH = 1;
  protected static final int INTERNAL_POINT_COLOR = #FF0000;

  // This one must be computed first (and each time)
  private Closest closest;

  /**
   * Need a further call to setCurve() later, to be useful...
   */
  BezierCurve()
  {
    super();
  }
  BezierCurve(float x1, float y1, float ctrlx1, float ctrly1, float ctrlx2, float ctrly2, float x2, float y2)
  {
    super(x1,  y1,  ctrlx1,  ctrly1,  ctrlx2,  ctrly2,  x2,  y2);
  }

  /**
   * Gets a point on the Bézier curve, given a relative "distance" from the starting point,
   * expressed as a float number between 0 (start point) and 1 (end point).
   */
  Point2D.Float GetPoint(float pos)
  {
    float rem = 1.0F - pos; // Remainder of distance (or distance to end point)
    double f1 =     rem * rem * rem;
    double f2 = 3 * pos * rem * rem;
    double f3 = 3 * pos * pos * rem;
    double f4 =     pos * pos * pos;
    double x = f1 * x1 + f2 * ctrlx1 + f3 * ctrlx2 + f4 * x2;
    double y = f1 * y1 + f2 * ctrly1 + f3 * ctrly2 + f4 * y2;
    return new Point2D.Float((float) x, (float) y);
  }

  /**
   * Gets the tangent of a point (see GetPoint) on the Bézier curve,
   * as an angle with the positive x axis.
   */
  float GetTangent(float pos)
  {
    double x = 3 * pos * pos * (-x1 + 3 * ctrlx1 - 3 * ctrlx2 + x2) +
        6 * pos * (x1 - 2 * ctrlx1 + ctrlx2) +
        3 * (-x1 + ctrlx1);
    double y = 3 * pos * pos * (-y1 + 3 * ctrly1 - 3 * ctrly2 + y2) +
        6 * pos * (y1 - 2 * ctrly1 + ctrly2) +
        3 * (-y1 + ctrly1);
    return (float) Math.atan2(y, x);
  }

  void Draw()
  {
    bezier(x1, y1, ctrlx1, ctrly1, ctrlx2, ctrly2, x2, y2);
  }

  /**
   * Visualizes control points.
   */
  void DrawControls()
  {
    noFill();
    stroke(CONTROL_COLOR);
    strokeWeight(CONTROL_LINE_WIDTH);

    line(x1, y1, ctrlx1, ctrly1);
    ellipse(ctrlx1, ctrly1, CONTROL_POINT_SIZE, CONTROL_POINT_SIZE);

    line(x2, y2, ctrlx2, ctrly2);
    ellipse(ctrlx2, ctrly2, CONTROL_POINT_SIZE, CONTROL_POINT_SIZE);
  }

  /**
   * Draw points on curve and tangents on these points.
   */
  void DrawDetails(int pointNb, float tanLength)
  {
    if (pointNb <= 1) pointNb = 2;
    stroke(INTERNAL_POINT_COLOR);
    strokeWeight(TANGENT_WIDTH);

    for (int i = 0; i < pointNb; i++)
    {
      float pos = (float) i / (pointNb - 1);

      Point2D.Float pt = GetPoint(pos);
      float x = pt.x, y = pt.y;
      float a = GetTangent(pos);

      if (tanLength > 0.0)
      {
        line(x, y, cos(a) * tanLength + x, sin(a) * tanLength + y);
      }
      ellipse(x, y, INTERNAL_POINT_SIZE, INTERNAL_POINT_SIZE);
    }
  }

  void DrawClosestPoint()
  {
    if (closest == null) return;
    fill(#FFFF00);
    stroke(#FF0000);
    strokeWeight(1);
    Point2D.Float p = closest.GetPoint();
    ellipse(p.x, p.y, 4, 4);
  }

  boolean IsPointOnCurve(float x, float y)
  {
    // If point is out of bounding box of the Bézier curve, no point to check more
    // We start at each extremity of the curve
    closest = GetClosest(x, y, 0.0, 1.0);
    do
    {
      // Exit
      if (closest.IsFound())
        return closest.IsOnCurve();
      // Iterate on the closest range
      closest = GetClosest(x, y, closest.GetStart(), closest.GetEnd());
    } while (true); // Rely on internal exits
  }

  /**
   * Simple class to wrap multiple return values.
   */
  class Closest
  {
    float m_r1, m_r2; // Current range on curve
    Point2D.Float m_p;  // If no longer null, it is the point on the curve closest of the searched point
    boolean m_b;  // If true, it means the closest point is on curve
    Closest(float r1, float r2)
    {
      m_r1 = r1; m_r2 = r2;
    }
    Closest(Point2D.Float p, boolean b)
    {
      m_p = p;
      m_b = b;
    }
    float GetStart() { return m_r1; }
    float GetEnd() { return m_r2; }
    Point2D.Float GetPoint() { return m_p; }
    boolean IsFound() { return m_p != null; }
    boolean IsOnCurve() { return m_b; }
  }

  /**
   * Search the point on the curve which is the closest of the given point p.
   * Actually search only between the two given ranges r1 and r2.
   * The idea is to reduce the range until it is to the size of a pixel: either the pixel
   * corresponds to the given point, and we found that the point is on the curve, or it is
   * distant of several pixels of the point, so the point is outside.
   * We reduce the range with dichotomy: split it in two (ie. three points) and see
   * which point of the two extremities are closest of the target. The new range is the
   * middle point and the closest point.
   */
  private Closest GetClosest(float x, float y, float r1, float r2)
  {
    // Compute middle of the range
    float mr = (r1 + r2) / 2;
    Point2D.Float p, p1, mp, p2; float d1, md, d2;
    p = new Point2D.Float(x, y);
    // Compute the points at each extremity of the range and in the middle
    p1 = GetPoint(r1); mp = GetPoint(mr); p2 = GetPoint(r2);
    // Compute the distances between these points and the target point
    d1 = (float) p.distance(p1); md = (float) p.distance(mp); d2 = (float) p.distance(p2);
    // If one of these distances is below 1, these two points are in the same pixel: we found it!
    if (d1 < 1.0) return new Closest(p1, true);
    else if (md < 1.0) return new Closest(mp, true);
    else if (d2 < 1.0) return new Closest(p2, true);
    // If one point of the extremities of the range  is within the same pixel as the middle,
    // we got the smallest possible range, so we failed (point not on curve)
    if (p1.distance(mp) < 1.0 || mp.distance(p2) < 1.0)
      return new Closest(mp, false);
    // Take the biggest distance
    float mxd = max(d1, md, d2);
    // If it is the first one, we will use the second range
    if (mxd == d1) return new Closest(mr, r2);
    // If it is the second one, we will use the first range
    else if (mxd == d2) return new Closest(r1, mr);
    else
    {
      // If that's the middle point which is the farthest of the target point,
      // we take again the range whose extremity is the closest
      if (d1 > d2) return new Closest(mr, r2);
      else return new Closest(r1, mr);
    }
  }
}


void draw()
{
  background(255);

  for (int i = 0; i < CURVE_NB; i++)
  {
//    curves[i].DrawControls();

    // Show Bézier curve
    noFill();
    if (curves[i].IsPointOnCurve(mouseX, mouseY))
    {
      stroke(#FF8080);
    }
    else
    {
      color c = lerpColor(#0080FF, #FF00FF, (float) i / CURVE_NB);
      stroke(c);
    }
    strokeWeight(3);
    curves[i].Draw();
    curves[i].DrawClosestPoint();

//    curves[i].DrawDetails(10, 30);
  }
}

/*
http://www.erichaines.com/ptinpoly/
http://alienryderflex.com/polygon/
http://local.wasp.uwa.edu.au/~pbourke/geometry/lineline2d/
http://www.blackpawn.com/texts/pointinpoly/default.html


Samsung SGH-E950
http://developers.samsungmobile.com/Developer/index.jsp
http://attackgames.game-host.org/ (Wap)
http://www.dbarnes.com/midlet/
http://www.j2mepolish.org/cms/
http://code.google.com/p/j4me/
http://www.developpez.net/forums/d490372/java/general-java/java-me/tutos-programmation-cdc/
http://www.placeoweb.com/dotclear/index.php/2006/10/11/28-j2me

*/