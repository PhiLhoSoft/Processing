int lineNb = 50;
int lengthIncrement = 7;

void setup()
{
  size(500, 500);
  background(#99BBFF);
  
  strokeWeight(2);
  int lineLength = 5;
  int x, y;
  int px, py;
  px = x = width / 2;
  py = y = height / 2;
  
  for (int i = 0; i < lineNb; i++)
  {
    switch (i % 4)
    {
    case 0:
      x -= lineLength;
      break;
    case 1:
      y -= lineLength;
      break;
    case 2:
      x += lineLength;
      break;
    case 3:
      y += lineLength;
      break;
    }
    line(px, py, x, y);
    px = x; py = y;
    lineLength += lengthIncrement;
  }
}


