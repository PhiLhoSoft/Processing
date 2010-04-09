import processing.pdf.*;

PFont fontR;
PFont fontB;

void setup()
{
  size(512, 512, PDF, "test.pdf");
  textMode(SHAPE);
  g.textMode = SHAPE;  // Should be done by textMode() call
  background(255);
  fontR = createFont("Vera.ttf", 48);
  fontB = createFont("VeraBd.ttf", 48);
  fill(0);
}

void draw()
{
  textFont(fontR);
  text("This is a regular font", 20, 100);
  textFont(fontB);
  text("This is a bold font", 20, 200);
  exit();
}

