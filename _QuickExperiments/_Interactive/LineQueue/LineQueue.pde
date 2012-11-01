int queueSize = -1;

ArrayDeque<PVector> shapes;

void setup()
{
  size(700, 700);
  frameRate(40);
  shapes = new ArrayDeque<PVector>();
  noFill();
  ellipseMode(CENTER);
  
  noLoop();
  PFont f = createFont("Verdana", 16);
  textFont(f);
}

void draw()
{
  background(128, 128, 255);
  if (queueSize < 0)
  {
    text("Type a number between 1 and 9", 10, 20);
    return;
  }

  if (mouseX != pmouseX || mouseY != pmouseY)
  {
    PVector p = new PVector(mouseX, mouseY);
    shapes.addFirst(p);
  }
  if (shapes.size() > queueSize)
  {
    shapes.removeLast();
  }

  PVector pp = null;
  for (PVector cp : shapes)
  {
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

void keyReleased()
{
  int number = key - '0';
  if (number > 0)
  {
    println(number);
    queueSize = 10 * number;
    loop();
  }
}

