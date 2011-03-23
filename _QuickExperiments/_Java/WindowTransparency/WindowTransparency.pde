// http://java.sun.com/developer/technicalArticles/GUI/translucent_shaped_windows/

// final make them constants: not necessary, but safer
final int MARGIN_LEFT = 225;
final int MARGIN_TOP = 145;
final int TABLE_WIDTH = 450;
final int TABLE_HEIGHT = 300;
final int HOLE_SIZE = 90;
final int BACKGROUND = color(0, 0, 255);

public void init()
{
  frame.removeNotify();
  frame.setUndecorated(true);
//  frame.addNotify();

  super.init();
}

void setup()
{
  size(900, 600);
  smooth();
  ellipseMode(CENTER);
  com.sun.awt.AWTUtilities.setWindowOpaque(frame, false);
  // Works well in Windows 7, less in Windows XP
  com.sun.awt.AWTUtilities.setWindowOpacity(frame, 0.9f);

  loadPixels();
  for (int i = 0; i < pixels.length; i++) pixels[i] = 0;
  updatePixels();
}

void draw()
{
//  background(255);
  stroke(64, 0, 128);
  strokeWeight(2);
  fill(0, 150, 0);
  rect(MARGIN_LEFT + frameCount, MARGIN_TOP, TABLE_WIDTH, TABLE_HEIGHT);
 
  stroke(255, 128, 0);
  strokeWeight(5);
  fill(BACKGROUND);
  ellipse(MARGIN_LEFT, MARGIN_TOP, HOLE_SIZE, HOLE_SIZE);
  ellipse(MARGIN_LEFT + TABLE_WIDTH, MARGIN_TOP, HOLE_SIZE, HOLE_SIZE);
  ellipse(MARGIN_LEFT, MARGIN_TOP + TABLE_HEIGHT, HOLE_SIZE, HOLE_SIZE);
  ellipse(MARGIN_LEFT + TABLE_WIDTH, MARGIN_TOP + TABLE_HEIGHT, HOLE_SIZE, HOLE_SIZE);
}

int mX;
int mY;

void mousePressed()
{
  mX = mouseX;
  mY = mouseY;
}

void mouseDragged()
{
//  java.awt.Point p = frame.getLocation();
//  frame.setLocation(p.x + mouseX - mX, p.y + mouseY - mY);
  java.awt.Point p = java.awt.MouseInfo.getPointerInfo().getLocation();
  frame.setLocation(p.x - mX, p.y - mY);
}

