PGraphics drawingArea;
int DA_X = 50, DA_Y = 10;
int DA_WIDTH = 200, DA_HEIGHT = 200;

void setup()
{
  size(300, 300);
  smooth();
  background(0);
  // Create a new graphical context
  drawingArea = createGraphics(DA_WIDTH, DA_HEIGHT, JAVA2D);
  drawingArea.beginDraw();
  drawingArea.background(#00FF00);
  drawingArea.endDraw();
}

void draw()
{
  // Update display: copy drawing area to screen
  image(drawingArea, DA_X, DA_Y);
}

void mousePressed()
{
  if (mouseX < DA_X || mouseX >= DA_X + DA_WIDTH || mouseY < DA_Y || mouseY >= DA_Y + DA_HEIGHT)
    return;
  drawingArea.beginDraw();
  for (int i = 0; i < 10; i++)
  {
    drawingArea.ellipse(random(DA_WIDTH), random(DA_HEIGHT), 5 + random(20), 5 + random(20));
  }
  drawingArea.endDraw();
}
