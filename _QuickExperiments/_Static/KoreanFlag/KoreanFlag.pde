// http://en.wikipedia.org/wiki/Flag_of_South_Korea
// Base length, to vary to change sketch's size
final int BASE = 240;
// Constants below come from the official flag definition
final int BAR_HEIGHT = BASE / 12;
final int LONG_BAR_WIDTH = BASE / 2;
final int SHORT_BAR_VERTICAL_INTERVAL = BASE / 24;
final int SHORT_BAR_WIDTH = (LONG_BAR_WIDTH - SHORT_BAR_VERTICAL_INTERVAL) / 2;
final int BAR_VERTICAL_INTERVAL = BASE / 24;
final int BAR_INTERVAL = BAR_HEIGHT + BAR_VERTICAL_INTERVAL;
final float DISTANCE_TRIGRAM_CENTER = BASE * (1.0 / 2 + 1.0 / 4);

// enums might be better here, but Processing doesn't seem to support them...
final int LONG_BAR = 1;
final int TWO_BARS = 2;

final int TOP_LEFT = 1;
final int TOP_RIGHT = 2;
final int BOTTOM_LEFT = 3;
final int BOTTOM_RIGHT = 4;

final float baseAngle = atan(2.0 / 3.0);

final boolean DEBUG = true;

// Draw bars with origin point at 0, 0 (top-left)
void drawLongBar(int pos)
{
  rect(0, pos *  BAR_INTERVAL, LONG_BAR_WIDTH, BAR_HEIGHT);
}
void drawTwoBars(int pos)
{
  rect(0, pos * BAR_INTERVAL, SHORT_BAR_WIDTH, BAR_HEIGHT);
  rect(SHORT_BAR_WIDTH + SHORT_BAR_VERTICAL_INTERVAL, pos * BAR_INTERVAL, SHORT_BAR_WIDTH, BAR_HEIGHT);
}
void drawTrigram(int trigramPosition, int... types)
{
  // Save transformation state
  pushMatrix();

  float angle = 0;
  int possX = 0, possY = 0;
  switch (trigramPosition)
  {
  case TOP_LEFT:
    angle = baseAngle - HALF_PI;
    break;
  case TOP_RIGHT:
    angle = HALF_PI - baseAngle;
    break;
  case BOTTOM_LEFT:
    angle = -HALF_PI - baseAngle;
    break;
  case BOTTOM_RIGHT:
    angle = HALF_PI + baseAngle;
    break;
  default:
    assert false : "Bad trigram position!";
  }
  final float posX = width  / 2 + DISTANCE_TRIGRAM_CENTER * sin(angle);
  final float posY = height / 2 - DISTANCE_TRIGRAM_CENTER * cos(angle);
  if (DEBUG)
  {
    println(degrees(angle));
    println(cos(angle) + " " + sin(angle));
    println(posX + " " + posY);
  }

  // Put in place
  translate(posX, posY);
  // Do the rotation
  rotate(angle);
  // Compensate to rotate relative to the bottom-center
  translate(-LONG_BAR_WIDTH / 2, -BASE / 3);

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
  size(3 * BASE, 2 * BASE); // Official ratio: 2 x 3
  background(255);

  noStroke();
  fill(0);
  // first
  drawTrigram(TOP_LEFT, LONG_BAR, LONG_BAR, LONG_BAR);
  // second
  drawTrigram(TOP_RIGHT, TWO_BARS, LONG_BAR, TWO_BARS);
  // third
  drawTrigram(BOTTOM_LEFT, LONG_BAR, TWO_BARS, LONG_BAR);
  // fourth
  drawTrigram(BOTTOM_RIGHT, TWO_BARS, TWO_BARS, TWO_BARS);

  // Center
  fill(#C60C30); // Official red
  ellipse(width / 2, height / 2, BASE, BASE);
  fill(#003478); // Official blue
  // Bézier curve

  if (DEBUG)
  {
    stroke(#FF8800);
    line(0, 0, width -1, height - 1);
    line(0, height - 1, width -1, 0);
  }
}

