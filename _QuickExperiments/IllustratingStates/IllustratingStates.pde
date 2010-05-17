// [url=http://processing.org/discourse/yabb2/YaBB.pl?num=1265681408]bug when using delay.[/url]

int state;
Timer timer;

void setup()
{
  size(500, 500);
  smooth();
  ellipseMode(CORNERS);
  noStroke();
  PFont font = createFont("Arial", 24);
  textFont(font);
  
  state = 0;
  timer = new Timer(2); // Wait 2 seconds before starting
  timer.start();
  ShowState();
}

void draw()
{
  if (timer.isFinished())
  {
    // Time to change state
    switch (state) 
    {
      case 0: // Initial state
        state = 1;
        timer.start(1);
        break;
      case 1: // Middle state
        state = 2;
        timer.start(0.5);
        break;
      case 2: // Last state
        state = 0;
        timer.start(2); // Back to 2s
        break;
    }
    // For state, I could have done state = ++state % 3;
    // but complexer behavior (depending on user input for example)
    // is possible

    ShowState();    
  }
  // Handle drawing, depending on state
  switch (state) 
  {
    case 0:
      fill(0, 0, 255);
      ellipse(10, 10, 110, 110);
      //println("blue");
      break;
    case 1: // 
      fill(255, 0, 0);
      rect(10, 10, 100, 100);
      //println("red");
      break;
    case 2: // 
      fill(0, 255, 0);
      rect(20, 20, 80, 80);
      //println("green");
      break;
  }
}

class Timer {
  float savedTime;  // When Timer started
  float totalTime;  // How long Timer should last

  Timer(float pTotalTime)  {
    totalTime = pTotalTime;
  }

  //  Starting the timer
  void start() {
    savedTime = millis() / 1000.0; // When the Timer starts it stores the current time in seconds
  }
  
  // Starting the timer by changing its total time
  void start(float pTotalTime)  {
    totalTime = pTotalTime;
    start();
  }
  
  boolean isFinished() {
    //  Check how much time has passed
    float passedTime = millis() / 1000.0 - savedTime;
    return passedTime > totalTime;
  }
  
  float getDelay() {
     return totalTime;
  }
}

// Show current state
void ShowState()
{
  int posX = 180, posY = 60;
  fill(255);
  rect(posX, posY, 50, 50);
  fill(0);
  textSize(24);
  text("" + state, posX + 20, posY + 25);
  textSize(12);
  text("" + timer.getDelay(), posX + 20, posY + 45);
}
