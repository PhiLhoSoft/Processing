float bx;
float by;
int bs = 20;
boolean locked = false;
float bdifx = 0.0;
float bdify = 0.0;

float speedX, speedY;
float accelX, accelY;
boolean bMoving;

void setup()
{
  size(1200, 700);
  bx = width/2.0;
  by = height/2.0;
  rectMode(RADIUS);
}

void draw()
{
  background(0);

  // Test if the cursor is over the box
  if(isMouseOverBox()) {
    stroke(153);
    fill(153);
  } else {
    stroke(200);
    fill(200);
  }

  // Draw the box
  rect(bx, by, bs, bs);
  if (bMoving)
  {
    bx += speedX;
    by += speedY;
    if (!isBoxInArea()) {
      bx -= speedX; by -= speedY;
      if (!isBoxInArea()) {
        // Put back in playground
        bx = width/2.0;
        by = height/2.0;
      }
      bMoving = false;
      return;
    }
    float psx = speedX, psy = speedY;
    speedX -= accelX;
    speedY -= accelY;
    // Keep moving until one speed is inverted
    bMoving = sign(psx) == sign(speedX) && sign(psy) == sign(speedY);
  }
}

void mouseMoved() {
}

void mousePressed() {
  if(isMouseOverBox()) {
    locked = true;
    fill(255);
  } else {
    locked = false;
  }
  bdifx = mouseX-bx;
  bdify = mouseY-by;
}

void mouseDragged() {
  if(locked) {
    bx = mouseX-bdifx;
    by = mouseY-bdify;
  }
}

void mouseReleased() {
  locked = false;
  speedX = (mouseX - pmouseX) * 2;
  speedY = (mouseY - pmouseY) * 2;
  accelX = speedX / 10;
  accelY = speedY / 10;
  bMoving = true;
}

boolean isMouseOverBox() {
  return mouseX > bx-bs && mouseX < bx+bs &&
      mouseY > by-bs && mouseY < by+bs;
}

boolean isBoxInArea() {
  return bx > bs && by > bs && bx < width - bs && by < height - bs;
}

int sign(float v) {
  if (v < 0) return -1;
  if (v > 0) return 1;
  return 0;
}
