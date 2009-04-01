int w = 200;
final static int INCR = 50;
Insets insets;

void setup()
{
  size(200, 400);
  background(100);
  frame.pack();  // Get insets. Get more!
  insets = frame.getInsets();
  
  PGraphics icon = createGraphics(16, 16, JAVA2D);
  icon.beginDraw();
  icon.noStroke();
  icon.fill(#55AAFF);
  icon.ellipse(8, 8, 16, 16);
  icon.fill(#FFEE22);
  icon.ellipse(9, 6, 8, 6);
  icon.stroke(#FFEE22);
  icon.strokeWeight(3);
  icon.line(6, 6, 6, 12);
  icon.endDraw();
  frame.setIconImage(icon.image);
}

void draw()
{
  background(100);
  line(0, 0, width, height);
  line(0, height, width, 0);
  fill(#55AAFF);
  for (int i = 0; i < width; i += INCR)
  {
    ellipse(i + INCR/2, height/2, INCR, INCR);
  }
}

void mousePressed()
{
  w = w + INCR;
  // Change internal canvas size
  setSize(w, height);
  // width variable isn't updated yet, will be on draw()
  println("Press: " + w + " => " + width);

  int windowW = Math.max(w, MIN_WINDOW_WIDTH) +
      insets.left + insets.right;
  int windowH = Math.max(height, MIN_WINDOW_HEIGHT) +
      insets.top + insets.bottom;

  // Change frame size, taking in account the insets (borders, title bar)
  frame.setSize(windowW, windowH);
}

