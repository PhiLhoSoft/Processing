import org.philhosoft.geom.*;

float middleX, middleY;
PLSVector middle;
Line line1;
Line line2;
Rectangle rect1;
Rectangle rect2;
Circle circle1;
Circle circle2;

void setup()
{
  size(800, 800);
  smooth();

  middleX = width / 2.0;
  middleY = height / 2.0;
  middle = new PLSVector(middleX, middleY);

  line1 = new Line(
      PLSVector.createRandomPoint(width, height),
      PLSVector.createRandomPoint(width, height));
  line2 = new Line(
      PLSVector.createRandomPoint(width, height), 
      PLSVector.createRandomPoint(width, height));
  rect1 = new Rectangle(
      PLSVector.createRandomPoint(0, middleX, 0, middleY), 
      PLSVector.createRandomPoint(middleX, width, middleY, height));
  rect2 = new Rectangle(
      PLSVector.createRandomPoint(0, middleX, 0, middleY),
      PLSVector.getRandom(50, width / 2), PLSVector.getRandom(20, height / 2));
  circle1 = new Circle(middle.copy(), PLSVector.getRandom(150, height / 4));
  circle2 = new Circle(
      PLSVector.createRandomPoint(middleX / 2, middleX, middleY / 2, middleY), 
      PLSVector.getRandom(height / 17, height / 7));
}

void draw()
{
  background(255);

  // TODO: add handles
  stroke(#CCCCCC);
  fill(#00AAFF);
  rect(rect1.getLeft(), rect1.getTop(), rect1.getWidth(), rect1.getHeight());
  fill(#00FFAA);
  rect(rect2.getLeft(), rect2.getTop(), rect2.getWidth(), rect2.getHeight());

  fill(#77AAFF);
  ellipse(circle1.getCenter().getX(), circle1.getCenter().getY(), circle1.getRadius(), circle1.getRadius());
  fill(#77FFAA);
  ellipse(circle2.getCenter().getX(), circle2.getCenter().getY(), circle2.getRadius(), circle2.getRadius());

  stroke(#FFAA00);
  line(line1.getPoint1().getX(), line1.getPoint1().getY(), line1.getPoint2().getX(), line1.getPoint2().getY());
  stroke(#AAFF00);
  line(line2.getPoint1().getX(), line2.getPoint1().getY(), line2.getPoint2().getX(), line2.getPoint2().getY());

  fill(#0022AA);
  text("Intersections", 10, 30);
}


