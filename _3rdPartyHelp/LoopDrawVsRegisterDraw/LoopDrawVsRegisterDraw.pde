ArrayList<TestObject> list = new ArrayList<TestObject>();
int amount = 10000;
int ms;
int currentTime;
boolean useRegisterDraw = false;
 
void setup() {
  size(1024, 768);
//~   frameRate(60);
  textSize(40);
  strokeWeight(1);
  stroke(0, 128);
  smooth();
  for (int i = 0; i < amount; i++) {
    float rnd = random(5, 10);
    list.add(new TestObject(random(width), random(height), rnd, rnd));
  }
  ms = millis();
}
 
void draw() {
  background(255);
  for (TestObject obj : list) {
    if (!useRegisterDraw) {
      obj.draw();
    }
    obj.move();
  }
  fill(255,0,0);
  text(str(currentTime), 10, 10, 200, 200);
  if (frameCount % 10 == 0) {
    currentTime = millis() - ms;
    println(currentTime);
    ms = millis();
  }
}
 
public class TestObject {
  float x;
  float y;
  float w;
  float h;
  
  public TestObject(float tX, float tY, float tW, float tH) {
    if (useRegisterDraw) {
      registerDraw(this);
    }
    x = tX;
    y = tY;
    w = tW;
    h = tH;
  }
  
  public void draw() {
    fill(0, 64);
    ellipse(x, y, w, h);
  }
  
  public void move() {
    x += random(-2, 2);
    y += random(-2, 2);
  }
}

