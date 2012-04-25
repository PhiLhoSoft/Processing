import java.awt.event.*;
 
boolean hasMoved;
 
void setup() 
{
  size(400, 400);
  
  addMouseWheelListener(new MouseWheelListener() 
  { 
    public void mouseWheelMoved(MouseWheelEvent mwe) 
    { 
      mouseWheel(mwe.getWheelRotation());
    }
  }); 
}
 
int lastFrame;
void mouseWheel(int delta) 
{
  println("Mouse has moved by " + delta + " units.");
  if (frameCount - lastFrame > 3) // You can ajust the number, higher to take in account slow scrolls
  {
    // We had a frame without mouse move, we can say it is a new event
    hasMoved = true;
  }
  lastFrame = frameCount;
}
 
void draw() 
{
  background(255);
  if (hasMoved)
  {
    hasMoved = false; // One shot
    fill(#FF0000);
    println(">>> Moved!");
  }
  else
  {
    fill(#00FF00);
  }
  ellipse(width / 2, height / 2, 100, 100);
}

