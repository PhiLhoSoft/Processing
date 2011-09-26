void setup()
{
  size(200, 200, P3D);
  noStroke();
  lights();
  translate(58, 48, 0);
  sphere(28);
  translate(70, 70, 0);
  halfSphere(50);
}


public void halfSphere(float r) {
  float sphereX[] = null, sphereY[] = null, sphereZ[] = null;
  int sphereDetailU = g.sphereDetailU;
  int sphereDetailV = g.sphereDetailV;

    if ((sphereDetailU < 3) || (sphereDetailV < 2)) {
      sphereDetail(30);
    }
    

    pushMatrix();
    scale(r);
    edge(false);

    // 1st ring from south pole
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sphereDetailU; i++) {
      normal(0, -1, 0);
      vertex(0, -1, 0);
      normal(sphereX[i], sphereY[i], sphereZ[i]);
      vertex(sphereX[i], sphereY[i], sphereZ[i]);
    }
    //normal(0, -1, 0);
    vertex(0, -1, 0);
    normal(sphereX[0], sphereY[0], sphereZ[0]);
    vertex(sphereX[0], sphereY[0], sphereZ[0]);
    endShape();

    int v1,v11,v2;

    // middle rings
    int voff = 0;
    for (int i = 2; i < sphereDetailV; i++) {
      v1 = v11 = voff;
      voff += sphereDetailU;
      v2 = voff;
      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < sphereDetailU; j++) {
        normal(sphereX[v1], sphereY[v1], sphereZ[v1]);
        vertex(sphereX[v1], sphereY[v1], sphereZ[v1++]);
        normal(sphereX[v2], sphereY[v2], sphereZ[v2]);
        vertex(sphereX[v2], sphereY[v2], sphereZ[v2++]);
      }
      // close each ring
      v1 = v11;
      v2 = voff;
      normal(sphereX[v1], sphereY[v1], sphereZ[v1]);
      vertex(sphereX[v1], sphereY[v1], sphereZ[v1]);
      normal(sphereX[v2], sphereY[v2], sphereZ[v2]);
      vertex(sphereX[v2], sphereY[v2], sphereZ[v2]);
      endShape();
    }

    // add the northern cap
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sphereDetailU; i++) {
      v2 = voff + i;
      normal(sphereX[v2], sphereY[v2], sphereZ[v2]);
      vertex(sphereX[v2], sphereY[v2], sphereZ[v2]);
      normal(0, 1, 0);
      vertex(0, 1, 0);
    }
    normal(sphereX[voff], sphereY[voff], sphereZ[voff]);
    vertex(sphereX[voff], sphereY[voff], sphereZ[voff]);
    normal(0, 1, 0);
    vertex(0, 1, 0);
    endShape();

    edge(true);
    popMatrix();
  }

