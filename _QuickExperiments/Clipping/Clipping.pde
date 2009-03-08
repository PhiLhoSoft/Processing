PGraphics drawingArea;
PGraphics applet;
int DA_X = 50, DA_Y = 10;
int DA_WIDTH = 200, DA_HEIGHT = 200;

void setup()
{
  size(300, 300);
  smooth();
  background(#FF0000);
  // Keep graphical context of current applet/display
  applet = g;
  // Create a new graphical context
  drawingArea = createGraphics(DA_WIDTH, DA_HEIGHT, JAVA2D);
  // And use it to replace the applet's one so all graphic orders will go there
  g = drawingArea;
  background(#00FF00);
}

void draw()
{
  for (int i = 0; i < 10; i++)
  {
    ellipse(random(DA_WIDTH), random(DA_HEIGHT), 5 + random(20), 5 + random(20));
  }
  
  // Update display
//  applet.beginDraw();
//  applet.image(drawingArea, DA_X, DA_Y);
//  applet.endDraw();
}
