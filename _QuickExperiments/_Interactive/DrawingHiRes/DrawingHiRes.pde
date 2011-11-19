ArrayList<Stroke> strokes = new ArrayList<Stroke>();
boolean bNewLine = true;
final int scaleFactor = 4;

void setup()
{
  size(360, 480);
  smooth();
}

void draw()
{
  background(255);
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

  drawOn(g);
}

void drawOn(PGraphics surface)
{
  Stroke ps = null;
  for (Stroke s : strokes)
  {
    if (!s.startsNewLine())
    {
      surface.line(ps.getX(), ps.getY(), s.getX(), s.getY());
    }
    // Else, don't draw a line from the previous stroke

    // This point is the starting point of the next line
    ps = s;
  }
}

void keyPressed()
{
  if (key == 's')
  {
    PGraphics drawingSurface = createGraphics(width * scaleFactor, height * scaleFactor, JAVA2D);
  }
  else if (key == 'u') // undo
  {
    for (int i = strokes.size() - 1; i >= 0; i--)
    {
      Stroke s = strokes.get(i);
      strokes.remove(i);
      if (s.startsNewLine())
        break; // Found the start of the current line, we don't delete further
    }
  }
}

// The interface defines what methods MUST be implemented by the classes using it
// If we define an array list storing Stroke, we can put in it anything implementing this interface,
// and be confident we can use these methods on these objects.
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

