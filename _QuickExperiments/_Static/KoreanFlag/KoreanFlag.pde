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
void drawYiKing(int posX, int posY, int[] types)
{
  pushMatrix();
  translate(posX, posY);
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
  popMatrix();
}

void setup()
{
  size(600, 400);
  fill(0);
  // first
  drawYiKing(40, 40, new int[] { LONG_BAR, LONG_BAR, LONG_BAR });
  // second
  drawYiKing(400, 40, new int[] { TWO_BARS, LONG_BAR, TWO_BARS });
  // third
  drawYiKing(40, 300, new int[] { LONG_BAR, TWO_BARS, LONG_BAR });
  // fourth
  drawYiKing(400, 300, new int[] { TWO_BARS, TWO_BARS, TWO_BARS });
}

