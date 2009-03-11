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
    fill(255);
    translate(x, y);
    scale(scalar);
scale(3.0); translate(50, 50);
    beginShape();
    vertex(0, -100);
    bezierVertex(25, -100, 40, -65, 40, -40);
    bezierVertex(40, -15, 25, 0, 0, 0);
    bezierVertex(-25, 0, -40, -15, -40, -40);
    bezierVertex(-40, -65, -25, -100, 0, -100);
    endShape();
fill(#FF00FF);
ellipse(0, 0, 9, 9);
fill(#FFFF00);
ellipse(0, -100, 9, 9);
fill(#0000FF);
ellipse(25, -100, 3, 3);
ellipse(40, -15, 3, 3);
ellipse(-25, 0, 3, 3);
ellipse(-40, -65, 3, 3);
fill(#00FF00);
ellipse(40, -65, 3, 3);
ellipse(25, 0, 3, 3);
ellipse(-40, -15, 3, 3);
ellipse(-25, -100, 3, 3);
fill(#FF0000);
ellipse(40, -40, 3, 3);
ellipse(0, 0, 3, 3);
ellipse(-40, -40, 3, 3);
ellipse(0, -100, 3, 3);

    fill(255);
translate(50, 120);
    beginShape();
vertex(0, -80);
bezierVertex(40, 20, 40, -40, 40, 0);
bezierVertex(-20, 40, 20, 40, 0, 40);
bezierVertex(-40, -40, -40, 20, -40, 0);
bezierVertex(-20, -40, -20, -80, 0, -80); 
endShape();

fill(#FF00FF);
ellipse(0, 0, 9, 9);
fill(#FFFF00);
ellipse(0, -80, 9, 9);
fill(#0000FF);
ellipse(40, 20, 3, 3);
ellipse(-20, 40, 3, 3);
ellipse(-40, -20, 3, 3);
ellipse(-20, -40, 3, 3);
fill(#00FF00);
ellipse(40, -40, 3, 3);
ellipse(20, 40, 3, 3);
ellipse(-40, 40, 3, 3);
ellipse(-20, -80, 3, 3);
fill(#FF0000);
ellipse(40, 0, 3, 3);
ellipse(0, 40, 3, 3);
ellipse(-40, 0, 3, 3);
ellipse(0, -80, 3, 3);
  }
}
void draw()  
{
  background(0);
  e1.display();
} 

