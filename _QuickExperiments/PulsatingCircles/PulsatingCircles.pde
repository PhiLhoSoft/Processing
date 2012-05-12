import processing.opengl.*;

int radius1 = 5;
int rMove1 = +1;
int minRadius1 = 5, maxRadius1 = 100;
int xPos1 = 100;
int yPos1 = 200;

int radius2 = 5;
float rMove2 = 0;
int minRadius2 = 20, maxRadius2 = 140;
int xPos2 = 300;
int yPos2 = 200;

void setup()
{
  size(400, 400, OPENGL);
//  frameRate(10);
}

void draw()
{
  background(240);
  noFill();
  
  // Linear
  ellipse(xPos1, yPos1, radius1, radius1);
  radius1 += rMove1;
  if (radius1 > maxRadius1)
    rMove1 = -1;
  else if (radius1 < minRadius1)
    rMove1 = +1;

  // Sine
  ellipse(xPos2, yPos2, radius2, radius2);
  rMove2 += 0.02;
  radius2 = (int) ((maxRadius2 - minRadius2) * sin(rMove2) + minRadius2);
}
