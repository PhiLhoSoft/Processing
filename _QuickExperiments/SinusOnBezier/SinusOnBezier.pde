float level = 0.1;

void setup()
{
  size(500, 500);
  smooth();
  frameRate(10);
}

void draw()
{
  background(255);

  noFill();
  stroke(0);
  int curveLength = 400;
  int curveHeight = 200;
  bezier(15, 120, 210, 90, 290, 420, 415, 380);

  stroke(#FF0000);
  int steps = 50;
  for (int i = 0; i < steps; i++)
  {
    float t = i / float(steps);
    float x = bezierPoint(15, 210, 290, 415, t);
    float y = bezierPoint(120, 90, 420, 380, t);
    
    float v = curveHeight * sin(t * TWO_PI * level);
    line(x, y, x, y + v);
  }
  level += 0.1;
}

