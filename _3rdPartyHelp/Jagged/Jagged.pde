// http://processing.org/discourse/yabb2/YaBB.pl?num=1263387820
int num = 90;
float deg = 0;

// By default initialized to 0
float[] xpos = new float[num];
float[] ypos = new float[num];

void setup() {
  size(600, 600, P2D);
  smooth();
  noFill();
}

void draw() {
  background(25.5);
  translate(width/2, height/2);
  stroke(255);
  path();
}

void path() {
  for(int i = 0; i < num-1; i++) {
    xpos[i] = xpos[i+1];
    ypos[i] = ypos[i+1];
  }
  deg += 0.0008 * num;
  float n = map(noise(xpos[num-1]), 0.0, 1.0, 10, 300);
  float rx = sin(deg)*n;
  float ry = cos(deg)*n;
  xpos[num-1] = rx;
  ypos[num-1] = ry;
  
  beginShape();
  vertex(xpos[0], ypos[0]);
  for(int j = 1; j < num; j++) {
    vertex(xpos[j], ypos[j]);
  }
  endShape();
} 

