// http://processing.org/discourse/yabb2/YaBB.pl?num=1263387820
final int NUM = 90;
float deg = 0;
int method = 2;
float tightness = 0;

// By default initialized to 0
float[] xpos = new float[NUM];
float[] ypos = new float[NUM];

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
  for (int i = 0; i < NUM-1; i++) {
    xpos[i] = xpos[i+1];
    ypos[i] = ypos[i+1];
  }
  deg += 0.0008 * NUM;
  float n = map(noise(xpos[NUM-1]), 0.0, 1.0, 10, 300);
  float rx = sin(deg)*n;
  float ry = cos(deg)*n;
  xpos[NUM-1] = rx;
  ypos[NUM-1] = ry;

  curveTightness(tightness);
  beginShape();
  vertex(xpos[0], ypos[0]);
  for (int j = 1; j < NUM; j++) {
    switch (method) {
    case 1: // Straight lines
      vertex(xpos[j], ypos[j]);
      break;
    case 2: { // First version of curves
      float cp1x = xpos[j-1];
      float cp1y = ypos[j-1];
      float cp2x = xpos[j];
      float cp2y = ypos[j];
      bezierVertex(cp1x, cp1y, cp2x, cp2y, (cp1x + cp2x)/2, (cp1y + cp2y)/2);
      }
      break;
    case 3: { // Second version of curves
      // Should compute line parameters and put the control points at a given distance of pos
      float cp1x = xpos[j];
      float cp1y = ypos[j] - 5;
      float cp2x = xpos[j] - 5;
      float cp2y = ypos[j];
      bezierVertex(cp1x, cp1y, cp2x, cp2y, xpos[j], ypos[j]);
      }
      break;
    case 4: // Using curve instead of bezier
      curveVertex(xpos[j], ypos[j]);
      break;
    case 5: // Using curve instead of bezier
      curveVertex((xpos[j-1] + xpos[j])/2, (ypos[j-1] + ypos[j])/2);
      break;
    default: // Whatever...
    }
  }
  endShape();
}

void keyPressed() {
  if (key == '1') method = 1;
  else if (key == '2') method = 2;
  else if (key == '3') method = 3;
  else if (key == '4') method = 4;
  else if (key == '5') method = 5;
  else if (key == '+') tightness += 0.2;
  else if (key == '-') tightness -= 0.2;
}

