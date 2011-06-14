final int BAR_HEIGHT = 20;
final int LONG_BAR_WIDTH = 100;
final int SHORT_BAR_WIDTH = 45;
final int SHORT_BAR_INTERVAL = 10;
final int BAR_INTERVAL = 30;

final int LONG_BAR = 1;
final int TWO_BARS = 2;

void drawLongBar(int pos)
{
  rect(0, pos * BAR_INTERVAL, LONG_BAR_WIDTH, BAR_HEIGHT);
}
void drawTwoBars(int pos)
{
  rect(0, pos * BAR_INTERVAL, SHORT_BAR_WIDTH, BAR_HEIGHT);
  rect(SHORT_BAR_WIDTH + SHORT_BAR_INTERVAL, pos * BAR_INTERVAL, SHORT_BAR_WIDTH, BAR_HEIGHT);
}
void drawYiKing(int posX, int posY, int angle, int... types)
{
  // Save transformation state
  pushMatrix();
  // Put in place
  translate(posX, posY);
  // Do the rotation
  rotate(radians(angle));
  // Compensate to rotate relative to the center
  translate(-LONG_BAR_WIDTH / 2, -(BAR_HEIGHT * 3 + BAR_INTERVAL * 2));

  // Draw the figure
  for (int i = 0; i < types.length; i++)
  {
    if (types[i] == LONG_BAR)
    {
      drawLongBar(i);
    }
    else
    {
      drawTwoBars(i);
    }
  }

  // Restore transformation state
  popMatrix();
}

void setup()
{
  size(600, 400);
  background(255);
  fill(0);
  // first
  drawYiKing(170, 120, -60, LONG_BAR, LONG_BAR, LONG_BAR);
  // second
  drawYiKing(420, 120, 60, TWO_BARS, LONG_BAR, TWO_BARS);
  // third
  drawYiKing(170, 280, -120, LONG_BAR, TWO_BARS, LONG_BAR);
  // fourth
  drawYiKing(420, 280, 120, TWO_BARS, TWO_BARS, TWO_BARS);
}

