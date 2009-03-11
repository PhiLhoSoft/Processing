int queueSize = 50;

ArrayDeque lines;

void setup()
{
  size(700, 700);
  frameRate(40);
  lines = new ArrayDeque();
  noFill();
  ellipseMode(CENTER);
}

void draw()
{
  background(255);

  if (mouseX != pmouseX || mouseY != pmouseY)
  {
    PVector p = new PVector(mouseX, mouseY);
    lines.addFirst(p);
  }
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
      stroke(14, 7, 42);
      strokeWeight(1);
      line(pp.x, pp.y, cp.x, cp.y);
      stroke(214, 7, 142);
      strokeWeight(5);
      ellipse(cp.x, cp.y, 21, 21); 
    }
    pp = cp;
  }
}

