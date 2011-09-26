PShape cer;
PShape fre1;
PShape fre2;

void setup() {
  size(600, 600);
//  shapeMode(CENTER);
  smooth();
  cer = loadShape("cer.svg");
  fre1 = loadShape("f1.svg");
  fre2 = loadShape("f2.svg");
}

void draw() {
  background(255, 255, 255);
/*  
  shape(cer, 0, 0);
  drawCross(250, 201);
  shape(fre1, 0, 0);
  drawCross(193, 104);
  shape(fre2, 0, 0);
  drawCross(412, 147);
*/
  pushMatrix();
  translate(-250, -201);
  shape(cer, 300, 300);
  popMatrix();

  pushMatrix();
  translate(-193, -104);
  shape(fre1, 300, 360);
  popMatrix();
 
  pushMatrix();
  translate(-412, -147);
  rotate(radians(90));
  translate(300, 360);
  shape(fre2, 0, 0); // Better use 0, 0 when doing transforms
  popMatrix();
 
  drawCross(width / 2, height / 2);
}

void drawCross(int x, int y)
{
  stroke(#FF0000);
  line(x - 20, y, x + 20, y);
  line(x, y - 20, x, y + 20);
}

