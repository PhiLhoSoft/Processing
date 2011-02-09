// http://forum.processing.org/topic/delauney-diagram-inside-a-blob
// http://code.google.com/p/poly2tri
// http://code.google.com/p/poly2tri/source/browse/?repo=java#hg/repository/snapshots
// http://www.slf4j.org/download.html

import org.poly2tri.triangulation.point.*;
import org.poly2tri.triangulation.util.*;
import org.poly2tri.transform.coordinate.*;
import org.poly2tri.triangulation.sets.*;
import org.poly2tri.triangulation.delaunay.sweep.*;
import org.poly2tri.triangulation.delaunay.*;
import org.poly2tri.geometry.primitives.*;
import org.poly2tri.triangulation.*;
import org.poly2tri.geometry.polygon.*;
import org.poly2tri.*;

boolean bShowTriangulation;
ArrayList<PolygonPoint> points = new ArrayList<PolygonPoint>();
ArrayList<TriangulationPoint> steinerPoints = new ArrayList<TriangulationPoint>();
List<DelaunayTriangle> triangles;

final String REGULAR_POINT = "RP";
final String STEINER_POINT = "SP";
final String SEP = "\t";

void setup()
{
  size(500, 500);
  smooth();
}

void draw()
{
  background(128);

  fill(255);
  stroke(#0044FF);
  if (points.size() < 3)
  {
    for (PolygonPoint point : points)
    {
      float x = point.getXf();
      float y = point.getYf();
      ellipse(x, y, 5, 5);
    }
    return;
  }

  strokeWeight(4);
  beginShape();
  for (PolygonPoint point : points)
  {
//println("ShPt: " + point);
    float x = point.getXf();
    float y = point.getYf();
    vertex(x, y);
  }
  endShape(CLOSE);

  fill(#AAFF00);
  stroke(#888800);
  strokeWeight(1);
  if (steinerPoints.size() > 0)
  {
    for (TriangulationPoint point : steinerPoints)
    {
      float x = point.getXf();
      float y = point.getYf();
      ellipse(x, y, 7, 7);
    }
  }

  if (bShowTriangulation && triangles != null)
  {
    stroke(#FF7777);
    strokeWeight(2);
    for (DelaunayTriangle triangle : triangles)
    {
//~ println("Tr: " + triangle);
      float fx = 0, fy = 0;
      float px = 0, py = 0;
      boolean bFirst = true;
      for (TriangulationPoint point : triangle.points)
      {
//~ println("TrPt: " + point);
        float x = point.getXf();
        float y = point.getYf();
        if (bFirst)
        {
          fx = x; fy = y;
          bFirst = false;
        }
        else
        {
          line(px, py, x, y);
        }
        px = x; py = y;
      }
      line(px, py, fx, fy);
    }
  }
}

void mousePressed()
{
  PolygonPoint point = new PolygonPoint((float) mouseX, (float) mouseY);
  if (mouseButton == LEFT)
  {
    points.add(point);
  }
  else
  {
    steinerPoints.add(point);
  }
}

void keyReleased()
{
  switch (key)
  {
  case 't':
    DoTriangulation();
    break;
  case 'c':
    points.clear();
    steinerPoints.clear();
    triangles = null;
    bShowTriangulation = false;
    break;
  case 's':
    SavePoints();
    break;
  case 'l':
    LoadPoints();
    break;
  }
}

void DoTriangulation()
{
  if (points.size() < 3)
    return;

  Polygon polygon = new Polygon(points);
  if (steinerPoints.size() > 0)
  {
    polygon.addSteinerPoints(steinerPoints);
  }
  Poly2Tri.triangulate(polygon);

  triangles = polygon.getTriangles();
//~ println("DT: " + triangles);

  bShowTriangulation = true;
}

void SavePoints()
{
  String savePath = selectOutput();
  if (savePath == null)
    return;  // Cancelled

  String[] lines = new String[points.size() + steinerPoints.size()];
  int c = 0;
  for (PolygonPoint point : points)
  {
//println("ShPt: " + point);
    float x = point.getXf();
    float y = point.getYf();
    lines[c++] = REGULAR_POINT + SEP + x + SEP + y;
  }
  for (TriangulationPoint point : steinerPoints)
  {
//println("ShPt: " + point);
    float x = point.getXf();
    float y = point.getYf();
    lines[c++] = STEINER_POINT + SEP + x + SEP + y;
  }
  saveStrings(savePath, lines);
}

void LoadPoints()
{
  String loadPath = selectInput();
  if (loadPath == null)
    return;  // Cancelled

  points.clear();
  String[] lines = loadStrings(loadPath);
  for (String line : lines)
  {
    String[] values = line.split(SEP);
    float x = float(values[1]);
    float y = float(values[2]);
    PolygonPoint point = new PolygonPoint(x, y);
    if (values[0].equals(STEINER_POINT))
    {
      steinerPoints.add(point);
    }
    else
    {
      points.add(point);
    }
  }
}

