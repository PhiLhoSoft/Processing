import java.awt.event.KeyEvent;

void setup()
{
  size(500, 200);
  smooth();
  noStroke();
  PFont font = createFont("Arial", 24);
  textFont(font);
}

void draw()
{
}

void keyPressed()
{
  background(255);
  fill(0);
  int location = keyEvent.getKeyLocation();
  if (key == CODED && keyCode == SHIFT)
  {
    switch (location)
    {
    case KeyEvent.KEY_LOCATION_LEFT:
      text("Left", 10, 100);
      break;
    case KeyEvent.KEY_LOCATION_RIGHT:
      text("Right", 400, 100);
      break;
    default:
      text("Uh?", 200, 100);
      break;
    }
  }
}

