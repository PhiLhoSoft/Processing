import quickhull3d.QuickHull3D;

class QH3DWrapper
{
  double[] m_points;
  QuickHull3D m_hull;
  boolean m_bAlt;

  QH3DWrapper(ArrayList meshPoints)
  {
    m_points = new double[meshPoints.size() * 3];
    println(meshPoints.size() + " mesh points");
    for (int ptIdx = 0, i = 0; ptIdx < meshPoints.size(); ptIdx++)
    {
      MeshPoint mp = (MeshPoint) meshPoints.get(ptIdx);
      m_points[i++] = mp.GetX();
      m_points[i++] = mp.GetY();
      // QuickHull3D throws IllegalArgumentException if all points are at same z (co-planar)
      m_points[i++] = i / 10.0 + random(0.0, i / 5.0);
    }
    m_hull = new QuickHull3D();
    try
    {
      m_hull.build(m_points);
    }
    catch (IllegalArgumentException iae)
    {
      println("Set of points is incorrect or cannot be used.");
    }
//    m_hull.triangulate();
  }

  QH3DWrapper(ArrayList meshPoints, boolean bAlt)
  {
    m_points = new double[meshPoints.size() * 3 + 9];
    println(meshPoints.size() + " mesh points");
    int i = 0;
    for (int ptIdx = 0; ptIdx < meshPoints.size(); ptIdx++)
    {
      MeshPoint mp = (MeshPoint) meshPoints.get(ptIdx);
      m_points[i++] = mp.GetX();
      m_points[i++] = mp.GetY();
      m_points[i++] = 0.0;
    }
    m_bAlt = true;
    // QuickHull3D throws IllegalArgumentException if all points are at same z (co-planar)
    // So makes a tripod to "support" the planar face
    m_points[i++] = -20000;
    m_points[i++] = -20000;
    m_points[i++] = -666000000;
    m_points[i++] =  50000;
    m_points[i++] =  0;
    m_points[i++] = -666000000;
    m_points[i++] = -30000;
    m_points[i++] =  20000;
    m_points[i++] = -666000000;
    m_hull = new QuickHull3D();
    try
    {
      m_hull.build(m_points);
    }
    catch (IllegalArgumentException iae)
    {
      println("Set of points is incorrect or cannot be used.");
    }
//    m_hull.triangulate();
  }

  float[][] GetVertices()
  {
    int numVertices = m_hull.getNumVertices();
    println("Got " + numVertices + " vertices");
    double[] dv = new double[numVertices * 3];
    m_hull.getVertices(dv);
    float[][] fv = new float[numVertices][2];
    for (int fi = 0, di = 0; di < dv.length; fi++)
    {
      if (dv[di + 2] < 0)
      {
        di += 3;  // Skip "tripod" vertex
        continue;
      }
      fv[fi][0] = (float) dv[di++];
      fv[fi][1] = (float) dv[di++];
//      println(fv[fi][0] + " " + fv[fi][1]);
      di++;  // Skip z
    }
    return fv;
  }

  int[][] GetFaces()
  {
    int[][] faces = m_hull.getFaces(QuickHull3D.POINT_RELATIVE + QuickHull3D.CLOCKWISE);
    println("Got " + faces.length + " faces");
    return faces;
  }
}

