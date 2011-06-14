void setup()
{
  size(500, 500);
  smooth();
  background(255);
  
  float cx = width / 2;
  float cy = height / 2;
  float radius = 0.75 * width / 2;
  float amplitude = radius / 10;
  float px1 = 0, py1 = 0;
  float px2 = 0, py2 = 0;
  for (int angle = -1; angle <= 360; angle++)
  {
    float a = radians(angle);
    float disturb1 = amplitude * sin(a * 7);
    float disturb2 = amplitude * cos(a * 11);
    float x1 = cx + (radius + disturb1) * cos(a);
    float y1 = cy + (radius + disturb1) * sin(a);
    float x2 = cx + (radius + disturb2) * cos(a);
    float y2 = cy + (radius + disturb2) * sin(a);
    if (angle >= 0)
    {
      line(px1, py1, x1, y1);
      line(px2, py2, x2, y2);
    }
    px1 = x1;
    py1 = y1;
    px2 = x2;
    py2 = y2;
  } 
}

