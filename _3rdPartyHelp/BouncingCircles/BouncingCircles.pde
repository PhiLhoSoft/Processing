int maxCircle = 200;
float minDistance = 20;
Circle[] circles = new Circle[maxCircle];
 

void setup() {
  size(800, 800);
  smooth();
  for (int i = 0; i < maxCircle; i++) {
    circles[i] = new Circle();
  }
}
 

void draw() {
  background(255, 255);
  for (int i = 0; i < maxCircle; i++) {
    circles[i].update(); // No need to pass global variables as parameters...
 
    noFill();
    for (int j = 0; j < maxCircle; j++) {
      if (i == j)
        continue;
         
      // No need for a global variable here
      float distance = dist(circles[i].x, circles[i].y, circles[j].x, circles[j].y);
      if (distance < minDistance) {
        stroke(0, 20);
        line(circles[i].x, circles[i].y, circles[j].x, circles[j].y);
      }
    }

 
    circles[i].display();
  }
}
 
void mouseMoved() {
  for (int i = 0; i < maxCircle; i++) {
    float distance = dist(mouseX, mouseY, circles[i].x, circles[i].y);
 
    circles[i].x -= (mouseX - circles[i].x) / distance;
    circles[i].y -= (mouseX - circles[i].y) / distance;
 
    circles[i].checkBounds();
  }
}


class Circle {
  float x, y, vx, vy, r, speed;
 
  Circle() {  
   vx = random(-1, 1);
   vy = random(-1, 1);
   r = random(1, 10); // See below
   x = random(r, width - r);
   y = random(r, height - r);  
  }
 
  void checkBounds() {
    if (x < r || x > width - r) {
      vx *= -1;
      if (x < r) {
        x = r;
      } else {
        x = width - r;
      }
    }
    if (y <= r || y >= height - r) {
      vy *= -1;
      if (y < r) {
        y = r;
      } else {
        y = width - r;
      }
    }
  }
 
  void update() {
    x += vx;
    y += vy;
    checkBounds();
  }
 
  void display() {
    fill(0, 50);
    noStroke();
    // Ellipse takes a diameter, not a radius!
    ellipse(x, y, r * 2, r * 2);
  }
} 

