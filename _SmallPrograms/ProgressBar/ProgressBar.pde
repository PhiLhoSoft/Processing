float totalTime;
int startTime;
int barMaxWidth, barHeight;
int MIN_HEIGHT = 40;
int MARGIN = 5;

void setup()
{
  size(500, 300);
  smooth();
  textAlign(CENTER, CENTER);
  textSize(24);
  
  // 2 to 8 seconds
  totalTime = random(2000, 8000);
  barMaxWidth = width / 2;
  barHeight = height / 10;
  if (barHeight < MIN_HEIGHT)
  {
    barHeight = MIN_HEIGHT;
  }
}
 
void draw()
{
  if (frameCount == 1) // First frame
  {
    // Take in account the time to set up the sketch
    startTime = millis();
  }

  background(255);
  
  drawBox();
  drawProgressBar();
  showProgress();
} 

void drawBox()
{
  rectMode(CENTER);
  int boxWidth = barMaxWidth + 2 * MARGIN;
  int boxHeight = barHeight + 2 * MARGIN;
  noFill();
  stroke(0);
  strokeWeight(1);
  rect(width / 2, height / 2, boxWidth, boxHeight);
}

void drawProgressBar()
{
  int progress = int(constrain(map(millis(), startTime, totalTime + startTime, 0, barMaxWidth), 0, barMaxWidth));
  fill(int(map(progress, 0, barMaxWidth, 255, 0)));
  noStroke();
  rectMode(CORNER);
  rect((width - barMaxWidth) / 2, (height - barHeight) / 2, progress, barHeight);
}

void showProgress()
{
  String message;
  int currentTime = millis();
  if (currentTime - startTime <= totalTime)
  {
    int progress = int(100 * (currentTime - startTime) / totalTime);
    message = (progress / 5 * 5) + "%";
    fill(0);
  }
  else
  {
    message = "100% Done!";
    fill(255);
  }
  text(message, width / 2, height / 2);
}

