int w = 200;
final static int INCR = 50;
java.awt.Insets insets;

void setup()
{
  size(200, 400);
  background(100);
  frame.pack();  // Get insets. Get more!
  insets = frame.getInsets();
  // On Windows 7, the displayed frame is 3 pixels wider/taller (on each border)
  // than the actual frame (as reported here, or by other native Windows softwares)
  println(insets);
  // The frame here is smaller than the final one and still hidden
  println(frame);
  
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
  // Real size frame, before resizing
  println(frame);
  w += INCR;
  // Change internal canvas size
  setSize(w, height);
  // width variable isn't updated yet, will be on draw()
  println("Press: " + width + " => " + w);

  int windowW = Math.max(w, MIN_WINDOW_WIDTH) +
      insets.left + insets.right;
  int windowH = Math.max(height, MIN_WINDOW_HEIGHT) +
      insets.top + insets.bottom;

  // Change frame size, taking in account the insets (borders, title bar)
  frame.setResizable(true); // Not necessary in Windows, solves an issue on Mac
  frame.setSize(windowW, windowH);
  frame.setResizable(false);
  // https://forum.processing.org/topic/using-frame-setresizable-true-set-the-wrong-height-13-8-2012-1
}

