void setup()
{
  size(500, 500);
  smooth();
  background(255);
  
  float cx = width / 2;
  float cy = height / 2;
  float radius = 0.75 * width / 2;
  float px = 0, py = 0;
  for (int angle = -1; angle <= 360; angle++)
  {
    float a = radians(angle);
    float x = cx + radius * cos(a);
    float y = cy + radius * sin(a);
    if (angle >= 0)
    {
      line(px, py, x, y);
    }
    px = x;
    py = y;
  } 
}

