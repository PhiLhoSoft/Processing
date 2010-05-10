//import processing.pdf.*;
String rawSize;
String setupSize;

PFont fontR;
PFont fontB;

void init()
{
  Dimension size = getSize();
  rawSize = "Raw size: " + size.width + "x" + size.height;
  super.init();
}

void setup()
{
//  size(512, 512, PDF, "test.pdf");
  size(512, 512);
  Dimension size = getSize();
  setupSize = "Size after setup: " + size.width + "x" + size.height;
//  textMode(SHAPE);
//  g.textMode = SHAPE;  // Should be done by textMode() call
  background(255);
  fontR = createFont("Arial", 48);
  fontB = createFont("Arial Bold", 48);
  fill(0);
  TestClass testClass = new TestClass();
  testClass.TestFun();
  noLoop();
}

void draw()
{
  fill(#22AA55);
  noStroke();
  int hg = width / 6;
  int vg = height / 6;
  triangle(
    4 * hg, 2 * vg,
    4 * hg, 4 * vg,
    width, 3 * vg 
  );
  triangle(
    2 * hg, 4 * vg,
    4 * hg, 4 * vg,
    3 * hg, height
  );

  fill(0); stroke(#0000FF);
  textFont(fontR, 12);
  text(rawSize, 20, 20);
  text(setupSize, 20, 40);
  text("Applet size: " + width + "x" + height, 20, 60);
  textFont(fontR);
  text("This is a regular font", 20, 100);
  textFont(fontB);
  text("This is a bold font", 20, 200);
  println("Done");
//  exit();
}

