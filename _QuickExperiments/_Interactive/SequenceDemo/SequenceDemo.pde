int startTime;
int step;
int firstStepTime = 2000;
int secondStepTime = 3000;

float cx, cy;
float count;
color initialColor = #BBCC00; 
color circleColor = initialColor;
int circleSize = 100;
float circleStep = PI / 150;

void setup()
{
  size(512, 512);
}

void draw()
{
  background(255);
  if (step == 0)
  {
    if (millis() - startTime >= firstStepTime)
    {
      // Change color every 2 seconds
      circleColor = circleColor == initialColor ? #DDEE00 : initialColor;
      startTime = millis();
    }
  }
  else if (step == 1)
  {
    if (millis() - startTime >= secondStepTime)
    {
      // Change color after 3 s
      circleColor = #DD5500;
    }
  }
  showCircle();
}

void showCircle()
{
  cx = width / 2 + 200 * cos(count);
  cy = height / 2 + 200 * sin(count);
  count += circleStep;
  noStroke();
  fill(circleColor);
  ellipse(cx, cy, circleSize, circleSize);
}

void mouseClicked()
{
  if (dist(mouseX, mouseY, cx, cy) < circleSize / 2)
  {
    step = 1;
    startTime = millis();
    circleStep = -circleStep;
    circleColor = #BB5500;
  }
}

