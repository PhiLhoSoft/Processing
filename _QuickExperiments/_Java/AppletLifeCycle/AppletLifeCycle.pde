// Based on http://download.oracle.com/javase/tutorial/deployment/applet/lifeCycle.html

StringBuilder buffer;

public void init() {
  buffer = new StringBuilder();
  addItem("Initializing...");
  super.init();
}

public void start() {
  addItem("Starting...");
  super.start();
}

void setup()
{
  size(200, 500);
  PFont f = createFont("Verdana", 12);
  textFont(f);
  addItem("Setup... (v.1.1)");
}

void draw()
{
  background(255);
  noFill();
  stroke(0);
  rect(0, 0, width-1, height-1);
  fill(0);
  text(buffer.toString(), 10, 20);
}

public void stop() {
  addItem("Stopping...");
  super.stop();
}

public void destroy() {
  addItem("Preparing for unloading...");
  super.destroy();
}

private void addItem(String newWord) {
  println(newWord);
  buffer.append(newWord).append("\n");
}

