PVector xAxis = new PVector(1, 0);

float ox, oy;
float px, py;

void setup()
{
  size(400, 400);
  ox = width / 2; oy = height / 2;
  PFont font = loadFont("AmericanTypewriter-24.vlw");
  textFont(font, 12);
}

void draw()
{
  background(#33AAFF);
  
  DisplayAngle();
  DrawVector();
}

void DisplayAngle()
{
  PVector v = new PVector(mouseX - ox, mouseY - oy);
  float rawAngle = PVector.angleBetween(v, xAxis);
  float angle = rawAngle;
  if (v.y < 0)
  {
     angle = TWO_PI - angle;
  }
  
  pushMatrix();
  translate(ox, oy);
  rotate(angle);

  stroke(#000055);
  strokeWeight(5);
  line(0, 0, 170, 0);
  fill(#000099);
  ellipse(170, 0, 7, 7);
  popMatrix();

  text("Angle C: " + f(rawAngle) + " " + f(rawAngle / PI) + 
      " -> " + f(angle) + " " + f(angle / PI), 0, 380);
}

void DrawVector()
{
  if (pmouseX != mouseX) px = pmouseX;
  if (pmouseY != mouseY) py = pmouseY;
  float dx = mouseX - px;
  float dy = mouseY - py;
  PVector v = new PVector(dx, dy);
  float rawAngle = PVector.angleBetween(v, xAxis);
  float angle = rawAngle;
  if (v.y < 0)
  {
     angle = TWO_PI - angle;
  }
  pushMatrix();
  translate(mouseX, mouseY);
  rotate(angle);

  stroke(#000066);
  strokeWeight(3);
  line(0, 0, 100, 0);
  fill(#00FF00);
  ellipse(0, 0, 7, 7);
  fill(#008800);
  ellipse(100, 0, 5, 5);
  popMatrix();

  text("Angle V: " + f(rawAngle) + " " + f(rawAngle / PI) + 
      " -> " + f(angle) + " " + f(angle / PI), 0, 330);
  text("d: " + f(dx) + " " + f(dy), 0, 350);
}

String f(float f)
{
  return String.format("%3.2f", f);
}



