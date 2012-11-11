// Based on the Perspective Processing example

import org.philhosoft.geom.*;

final float AXIS_LENGTH = 500;

float middleX, middleY;
PLSVector middle;

PLSVector[] axes = new PLSVector[3];
color[] axisColors = { #0000FF, #00FF00, #FFAA00 };

ArrayList<PLSVector> vectors = new ArrayList<PLSVector>();

void setup()
{
  size(800, 800, P3D);
  smooth();

  middleX = width / 2.0;
  middleY = height / 2.0;
  middle = new PLSVector(middleX, middleY);

  axes[0] = PLSVector.X_AXIS.copy().multiply(AXIS_LENGTH);
  axes[1] = PLSVector.Y_AXIS.copy().multiply(AXIS_LENGTH);
  axes[2] = PLSVector.Z_AXIS.copy().multiply(AXIS_LENGTH);

  vectors.add(PLSVector.X_AXIS.copy().rotate(PI / 4).multiply(AXIS_LENGTH * 2));
  vectors.add(PLSVector.X_AXIS.copy().rotateXZ(PI / 4).multiply(AXIS_LENGTH * 3 / 2));
  vectors.add(PLSVector.Y_AXIS.copy().rotateYZ(PI / 4).multiply(AXIS_LENGTH));
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

  strokeWeight(5);
  int cc = 0;
  for (PLSVector axis : axes)
  {
    stroke(axisColors[cc++]);
    line(0, 0, 0, axis.getX(), axis.getY(), axis.getZ());
    pushMatrix();
    translate(axis.getX(), axis.getY(), axis.getZ());
    box(7);
    popMatrix();
  }
  strokeWeight(1);
  stroke(#556677);
  for (PLSVector v : vectors)
  {
    line(0, 0, 0, v.getX(), v.getY(), v.getZ());
  }
}
