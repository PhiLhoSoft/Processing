DisposeHandler dh;

void setup()
{
  size(500, 500);
  println("In setup");
  
  dh = new DisposeHandler(this);
}

void draw()
{
  println("Drawing " + frameCount);
  if (frameCount >= 100)
    exit();
}

void stop()
{
  println("In stop");
  super.stop();
}

public class DisposeHandler
{
  DisposeHandler(PApplet pa)
  {
    pa.registerDispose(this);
  }
  
  public void dispose()
  {
    println("In dispose");
  }
}

