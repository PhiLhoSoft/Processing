import java.awt.event.*;

void setup() 
{
  size(400, 400);
  frame.setResizable(true); 
  textFont(createFont("Arial", 48));
  fill(0);
  frame.addComponentListener(new CL());
}

void draw() 
{
  background(255);
  text("FC: " + frameCount, 50, 50);
  line(0, 0, width, height);
}

class CL extends ComponentAdapter
{
  void componentMoved(ComponentEvent e)
  {
    println("Moved: " + e);
  }
  void componentResized(ComponentEvent e)
  {
    println("Resized: " + e);
  }
}

