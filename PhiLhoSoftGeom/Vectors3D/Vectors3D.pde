// Based on the Perspective Processing example

import org.philhosoft.geom.*;

final float AXIS_LENGTH = 500;

float middleX, middleY;
PLSVector middle;

DispVector[] axes = new DispVector[3];
color[] axisColors = { #0000FF, #00FF00, #FFAA00 };

ArrayList<DispVector> vectors = new ArrayList<DispVector>();

void setup()
{
  size(800, 800, P3D);
  smooth();

  middleX = width / 2.0;
  middleY = height / 2.0;
  middle = new PLSVector(middleX, middleY);

  axes[0] = new DispVector(PLSVector.X_AXIS.copy().multiply(AXIS_LENGTH), 5, #0000FF);
  axes[1] = new DispVector(PLSVector.Y_AXIS.copy().multiply(AXIS_LENGTH), 5, #00FF00);
  axes[2] = new DispVector(PLSVector.Z_AXIS.copy().multiply(AXIS_LENGTH), 5, #FF8800);

  vectors.add(new DispVector(
      PLSVector.X_AXIS.copy().rotate(PI / 4).multiply(AXIS_LENGTH * 1.5),
      1, #00FFFF));
  vectors.add(new DispVector(
      PLSVector.X_AXIS.copy().rotateXZ(PI / 4).multiply(AXIS_LENGTH * 1.5),
      1, #FF00FF));
  vectors.add(new DispVector(
      PLSVector.Y_AXIS.copy().rotateYZ(PI / 4).multiply(AXIS_LENGTH * 1.5),
      1, #FFFF00));
}

void draw()
{
  lights();
  background(255);

  float cameraY = middleY;
  // Field of view angle for the y direction
  float fov = PI * middleX / width;
  // Aspect ratio
  float aspect = float(width) / height;
  float cameraZ = cameraY / tan(fov / 2.0);

  perspective(fov, aspect, cameraZ / 10.0, cameraZ * 10.0);

  translate(middleX, middleY, -50);
  // When mouse is on the center, shows the axes in a near-canonical position
  rotateY(PI * (mouseX - middleX) / width);
  rotateX(PI * (mouseY - middleY ) / height);

  // Draw the axes
  stroke(#FF0000);
  strokeWeight(1);
  sphere(10);

  int cc = 0;
  for (DispVector axis : axes)
  {
    axis.display();
    pushMatrix();
    translate(axis.vector.getX(), axis.vector.getY(), axis.vector.getZ());
    box(7);
    popMatrix();
  }
  for (DispVector dv : vectors)
  {
    dv.display();
  }
}

class DispVector
{
  PLSVector vector;
  int weight; // stroke weight
  color sc; // Stroke color

  DispVector(PLSVector v, int w, color c)
  {
    vector = v;
    weight = w;
    sc = c;
  }

  void display()
  {
    strokeWeight(weight);
    stroke(sc);
    line(0, 0, 0, vector.getX(), vector.getY(), vector.getZ());
  }
}
