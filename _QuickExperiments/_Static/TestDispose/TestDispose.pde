DisposeHandler dh;

void setup()
{
  println("Before size");
  size(500, 500);
  println("In setup");

  dh = new DisposeHandler(this);
}

void draw()
{
  println("Drawing " + frameCount);
  if (frameCount >= 20)
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

