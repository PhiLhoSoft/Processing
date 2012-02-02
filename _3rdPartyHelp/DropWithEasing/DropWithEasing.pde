float posX = 200;
float posY = 200;
float easeX;
float easeY;
boolean bEasing;
float epsilon = 0.01;
// pmouseX/Y has strange behavior in mouseDragged...
int prevMouseX;
int prevMouseY;

void setup() {
  size(800, 500);
  smooth();
}

void draw() {
  background(0);
  strokeWeight(1);
  fill(0, 255, 255);
  stroke(255, 102, 0);

  if (bEasing) {
    easeX *= 0.8;
    easeY *= 0.8;
    if (easeX < epsilon || easeY < epsilon) {
      bEasing = false;
      easeX = 0;
      easeY = 0;
    }
  }
  
//  pushMatrix();
  
  show("A " + mouseX);
  posX += easeX;
  posY += easeY;
//  translate(posX, posY);

  show("B " + mouseX);
  // Better draw at origin
  beginShape();
  vertex(posX +  0, posY +  0);
  vertex(posX + 50, posY + 50);
  vertex(posX +  0, posY +100);
  vertex(posX +-50, posY + 50);
  endShape();
  
//  popMatrix(); // Normally not necessary, but it isn't reset when mouseDragged is called!
  show("C " + mouseX);
}
void show(String m) { if (mousePressed) println(m); }

void mousePressed() {
  prevMouseX = mouseX;
  prevMouseY = mouseY;
}

void mouseDragged() {
  easeX = mouseX - prevMouseX;
  easeY = mouseY - prevMouseY;
  println(easeX + " " + mouseX + " " + prevMouseX);
  prevMouseX = mouseX;
  prevMouseY = mouseY;
}

void mouseReleased() {
  bEasing = true;
}

