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
int flagCenterX, flagCenterY;

final boolean DEBUG = false;

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
  final float posX = flagCenterX + DISTANCE_TRIGRAM_CENTER * sin(angle);
  final float posY = flagCenterY - DISTANCE_TRIGRAM_CENTER * cos(angle);
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

void drawTaegeuk()
{
  color red = #C60C30; // Official red
  color blue = #003478; // Official blue

  pushMatrix();

  translate(flagCenterX, flagCenterY);
  rotate(baseAngle);

  fill(blue);
  arc(0, 0, BASE, BASE, 0, PI);
  fill(red);
  arc(0, 0, BASE, BASE, -PI, 0);
  fill(blue);
  ellipse(BASE / 4, 0, BASE / 2, BASE / 2);
  fill(red);
  ellipse(-BASE / 4, 0, BASE / 2, BASE / 2);

  popMatrix();
}

void setup()
{
  size(800, 600);
  background(100);
  smooth();

  flagCenterX = width / 2;
  flagCenterY = height / 2;

  // Official ratio: 2 x 3
  int flagWidth  = 3 * BASE;
  int flagHeight = 2 * BASE;

  int posX = flagCenterX - flagWidth / 2;
  int posY = flagCenterY - flagHeight / 2;

  noStroke();
  fill(255);
  rect(posX, posY, flagWidth, flagHeight);
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
  drawTaegeuk();

  if (DEBUG)
  {
    stroke(#FF8800);
    line(posX, posY, posX + flagWidth - 1, posY + flagHeight - 1);
    line(posX,  posY + flagHeight - 1, posX + flagWidth - 1, posY);
  }
}

