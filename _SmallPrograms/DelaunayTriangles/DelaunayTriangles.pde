import megamu.mesh.Delaunay;

ArrayList meshPoints;
Delaunay delaunay;
Triangle[] triangles;

float[][] vertices;
int[][] faces;

int highlighted = 0;
color highlightColor = color(255, 128, 64, 20);

void setup()
{
  size(800, 500);
  PFont font= loadFont("AmericanTypewriter-24.vlw");
  textFont(font, 12);

  meshPoints = new ArrayList();
}

void draw()
{
  background(255);

  if (triangles != null)
  {
    if (frameCount % 24 == 0)
    {
      highlighted = ++highlighted % triangles.length;
    }
    for (int i = 0; i < triangles.length; i++)
    {
      if (i == highlighted)
      {
        triangles[i].Display(highlightColor);
      }
      else
      {
        triangles[i].Display();
      }
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
  if (vertices != null)
  {
    noStroke();
    for (int i = 0; i < vertices.length; i++)
    {
      fill(#00FF00);
      ellipse(vertices[i][0], vertices[i][1], 5, 5);
      fill(200);
      text("" + i, vertices[i][0] + 5, vertices[i][1]);
    }
  }
}

void mousePressed()
{
  MeshPoint pt = new MeshPoint(mouseX, mouseY);
  meshPoints.add(pt);
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
    FindFaces();
    ComputeDelaunay();
  }
  /*
  else if (key == 't')
  {
    FindDelaunayTriangles();
  }
  */
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

void FindFaces()
{
  QH3DWrapper hull = new QH3DWrapper(meshPoints);
  // Get that for experimentation, but doesn't use it actually:
  // we have sometime less vertices than mesh points!
  vertices = hull.GetVertices();

  faces = hull.GetFaces();
  triangles = new Triangle[vertices.length];
  for (int vi = 0; vi < vertices.length; vi++)
  {
    Triangle t = new Triangle();
    for (int fi = 0; fi < faces[vi].length; fi++)
    {
      int idx = faces[vi][fi];
      if (idx >= vertices.length)
      {
        print("!" + idx + "! ");
      }
      else
      {
        print(idx + " ");
        t.SetPoint(fi, vertices[idx][0], vertices[idx][1]);
      }
    }
    t.SetColor(color(0, 255, 255, 10));
    println("=> " + vi);
    triangles[vi] = t;
  }
}

void DisplayVertices()
{
  for (int i = 0; i < vertices.length; i++)
  {
    float x = vertices[i][0];
    float y = vertices[i][1];
    fill(#000088);
    noStroke();
    ellipse(x, y, 2, 2);
  }
}

