ArrayList ellipseList;
Ellipse head;
int SEGMENT_SIZE = 10;
int dir;
int prevPosX, prevPosY;
PFont f;
String mesaj="";
boolean ok=false;
Ellipse food;
void setup()
{
  size(400, 400);
  f=loadFont("CurlzMT-22.vlw");
  textFont(f);
  ellipseList = new ArrayList();
  head = new Ellipse(width/2, height/2);
  ellipseList.add(head);
  dir=2;
  // Start with head and small body
  ellipseList.add(new Ellipse(width/2 - 2 * SEGMENT_SIZE, height/2));
  addFood();
  mesaj="Press mouse to start the game!\nUse arrows to move the snake.";
  frameRate(10);
}
void draw()
{
  fill(0);
  background(#FFCCCC);
  text(mesaj,width/2-100,height/2);
  if(ok)
  {
    food.createEllipse();
    tryToEatAndMove(ellipseList.size());
  }
}

boolean tryToEatAndMove(int p)
{
  int x = head.getX();
  int y = head.getY();
  if (dist(x, y, food.getX(), food.getY()) < 6)
  {
    // Move the body
    move();
    // Get last two segments
    Ellipse e1 = (Ellipse) ellipseList.get(ellipseList.size() - 1);
    Ellipse e2 = (Ellipse) ellipseList.get(ellipseList.size() - 2);
    int dX = e1.getX() - e2.getX();
    int dY = e1.getY() - e2.getY();
    // Add another segment at the end
    ellipseList.add(new Ellipse(e1.getX() + dX, e1.getY() + dY));
    // Add food to replace the one being eat
    addFood();
    println("Length: " + ellipseList.size());
    return true;
  }
  // Not on food, just move
  move();
  return false;
}
void addFood()
{
  food = new Ellipse(int(random(10, 390)), int(random(10, 390)),6);
}
void move()
{
  prevPosX = head.getX();
  prevPosY = head.getY();
  switch(dir)
  {
    case 0:
      head.moveUp();
      break;
    case 1:
      head.moveDown();
      break;
    case 2:
      head.moveRight();
      break;
    case 3:
      head.moveLeft();
      break;
  }
  followHead();
}

void followHead()
{
  fill(0);
  head.createEllipse();
  fill(255);
  for (int i = 1; i < ellipseList.size(); i++)
  {
     Ellipse e = (Ellipse) ellipseList.get(i);
     int ppX = e.getX();
     int ppY = e.getY();
     // Move the segment where the previous one was
     e.x = prevPosX; e.y = prevPosY; // Need Ellipse.setX and setY...
     prevPosX = ppX;
     prevPosY = ppY;
     e.createEllipse();
  }
}

void mousePressed()
{
  mesaj="";
  ok=true;
  dir=2;
}

void keyPressed()
{
  if(key==CODED)
  {
    if(keyCode==UP)
    {
      dir=0;
    }
    if(keyCode==DOWN)
    {
      dir=1;
    }
    if(keyCode==RIGHT)
    {
      dir=2;
    }
    if(keyCode==LEFT)
    {
      dir=3;
    }
  }
}

