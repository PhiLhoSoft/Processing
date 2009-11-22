import proxml.*;

XMLInOut xmlIO;
ArrayList balls = new ArrayList();

void setup()
{
  size(500,500);

  xmlIO = new XMLInOut(this);
  xmlIO.loadElement("Shapes.xml");
  noLoop();
}

void xmlEvent(proxml.XMLElement element)
{
  element.printElementTree();
  proxml.XMLElement[] ballElts = element.getChildren();

  for (int i = 0; i < ballElts.length;i++)
  {
    proxml.XMLElement ballElt = ballElts[i];
    proxml.XMLElement param = ballElt.getChild(0);
    println(param.getName());
    if (!param.getName().equals("dimensions"))
      continue; // Ignore unknown child
    int bw = param.getIntAttribute("width");
    int bh = param.getIntAttribute("height");
    println("Dim " + bw + " " + bh);
    Ball ball = new Ball(bw, bh);
    balls.add(ball);
  }
}

void draw()
{
  background(255);
  println(balls.size());
  for (int i = 0; i < balls.size(); i++)
  {
    Ball b = (Ball) balls.get(i);
    b.display();
  }
}

class Ball
{
  int ballWidth;
  int ballHeight;
  int x, y;
  color c;
  
  Ball(int bw, int bh)
  {
    ballWidth = bw;
    ballHeight = bh;
    x = int(random(bw, width - bw));
    y = int(random(bh, width - bh));
    c = color(random(50, 200), random(100, 200), random(200, 255));
  }
  
  void display()
  {
    fill(c);
    noStroke();
    ellipse(x, y, ballWidth, ballHeight);
  }
}

