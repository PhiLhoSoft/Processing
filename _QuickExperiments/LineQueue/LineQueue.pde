int queueSize = 50;

ArrayDeque lines;

void setup()
{
  size(700, 700);
  frameRate(40);
  lines = new ArrayDeque();
}

void draw()
{
  background(255);

  PVector p = new PVector(mouseX, mouseY);
  lines.addFirst(p);
  if (lines.size() > queueSize)
  {
    lines.removeLast();
  }

  Iterator it = lines.iterator();
  PVector pp = null;
  while (it.hasNext())
  {
    PVector cp = (PVector) it.next();
    if (pp != null)
    {
      line(pp.x, pp.y, cp.x, cp.y);
    }
    pp = cp;
  }
}

