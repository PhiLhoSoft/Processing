// http://java.sun.com/developer/technicalArticles/GUI/translucent_shaped_windows/
// now
// http://www.oracle.com/technetwork/articles/javase/translucent-shaped-windows-139324.html

/* For Java 7
// Generates a warning because Processing doesn't understand import static... But works anyway.
import static java.awt.GraphicsDevice.WindowTranslucency.*;

import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
//*/

// final make them constants: not necessary, but safer
final int MARGIN_LEFT = 225;
final int MARGIN_TOP = 145;
final int TABLE_WIDTH = 450;
final int TABLE_HEIGHT = 300;
final int HOLE_SIZE = 90;

public void init()
{
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();

  super.init();
}

void setup()
{
  size(900, 600);
  smooth();
  ellipseMode(CENTER);

/* For Java 7
  // Determine what the default GraphicsDevice can support.
  GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
  GraphicsDevice gd = ge.getDefaultScreenDevice();

  boolean isUniformTranslucencySupported = gd.isWindowTranslucencySupported(TRANSLUCENT);
  boolean isPerPixelTranslucencySupported = gd.isWindowTranslucencySupported(PERPIXEL_TRANSLUCENT);
  boolean isShapedWindowSupported = gd.isWindowTranslucencySupported(PERPIXEL_TRANSPARENT);
  println(
      "\nisUniformTranslucencySupported: " + isUniformTranslucencySupported +
      "\nisPerPixelTranslucencySupported: " + isPerPixelTranslucencySupported +
      "\nisShapedWindowSupported: " + isShapedWindowSupported 
  );
//*/
/*
  com.sun.awt.AWTUtilities.setWindowOpaque(frame, false);
  // Works well in Windows 7, less in Windows XP
  com.sun.awt.AWTUtilities.setWindowOpacity(frame, 0.8);
//*/
  // Now, it is just simpler!
  frame.setOpacity(0.8);
}

void draw()
{
  // Tints the background
  background(#AABBFF);
  
  stroke(64, 0, 128);
  strokeWeight(2);
  fill(0, 150, 0);
  // Shows real time update...
  rect(MARGIN_LEFT + frameCount % TABLE_WIDTH, MARGIN_TOP, TABLE_WIDTH, TABLE_HEIGHT);
 
  stroke(255, 128, 0);
  strokeWeight(5);
  fill(128, 192, 255);
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

  stroke(#EEEE00);
  strokeWeight(8);
  fill(#AABB44);
  ellipse(width / 2, height / 2, height / 3, height / 3);
}

void keyPressed()
{
}

