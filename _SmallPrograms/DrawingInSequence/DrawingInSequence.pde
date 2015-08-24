ArrayList<Drawer> drawers = new ArrayList<Drawer>();
Drawer currentDrawer;
int currentDrawerIdx;
int currentDuration;

interface Drawer
{
  public void draw();
  public int getDuration();
  public void setDuration(int d);
}

abstract class DefaultDrawer implements Drawer
{
  protected int duration = 10;

  public abstract void draw();
  @Override
  public int getDuration()
  {
    return duration;
  }
  @Override
  public void setDuration(int d)
  {
    duration = d;
  }
}

class Texter extends DefaultDrawer
{
  private String message;
  private int textColor;

  public Texter(int d, String m, int c)
  {
    duration = d;
    message = m;
    textColor = c;
  }

  //@Override
  public void draw()
  {
    background(0);
    textAlign(CENTER);
    fill(textColor);
    noStroke();
    // Suppose textFont() have been called
    text(message, width / 2, height / 2);
  }
}

void setup()
{
  size(800, 800);
  PFont f = createFont("Arial", 48);
  textFont(f);
  smooth();

  drawers.add(new Texter(7, "Demonstrating drawing in sequence", #FF1100));
  drawers.add(new Texter(5, "Fill With Circles 1", #AA8800));
  drawers.add(new FillWithCircles(250, 222));
  drawers.add(new Texter(5, "Pulsating Circles", #BB7700));
  Drawer dr = new PulsatingCircles();
  dr.setDuration(30);
  drawers.add(dr);
  drawers.add(new Texter(5, "Fill With Circles 2", #CC6600));
  drawers.add(new FillWithCircles(350, 333));
  drawers.add(new Texter(10, "END", #FF0000));
}

void draw()
{
  currentDrawer = drawers.get(currentDrawerIdx);
  currentDrawer.draw();
  int time = millis() / 1000;
  if (time - currentDuration > currentDrawer.getDuration())
  {
    currentDrawerIdx++;
    currentDuration = time;
    if (currentDrawerIdx == drawers.size())
    {
      noLoop();
    }
  }
}