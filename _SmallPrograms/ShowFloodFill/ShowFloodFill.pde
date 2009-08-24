boolean bWithBorder;

void setup()
{
  size(800,800);
  image(loadImage("FloodFillTest.png"), 0, 0);
  loadPixels();
}

void draw()
{
}

void mouseReleased()
{
  if (bWithBorder)
  {
    FloodFillWithBorder ff = new FloodFillWithBorder();
    ff.DoFill(
        mouseX, mouseY, // current mouse pos as point object
        GetRandomColor(),
        GetRandomColor()
    );
  }
  else
  {
    FloodFill ff = new FloodFill();
    ff.DoFill(
        mouseX, mouseY, // current mouse pos as point object
        GetRandomColor()
    );
  }
  updatePixels();
}

void keyPressed()
{
  if (key == 'b')
  {
    bWithBorder = true;
    println("With border");
  }
  else if (key == 'n')
  {
    bWithBorder = false;
    println("Plain");
  }
}

color GetRandomColor()
{
  return 0xFF000000 | (int) random(0x1000000); // random color (need to set alpha too)
}
