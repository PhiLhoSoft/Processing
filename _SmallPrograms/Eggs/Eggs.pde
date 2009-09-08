// Base code from http://processing.org/discourse/yabb2/YaBB.pl?num=1236849784
// thread (Why these bezierVertex don't make an egg)

Egg e1;
void setup()
{
  size(400, 600);
  smooth();
  e1 = new Egg(66, 132, 66);
}
class Egg
{
  float x, y; // X-coordinate, y-coordinate
  float scalar; // Height of the egg

  Egg(int xpos, int ypos, float s)
  {
    x = xpos;
    y = ypos;
    scalar = s / 100.0;
  }

  void display()
  {
    noStroke();
    fill(255, 150);
    translate(x, y);
    scale(scalar);

    // Make bigger so we see better
    scale(3.0);
    // And move it a bit
    translate(50, 50);
    beginShape();
    Vertex(0, -100);
    BezierVertex(25, -100, 40, -65, 40, -40);
    BezierVertex(40, -15, 25, 0, 0, 0);
    BezierVertex(-25, 0, -40, -15, -40, -40);
    BezierVertex(-40, -65, -25, -100, 0, -100);
    endShape();

    // Bad old version from OP
    fill(255, 150);
    // Move further to separate the two views
    translate(50, 120);
    beginShape();
    Vertex(0, -80);
    BezierVertex(40, 20, 40, -40, 40, 0);
    BezierVertex(20, 40, -20, 40, 0, 40);
    BezierVertex(-40, -40, -40, 20, -40, 0);
    BezierVertex(-20, -80, -20, -80, 0, -80);
    endShape();
  }
}

void draw()
{
  background(0);
  e1.display();
}
