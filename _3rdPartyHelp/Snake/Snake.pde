static final int V_MAX = 20; // Max nb of vertices
static final int L_MAX = 100; // Max length

float[] X = new float[V_MAX];
float[] Y = new float[V_MAX];
 
void setup() {
  size(500, 500);  
  smooth();
}
 
 
void draw() {
 
  background(255);
  fill(0);
  stroke(0);
 
  X[0] = mouseX;
  Y[0] = mouseY;
 
  for (int i = V_MAX-1; i > 0; i--) {
    X[i] = X[i-1];  
    Y[i] = Y[i-1];
  }
 
  beginShape(LINES);
  for (int i = 1; i < V_MAX; i++) {
    float t = map(i, 0, V_MAX, 10, 2);
    strokeWeight(t);
    vertex(X[i], Y[i]);
    vertex(X[i-1], Y[i-1]);
  }
  endShape();
 
} 
