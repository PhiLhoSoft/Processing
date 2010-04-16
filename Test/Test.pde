//import processing.pdf.*;

PFont fontR;
PFont fontB;

void setup()
{
//  size(512, 512, PDF, "test.pdf");
  size(512, 512);
//  textMode(SHAPE);
//  g.textMode = SHAPE;  // Should be done by textMode() call
  background(255);
  fontR = createFont("Arial", 48);
  fontB = createFont("Arial Bold", 48);
  fill(0);
  TestClass testClass = new TestClass();
  testClass.TestFun();
}

void draw()
{
  textFont(fontR);
  text("This is a regular font", 20, 100);
  textFont(fontB);
  text("This is a bold font", 20, 200);
  println("Done");
  exit();
}

