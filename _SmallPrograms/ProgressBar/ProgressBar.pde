float totalTime;
int startTime;
int barMaxWidth, barHeight;
int MIN_HEIGHT = 40;
int MARGIN = 5;

int mode = 2;
int modeNb = 5;
color messageColor = #2277FF;

boolean showProgress;
boolean paused;
int pauseTime;

void setup()
{
  size(500, 300);
  smooth();
  textAlign(CENTER, CENTER);
  textSize(24);
  
  barMaxWidth = width / 2;
  barHeight = height / 10;
  if (barHeight < MIN_HEIGHT)
  {
    barHeight = MIN_HEIGHT;
  }
}
 
void draw()
{
  background(255);
  if (!showProgress)
  {
    // Show instructions
    fill(messageColor);
    text("Click mouse to start", width / 2, 30);
    return; // Keep screen white
  }
  
  drawBox();
  drawProgressBar();
  showProgress();
} 

// Draw the box surrounding the progress bar
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

// Draw the progress bar itself
void drawProgressBar()
{
  // Length of the bar, depending on the current time and total time
  int progress = int(constrain(
      map(millis(), startTime, totalTime + startTime, 0, barMaxWidth), 
      0, barMaxWidth));
  int left = (width - barMaxWidth) / 2;
  int top = (height - barHeight) / 2;
  if (mode == 0)
  {
    fill(int(map(progress, 0, barMaxWidth, 255, 0)));
    noStroke();
    rectMode(CORNER);
    rect(left, top, progress, barHeight);
  }
  else if (mode == 1)
  {
    for (int i = 0; i < progress; i++)
    {
      stroke(int(map(i, 0, progress, 255, 0)));
      line(left + i, top, left + i, top + barHeight - 1);
    }
  }
  else if (mode == 2)
  {
    for (int i = 0; i < progress; i++)
    {
      stroke(int(map(i, 0, barMaxWidth, 255, 0)));
      line(left + i, top, left + i, top + barHeight - 1);
    }
  }
  else if (mode == 3)
  {
    for (int i = 0; i < progress; i++)
    {
      stroke(128, int(map(i, 0, barMaxWidth, 0, 255)), int(map(i, 0, progress, 0, 255)));
      line(left + i, top, left + i, top + barHeight - 1);
    }
  }
  else if (mode == 4)
  {
    for (int i = 0; i < barHeight; i++)
    {
      stroke(int(map(i, 0, barHeight, 255, 0)));
      line(left, top + i, left + progress, top + i);
    }
  }
}

// Show the amount of progress in the middle text
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
  
  fill(messageColor);
  text("0", width / 2 - barMaxWidth / 2 - MARGIN * 4, height / 2);
  text(nf(totalTime / 1000, 1, 2), width / 2 + barMaxWidth / 2 + MARGIN * 8, height / 2);
}

// Start or restart the progress of the bar
void startProgress()
{
  // We start to display the progress bar
  showProgress = true;
  // Stop pause if we were in this state
  paused = false;
  loop();
  // We note the starting time
  startTime = millis();
  // And we draw a total duration, 2 to 8 seconds
  totalTime = random(2000, 8000);
}

void keyPressed()
{
  if (key == 'p') // Pause / restart toggle
  {
    if (!paused)
    {
      // Pause
      noLoop();
      // Remember at which amount we were
      pauseTime = millis() - startTime;
    }
    else
    {
      // Resume
      loop();
      // And restore the previous amount of progress
      startTime = millis() - pauseTime;
    }
    // Toggle the state
    paused = !paused;
  }
  else if (key >= '0' && key < '0' + modeNb)
  {
    mode = key - '0';
  }
  else
  {
    startProgress();
  }
}
void mousePressed()
{
  startProgress();
}

