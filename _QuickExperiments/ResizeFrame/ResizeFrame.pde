int w = 200;
final static int INCR = 50;
Insets insets;

void setup()
{
  size(200, 400);
  background(100);
  frame.pack();  // Get insets. Get more!
  insets = frame.getInsets();
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

