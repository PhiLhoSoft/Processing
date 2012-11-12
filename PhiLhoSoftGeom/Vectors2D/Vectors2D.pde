import org.philhosoft.geom.*;

float middleX, middleY;
PLSVector middle;

ArrayList<PLSVector> vectors = new ArrayList<PLSVector>();

void setup()
{
  size(800, 800);
  smooth();
  
  middleX = width / 2.0;
  middleY = height / 2.0;
  middle = new PLSVector(middleX, middleY);
  
  vectors.add(new PLSVector());
  vectors.add(PLSVector.create().multiply(150));
  vectors.add(PLSVector.create(PI / 4).multiply(100));
  vectors.add(PLSVector.createRandom().multiply(50));
  
  for (PLSVector v : vectors)
  {
    v.add(middle);
  }
}

void draw()
{
  background(255);
  
  for (PLSVector v : vectors)
  {
    line(middleX, middleY, v.getX(), v.getY());
  }
  
  PLSVector mouseDir = new PLSVector(mouseX, mouseY).subtract(middle);
  stroke(#0055EE);
  line(middleX, middleY, mouseX, mouseY);
  fill(#0022AA);
  text("Angle: " + nf(degrees(PLSVector.X_AXIS.angleWith(mouseDir)), 1, 2) +
      ", Heading: " + nf(degrees(mouseDir.heading()), 1, 2), 10, 30);
}


