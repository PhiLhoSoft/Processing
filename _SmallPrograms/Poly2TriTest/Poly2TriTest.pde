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
List<DelaunayTriangle> triangles;

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
  strokeWeight(4);
  if (points.size() < 3)
  {
    for (TriangulationPoint point : points)
    {
      float x = point.getXf();
      float y = point.getYf();
      ellipse(x, y, 3, 3);
    }
    return;
  }
  beginShape();
  for (PolygonPoint point : points)
  {
//println("ShPt: " + point);
    float x = point.getXf();
    float y = point.getYf();
    vertex(x, y);
  }
  endShape(CLOSE);

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
  points.add(point);
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
    
  String[] lines = new String[points.size()];
  int c = 0;
  for (PolygonPoint point : points)
  {
//println("ShPt: " + point);
    float x = point.getXf();
    float y = point.getYf();
    lines[c++] = x + "\t" + y;
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
    String[] values = line.split("\t");
    float x = float(values[0]);
    float y = float(values[1]);
    points.add(new PolygonPoint(x, y));
  }
}

