import org.philhosoft.geom.*;

float middleX, middleY;
PLSVector middle;
Line line;
Rectangle rect;
Circle circle;

void setup()
{
  size(800, 800);
  smooth();

  middleX = width / 2.0;
  middleY = height / 2.0;
  middle = new PLSVector(middleX, middleY);

  line = new Line(10, 20, 400, 50);
  rect = new Rectangle(middle.copy(), middle.copy().add(50, 60));
  circle = new Circle(middle.copy().add(-150, -260), 50);
}

void draw()
{
  background(255);

  // TODO: add handles
  line(line.getPoint1().getX(), line.getPoint1().getY(), line.getPoint2().getX(), line.getPoint2().getY());
  rect();
  ellipse(circle.getCenter().getX(), circle.getCenter.getY(), circle.getRadius(), circle.getRadius());

  fill(#0022AA);
  text("Intersections", 10, 30);

}


