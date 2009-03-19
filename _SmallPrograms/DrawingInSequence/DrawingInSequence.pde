//ArrayList<Drawer> drawers = new ArrayList<Drawer>();
ArrayList drawers = new ArrayList();
Drawer currentDrawer;
int currentDrawerIdx;
int currentDuration;

interface Drawer
{
  public void Draw();
  public int GetDuration();
  public void SetDuration(int d);
}

abstract class DefaultDrawer implements Drawer
{
  protected int m_duration = 10;

  public abstract void Draw();
  //@Override
  public int GetDuration()
  {
    return m_duration;
  }
  //@Override
  public void SetDuration(int d)
  {
    m_duration = d;
  }
}

class Texter extends DefaultDrawer
{
  private String m_message;
  private int m_color;

  public Texter(int d, String m, int c)
  {
    m_duration = d;
    m_message = m;
    m_color = c;
  }

  //@Override
  public void Draw()
  {
    background(0);
    textAlign(CENTER);
    fill(m_color);
    noStroke();
    // Suppose textFont() have been called
    text(m_message, width / 2, height / 2);
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
  dr.SetDuration(30);
  drawers.add(dr);
  drawers.add(new Texter(5, "Fill With Circles 2", #CC6600));
  drawers.add(new FillWithCircles(350, 333));
  drawers.add(new Texter(10, "END", #FF0000));
}

void draw()
{
  currentDrawer = (Drawer) drawers.get(currentDrawerIdx);
  currentDrawer.Draw();
  int time = millis() / 1000;
  if (time - currentDuration > currentDrawer.GetDuration())
  {
    currentDrawerIdx++;
    currentDuration = time;
    if (currentDrawerIdx == drawers.size())
    {
      noLoop();
    }
  }
}

