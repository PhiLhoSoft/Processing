PGraphics drawingSurface;
ArrayList<Stroke> strokes = new ArrayList<Stroke>();
boolean bNewLine = true;

void setup()
{
  size(360, 480);
  background(255);
  smooth();
}

void draw()
{
  if (mousePressed)
  {
    Stroke s; // Declare to the interface
    if (bNewLine)
    {
      s = new NewLineStroke(mouseX, mouseY);
    }
    else
    {
      s = new ContinuationStroke(mouseX, mouseY);
    }
    strokes.add(s);
    bNewLine = false;
  }
  else
  {
    bNewLine = true;
  }

  Stroke ps = null;
  for (Stroke s : strokes)
  {
    if (!s.startsNewLine())
    {
      line(ps.getX(), ps.getY(), s.getX(), s.getY());
    }
    // Else, don't draw a line from the previous stroke

    // This point is the starting point of the next line
    ps = s;
  }
}

interface Stroke
{
  /** @return true if we need to start a new, disconnected line from here. */
  boolean startsNewLine();
  // Getters
  int getX();
  int getY();
}

// Implementation common to both concrete classes
// By making it abstract, we cannot instantiate it, cannot be used with 'new'
abstract class BaseStroke implements Stroke
{
  // Protected: sub-classes can access them
  protected int x, y;

  //@Override -- Processing doesn't understand annotations yet
  // The above indicates this method is required by the interface we implement
  int getX() { return x; }
  //@Override
  int getY() { return y; }
  // startsNewLine() isn't here, which is legal because this class is abstract
}

// Here, we inherit BaseStroke, so we can use what it defined
class NewLineStroke extends BaseStroke
{
  public NewLineStroke(int _x, int _y)
  {
    x = _x;
    y = _y;
  }

  //@Override
  public boolean startsNewLine()
  {
    return true; // Specific to this implementation
  }
}

class ContinuationStroke extends BaseStroke
{
  public ContinuationStroke(int _x, int _y)
  {
    x = _x;
    y = _y;
  }

  //@Override
  public boolean startsNewLine()
  {
    return false; // Specific to this implementation
  }
}

