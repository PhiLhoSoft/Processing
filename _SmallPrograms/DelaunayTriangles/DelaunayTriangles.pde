import megamu.mesh.Voronoi;
import megamu.mesh.Delaunay;
import megamu.mesh.Hull;

ArrayList meshPoints;
Delaunay delaunay;
Triangle[] triangles;

void setup()
{
  size(800, 500);

  meshPoints = new ArrayList();
}

void draw()
{
  background(#CCFFEE);

  if (triangles != null)
  {
    for (int i = 0; i < triangles.length; i++)
    {
      triangles[i].Display();
    }
  }
  if (delaunay != null)
  {
    DisplayDelaunay();
  }
  for (int i = 0; i < meshPoints.size(); i++)
  {
    ((MeshPoint) meshPoints.get(i)).Display();
  }
}

void mousePressed()
{
  MeshPoint pt = new MeshPoint(mouseX, mouseY);
  meshPoints.add(pt);
}

class MeshPoint
{
  float x, y;
  float linkCount;

  // Radius
  int r = 5;
  // Point color
  color c = #FF0000;

  MeshPoint(float px, float py)
  {
    x = px;
    y = py;
  }

  float GetX() { return x; }
  float GetY() { return y; }

  void Display()
  {
    fill(c);
    noStroke();
    ellipse(x, y, r, r);
  }
}

class Triangle
{
  float x1, y1;
  float x2, y2;
  float x3, y3;

  void Display()
  {
    fill(c);
    noStroke();
    ellipse(x, y, r, r);
  }
}

void keyPressed()
{
  // Undo
  if (key == 'u')
  {
    meshPoints.remove(meshPoints.size() - 1);
  }
  else if (key == 'd')
  {
    ComputeDelaunay();
  }
  else if (key == 't')
  {
    FindDelaunayTriangles();
  }
}

void ComputeDelaunay()
{
  float[][] points = new float[meshPoints.size()][2];
  println("Computing Delaunay for " + meshPoints.size() + " points");
  for (int i = 0; i < meshPoints.size(); i++)
  {
    MeshPoint mp = (MeshPoint) meshPoints.get(i);
    points[i][0] = mp.GetX();
    points[i][1] = mp.GetY();
  }
  delaunay = new Delaunay(points);
}

void DisplayDelaunay()
{
  float[][] edges = delaunay.getEdges();
//  println("Displaying Delaunay for " + edges.length + " edges");
  stroke(#000088);
  for (int i = 0; i < edges.length; i++)
  {
    float startX = edges[i][0];
    float startY = edges[i][1];
    float endX   = edges[i][2];
    float endY   = edges[i][3];
//    println(startX + " " + startY + " " + endX + " " + endY);
    line(startX, startY, endX, endY);
  }
}

void FindDelaunayTriangles()
{

}

