// https://forum.processing.org/topic/arraylist-please-help-me

// Constants of the brick wall
final int marginX = 20;
final int marginY = 20;
final int intervalH = 10;
final int intervalV = 10;
final int nbBrickH = 14;
final int nbBrickV = 7;
 
class Brick
{
  // Constants of the brick
  final int sizeX = 30;
  final int sizeY = 20;
  
  int posX;
  int posY;
  color c;
  
  public Brick(int x, int y, color bc)
  {
    posX = x;
    posY = y;
    c = bc; // brick color...
  }
  
  public void draw()
  {
    pushStyle(); // Avoid to alter settings of other classes (if any)
    rectMode(CORNER);
    noStroke();
    fill(c);
    rect(getX(), getY(), sizeX, sizeY);
    popStyle();
  }
  
  public int getX()
  {
    return marginX + (intervalH + sizeX) * (posX - 1);
  }
  public int getY()
  {
    return marginY + (intervalV + sizeY) * (posY - 1);
  }
  
  public boolean isOver()
  {
    int x = getX();
    int y = getY();
    return mouseX >= x && mouseX < x + sizeX && mouseY >= y && mouseY < y + sizeY;
  }
}
 
ArrayList<Brick> bricks = new ArrayList<Brick>();
 
void setup()
{
  size(600, 800);
  for (int i = 0; i < nbBrickH; i++)
  {
    for (int j = 0; j < nbBrickV; j++)
    {
      bricks.add(new Brick(i+1, j+1, color(55, 40 + 30 * j, 255 - 30 * j)));
    }
  }
}
 
void draw()
{
  background(255);
  for (Brick brick : bricks)
  {
    brick.draw();
  }
}
 
void mouseReleased()
{
  for (Brick brick : bricks)
  {
    if (brick.isOver())
    {
      bricks.remove(brick);
      break; // Can be over only one brick
    }
  }
}

