boolean going = false, ready = false;
int timer = 0;

// I like to use variables, make easier to change / adapt
int centerX = 300;
int centerY = 250;

int diskW = 250;
int diskH = 50;
float ratioV = 0.3;
float offset = ratioV * diskH;

// Location of moving circle to start with (stationary)
float shapeX = centerX;
float shapeY = centerY - offset;

float pos = -HALF_PI;
float speed = 0.07;
color SHAPE_COLOR = #7ADE21;
float SHAPE_WIDTH_MIN = 10;
float SHAPE_WIDTH_MAX = 25;
float SHAPE_HEIGHT_MIN = 3;
float SHAPE_HEIGHT_MAX = 6;
float shapeWidth = SHAPE_WIDTH_MIN;
float shapeHeight = SHAPE_HEIGHT_MIN;

void setup() {
  size(600, 600);
  smooth();
}

void draw() {
  drawBackground();
  drawMovingShape();
  drawUpperDivider();

  // Only move the circle when "going" is true
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
    float amount = (HALF_PI + pos) / PI;
    shapeWidth = lerp(SHAPE_WIDTH_MIN, SHAPE_WIDTH_MAX, amount);
    shapeHeight = lerp(SHAPE_HEIGHT_MIN, SHAPE_HEIGHT_MAX, amount);
  }

  if (ready) { // Wait for user input
    if (millis() - timer > 2000 && !IsMouseInDisk()) {
      ready = false;
      speed = -speed;
      going = true;
    }
  }
}

void mousePressed() {
  if (ready && IsMouseInDisk()) {
    link("http://Processing.org");
  }
}

void mouseMoved() {
  cursor(ARROW);
  if (IsMouseInDisk()) {
    if (ready) {
      cursor(HAND);
    } else {
      going = true;
    }
  } else {
    if (ready) {
      ready = false;
      speed = -speed;
      going = true;
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
  ellipse(centerX, centerY - offset, SHAPE_WIDTH_MIN, SHAPE_HEIGHT_MIN);
}

void drawMovingShape() {
  // Moving circle shape size and colour details
  stroke(0);
  fill(SHAPE_COLOR);
  ellipse(shapeX, shapeY, shapeWidth, shapeHeight);
}

boolean IsMouseInDisk() {
  return IsPointInEllipse(mouseX, mouseY,
      centerX, centerY, diskW, diskH);
}

boolean IsPointInEllipse(int x, int y,
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



