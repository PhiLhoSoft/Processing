// timer
int actualSecs; //actual seconds elapsed since start
int actualMins; //actual minutes elapsed since start
int startSec = 0; //used to reset seconds shown on screen to 0
int startMin = 0; //used to reset minutes shown on screen to 0
int scrnSecs; //seconds displayed on screen (will be 0-60)
int scrnMins=0; //minutes displayed on screen (will be infinite)
int restartSecs=0; //number of seconds elapsed at last click or 60 sec interval
int restartMins=0; //number of seconds ellapsed at most recent minute or click
//

final int CAR_NB = 7 ;
Car[] carList = new Car[CAR_NB];

void setup () {
  size(1000, 200);
  textSize(10);
  
  int pos = -1000;
  for (int i = CAR_NB-1; i >= 0 ; i--) {
    carList[i] = new Car("C" + i,
        color(0, 150, 200), 
        pos, 60, 1, 
        int(random(1000, 5000)));
    pos += 50 + int(random(10, 100));
  }
}

void draw () {
  background (255);

  // first car leads and moves
  carList[0].move();

  // the other cars just follow each other (and the first car)
  for (int i = 1; i < CAR_NB; ++i) {
    carList[i].follow(carList[i-1]);
  }


  for (int i = 0; i < CAR_NB; ++i) {
    carList[i].display();
//    println("Car " + i + " - " + carList[i].x + " " + (carList[i].stopTime == 0 ? "" : millis() - carList[i].stopTime));
  }
  
  drawTimer();

  // Not associated to cars!
  int x = width / 2;
  fill(#779900);
  triangle(x - 25, 50, x + 25, 50, x, 25);
}

class Car {
  color c;
  float x;
  float y;
  float speed;
  String name;
  float distanceBetweenCarsAlongXAxis = 35; // px
  int stopTime;
  boolean filled; // Gas tank is filled, continue
  int waitTime;

  Car(String supername, color superc, float superx, float supery, float superspeed, int wait) {
    name = supername;
    c = superc;
    x = superx;
    y = supery;
    speed = superspeed;
    waitTime = wait;
  }

  void display () {
    stroke(0);
    fill(c);
    rectMode(CENTER);
    rect(x, y, 30, 20);
    String state = "M"; // Moving
    if (filled) state = "F";
    else if (stopTime > 0) state = "W"; // Wait
    fill(255);
    text(name + " " + state, x - 10, y);
  }

  void move() {
    if (stopTime > 0) {
      if (millis() - stopTime > waitTime) {
        stopTime = 0;
        filled = true;
      } else {
        return; // No move
      }
    }
    x += speed;
    if (!filled && x >= width / 2) {
      stopTime = millis();
    }
  }

  /**
   * Follows next car keeping the given distance in pixels.
   */
  void follow(Car car) {
    if (car.x - x > distanceBetweenCarsAlongXAxis) {
      move();
    }
  }
  
  public String toString() { return name; }
}

void drawTimer() {
  String name = "";
  float timerValue = 0;
  float max = 0;
  for (int i = 0; i < CAR_NB; ++i) {
    if (carList[i].stopTime > 0) {
      timerValue = (millis() - carList[i].stopTime) / 1000.0;
      max = carList[i].waitTime / 1000.0;
      name = carList[i].name;
      break; // No need to ask other cars
    }
  }
  if (timerValue > 0) {
    fill(#FF0000);
    text(name + " - " + nf(timerValue, 1, 1) + " / " + nf(max, 1, 1), 20, 20);
  }
}

