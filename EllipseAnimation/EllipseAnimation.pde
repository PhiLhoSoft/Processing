import netscape.javascript.*;


int timer = 0;

// I like to use variables, make easier to change / adapt
int centerX = 300;
int centerY = 250;

int diskW = 250;
int diskH = 50;
float ratioV = 0.3;
float offset = ratioV * diskH;

MovingShape ms;

void setup() {
  size(600, 600);
  smooth();

//~   ms = new MovingEllipse();
  ms = new MovingIcon();
}

void draw() {
  ms.move();

  drawBackground();
  if (ms.afterMiddleOfMove())
  {
    drawUpperDivider();
    ms.draw();
  }
  else
  {
    ms.draw();
    drawUpperDivider();
  }
}

void mousePressed() {
  if (ms.isReady() && isMouseInDisk()) {
    JSObject win = (JSObject) JSObject.getWindow(this);
    String[] arguments = { "Hello World!" };
    win.call("DumbTest", arguments);
//    link("http://Processing.org");
  }
}

void mouseMoved() {
  cursor(ARROW);
  if (isMouseInDisk()) {
    if (ms.isReady()) {
      cursor(HAND);
    } else {
      ms.setGoing(true);
    }
  } else {
    if (ms.isReady()) {
      ms.setReady(false);
      ms.setGoing(true);
      ms.invertSpeed();
    }
  }
}

void drawBackground() {
  background(255);

  // Disk
  fill(255);
  ellipse(centerX, centerY, diskW, diskH);

  // Bottom divider
  stroke(0);
  line(centerX, centerY + 50, centerX, height);

  // Bottom
  noFill();
  arc(centerX, centerY, diskW, diskH * 2, 0, PI);

  // Big dot
  fill(0);
  ellipse(centerX, centerY + offset, 50, 15);
}

void drawUpperDivider() {
  // Divider
  stroke(0);
  line(centerX, centerY - offset, centerX, 0);

  // Little dot
  fill(0);
  ellipse(centerX, centerY - offset, 10, 10);
}

boolean isMouseInDisk() {
  return isPointInEllipse(mouseX, mouseY,
      centerX, centerY, diskW, diskH);
}

boolean isPointInEllipse(int x, int y,
    int ellipseX, int ellipseY, int ellipseW, int ellipseH) {
  // Compute position of focal points
  float c = sqrt(ellipseW * ellipseW - ellipseH * ellipseH) / 2.0;
  float f1x = ellipseX - c;
  float f2x = ellipseX + c;
  // Compute distances from focal points to given point
  float d1 = dist(x, y, f1x, ellipseY);
  float d2 = dist(x, y, f2x, ellipseY);
  // Distance from focal points to point on ellipse is constant, equal to width
  // (twice the distance between foci)
  return d1 + d2 <= ellipseW;
}

abstract class MovingShape
{
  // Constants to be set in sub-class
  float SHAPE_WIDTH_MIN;
  float SHAPE_WIDTH_MAX;
  float SHAPE_HEIGHT_MIN;
  float SHAPE_HEIGHT_MAX;

  float shapeX = centerX;
  float shapeY = centerY - offset;

  float shapeWidth = SHAPE_WIDTH_MIN;
  float shapeHeight = SHAPE_HEIGHT_MIN;

  float pos = -HALF_PI;
  float speed = 0.07;

  boolean ready;
  boolean going;

  MovingShape()
  {
  }

  void move()
  {
    if (going) {
      pos += speed;
      shapeX = centerX - 0.4 * diskW * cos(pos);
      shapeY = centerY + offset * sin(pos);
      if (pos >= HALF_PI) {
        going = false;
        ready = true;
        timer = millis();
      }
      if (pos <= -HALF_PI) {
        going = false;
        speed = -speed;
      }
      recomputeShapeSize();
    }

    if (ready) { // Wait for user input
      if (millis() - timer > 2000 && !isMouseInDisk()) {
        ready = false;
        speed = -speed;
        going = true;
      }
    }
  }

  void recomputeShapeSize()
  {
    float amount = (HALF_PI + pos) / PI;
    shapeWidth = lerp(SHAPE_WIDTH_MIN, SHAPE_WIDTH_MAX, amount);
    shapeHeight = lerp(SHAPE_HEIGHT_MIN, SHAPE_HEIGHT_MAX, amount);
  }

  // To be overridden
  void draw()
  {
  }

  void invertSpeed()
  {
    speed = -speed;
  }

  boolean isReady()
  {
    return ready;
  }
  void setReady(boolean r)
  {
    ready = r;
  }

  boolean isGoing()
  {
    return going;
  }
  void setGoing(boolean g)
  {
    going = g;
  }
  
  boolean afterMiddleOfMove()
  {
    return pos > 0;
  }
}

class MovingEllipse extends MovingShape
{
  // Constants
  static final color SHAPE_COLOR = #7ADE21;
  {
    SHAPE_WIDTH_MIN = 10;
    SHAPE_WIDTH_MAX = 25;
    SHAPE_HEIGHT_MIN = 3;
    SHAPE_HEIGHT_MAX = 6;
  }

  MovingEllipse()
  {
    super();
  }

  void draw()
  {
    // Moving circle shape size and colour details
    stroke(0);
    fill(SHAPE_COLOR);
    ellipse(shapeX, shapeY, shapeWidth, shapeHeight);
  }
}

class MovingIcon extends MovingShape
{
  // Constants
  {
    SHAPE_WIDTH_MIN = 7;
    SHAPE_WIDTH_MAX = 72;
    SHAPE_HEIGHT_MIN = 7;
    SHAPE_HEIGHT_MAX = 71;
  }

  PImage icon;

  MovingIcon()
  {
    super();

    icon = loadImage("icon.png");
  }

  void draw()
  {
    image(icon,
        shapeX - shapeWidth/2, shapeY - shapeHeight/2,
        shapeWidth, shapeHeight);
  }
}


