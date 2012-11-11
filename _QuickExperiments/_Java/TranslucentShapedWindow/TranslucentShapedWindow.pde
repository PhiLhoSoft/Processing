// Making a translucent and shaping window in Processing
// https://blogs.oracle.com/thejavatutorials/entry/translucent_and_shaped_windows_in
// and
// https://forum.processing.org/topic/translucen-window-in-processing
// to apply to Processing (gave the trick to use a secondary frame)

import javax.swing.JFrame;

final java.awt.Color fullyTransparent = new java.awt.Color(0, 0, 0, 0);

// Apparently, Processing forces a background, and we cannot override it,
// so we have to hide the Processing's frame, and make our own
JFrame displayedFrame;
Frame oldFrame;

public void init()
{
  oldFrame = frame;
//  frame.setLocation(-5000, -5000);
  /*
  // Hide the old frame
  frame.removeNotify();
  frame.setUndecorated(true);
//  frame.setOpacity(0.8);
  frame.setBackground(fullyTransparent);
  frame.addNotify();
  //*/
  
  //*
  displayedFrame = new JFrame();
  displayedFrame.removeNotify();
  displayedFrame.setUndecorated(true);
  displayedFrame.setLayout(null); // Each added component replace the previous one
  displayedFrame.setLocationRelativeTo(null);
  displayedFrame.setLocation(200, 200);
//  displayedFrame.setOpacity(1);
  displayedFrame.addNotify();
  
  frame = displayedFrame;
//  displayedFrame.add(this);
  //*/
  
  super.init();
  
  // Allow transparency on the sketch's main graphics
  g.format = ARGB;
  // Tell it isn't the primary drawing surface (even if it is), to avoid automatic background() call
  g.setPrimary(false);
}

final int MARGIN = 25;

void setup()
{
  size(300, 200); // Flickers more with a bigger window...
  smooth();

  //*
  displayedFrame.setSize(width, height);
  // The size must be set before
  displayedFrame.setBackground(fullyTransparent);
  displayedFrame.setVisible(true);
  //*/
  
  posX = width / 2;
  posY = height / 2;
}

void clearBackground()
{
  loadPixels();
  Arrays.fill(pixels, 0x100000FF);
  updatePixels();
}

float posX, posY;
void draw()
{
  // Must be called in draw(), for some unknown reason... And on the second frame!
  if (frameCount == 2) oldFrame.setVisible(false);
//  clearBackground();
  background(0, 0, 50, 50);

  color c = #2222FF;
  int w = width - 1;
  int h = height - 1;
  strokeWeight(1);
  for (int i = 0; i < MARGIN; i++)
  {
    stroke(c, i * 100.0 / MARGIN);
    line(i, i + 1, i, h - i - 1);
    line(w - i, i + 1, w - i, h - i - 1);
    line(i, i, w - i, i);
    line(i, h - i, w - i, h - i);
  }
  fill(c, 100);
  noStroke();
  rect(MARGIN, MARGIN, w - 2 * MARGIN + 1, h - 2 * MARGIN + 1);
  
  stroke(#EEEE00);
  strokeWeight(8);
  fill(#AAFF44);
  posX += random(-1, 1);
  posY += random(-1, 1);
  ellipse(posX, posY, height / 3, height / 3);
  
  noFill(); noStroke();
//  stroke(#FFFF00); strokeWeight(1); rect(0, 0, w, h);

  // We need to do this on each frame to get the animation...  
  displayedFrame.add(this);
}

// Dragging the frame
int mX;
int mY;

void mousePressed()
{
  mX = mouseX;
  mY = mouseY;
}

void mouseDragged()
{
  java.awt.Point p = java.awt.MouseInfo.getPointerInfo().getLocation();
  frame.setLocation(p.x - mX, p.y - mY);
}

