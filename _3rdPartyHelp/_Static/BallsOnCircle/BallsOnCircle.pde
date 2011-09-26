final float MAX_SIZE = 130.0;
final float MIN_SIZE = 60.0;
final float CENTER_SIZE = 40.0;
float MAIN_RADIUS = CENTER_SIZE * 0.5 + MAX_SIZE * 0.5;
int ballAmt = 5;
Ball[] balls;

void setup() {
  size(300, 350);
  smooth();
  textFont(createFont("Arial", 12));

  initAll();

  stroke(255, 0, 0);
}

void draw() {
  background(200);
  translate(width/2, height/2);

  fill(255);

  ellipse(0, 0, CENTER_SIZE, CENTER_SIZE);

  for (int i = 0; i < ballAmt; i++) {
    balls[i].draw();
    line(0, 0, balls[i].x, balls[i].y);
  }

  noFill();

  ellipse(0, 0, MAIN_RADIUS*2, MAIN_RADIUS*2);
}

void initAll() {
  float[] sizes = { random(1), random(1), random(1), 1.0 }; // normalised sizes
  println("Main radius: " + MAIN_RADIUS);

  ballAmt = sizes.length;
  balls = new Ball[ballAmt];

  float totalAngle = 0;
  for (float size : sizes) {
    float ballRadius = getRadius(size);
    println("Radius: " + ballRadius);
    float ballAngle = getAngle(ballRadius);
    showAngle("Angle", ballAngle);
    totalAngle += ballAngle;
  }
  float intervalAngle = (TWO_PI - totalAngle) / ballAmt;
  showAngle("Total", totalAngle);
  showAngle("Interval", intervalAngle);

  float currentAngle = 0;
  for (int i = 0; i < ballAmt; i++) {
    float ballRadius = getRadius(sizes[i]);
    float ballAngle = getAngle(ballRadius);

    float x = MAIN_RADIUS * cos(currentAngle);
    float y = MAIN_RADIUS * sin(currentAngle);
    float posX = MAIN_RADIUS * cos(currentAngle + ballAngle / 2);
    float posY = MAIN_RADIUS * sin(currentAngle + ballAngle / 2);
    balls[i] = new Ball(posX, posY, ballRadius * 2, x, y, i);

    currentAngle += intervalAngle + ballAngle;
    showAngle("Current", currentAngle);
  }
  println("Done\n");
}

float getRadius(float size) {
  return map(size, 0, 1, MIN_SIZE, MAX_SIZE) / 2;
}

// Compute the angle of the intersecting points of a circle (of given radius)
// and a bigger circle (of given MAIN_RADIUS) with the center of the small circle on the big circle.
float getAngle(float radius) {
  // Length of a cord: c = 2 R sin(alpha/2)
  // From center of circle to intersecting point: radius = 2 * MAIN_RADIUS * sin(alpha / 4)
  float alpha = 4 * asin(radius / MAIN_RADIUS / 2);
  return alpha;
}

void showAngle(String msg, float angle) { println(msg + ": " + degrees(angle)); }

void mousePressed() {
  initAll();
}

class Ball {

  float x;
  float y;
  float posX;
  float posY;
  float siz;
  int id;

  Ball(float posX, float posY, float siz, float x, float y, int n) {
    this.posX = posX;
    this.posY = posY;
    this.siz = siz;
    this.x = x;
    this.y = y;
    id = n;
  }

  void draw() {
    fill(255);
    ellipse(posX, posY, siz, siz);
    fill(#005599);
    text("" + id, posX, posY);
  }
}
