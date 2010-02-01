int MIN_RAD = 10;
int MAX_RAD = 100;
int MAIN_RAD = 250;
int CIRCLE_NB = 222;

void setup()
{
  size(500, 500);
  background(255);
  noStroke();
  
  int centerX = width / 2;
  int centerY = height / 2;
  
  for (int i = 0; i < CIRCLE_NB; i++)
  {
    float d = random(0, MAIN_RAD - MIN_RAD);
    float a = random(0, TWO_PI);
    float x = centerX + d * cos(a);
    float y = centerY + d * sin(a);
    float r = random(MIN_RAD, min(MAX_RAD, MAIN_RAD - d));
    color c = lerpColor(#00FF00, #0000FF, (1 + cos(a))/2);
    
    fill(c);
    ellipse(x, y, r * 2, r * 2);
  }
}


