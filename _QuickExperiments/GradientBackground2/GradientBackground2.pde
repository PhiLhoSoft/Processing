final color START_COLOR_TOP    = #335533;
final color START_COLOR_BOTTOM = #55AA55;
final color END_COLOR_TOP      = #333355;
final color END_COLOR_BOTTOM   = #5555AA;

final int MAX_FRAME_NB = 200;

color InterpolateColor(color startC, color endC)
{
  return lerpColor(startC, endC, (float) (frameCount % MAX_FRAME_NB) / (float) MAX_FRAME_NB);
}

void DrawBackground()
{
  color topColor = InterpolateColor(START_COLOR_TOP, END_COLOR_TOP);
  color bottomColor = InterpolateColor(START_COLOR_BOTTOM, END_COLOR_BOTTOM);
  for (int l = 0; l < height; l++)
  {
    color sc = lerpColor(topColor, bottomColor, (float) l / (float) height);
    stroke(sc);
    line(0, l, width - 1, l);
  }
}

void setup()
{
  size(500, 300);
}

void draw()
{
  DrawBackground();
}



