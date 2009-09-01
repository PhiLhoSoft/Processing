Egg e1;
void setup()  
{
  size(400, 600);
  smooth();
  e1 = new Egg(66, 132, 66);
}
class Egg {
  float x, y; // X-coordinate, y-coordinate
  float angle; // Used to define the tilt
  float scalar; // Height of the egg
  // Constructor
  Egg(int xpos, int ypos, float s) {
    x = xpos;
    y = ypos;
    scalar = s / 100.0;
  }
  void display() {
    noStroke();
    fill(255, 150);
    translate(x, y);
    scale(scalar);
    scale(3.0); translate(50, 50);
    beginShape();
    Vertex(0, -100);
    BezierVertex(25, -100, 40, -65, 40, -40);
    BezierVertex(40, -15, 25, 0, 0, 0);
    BezierVertex(-25, 0, -40, -15, -40, -40);
    BezierVertex(-40, -65, -25, -100, 0, -100);
    endShape();

    fill(255, 150);
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

