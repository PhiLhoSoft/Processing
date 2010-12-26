// Maze generation

/**
 * Displays a simple wall (a rectangle).
 */
public class SimpleWallDrawer implements WallDisplayer
{
  private PApplet pa;
  private Maze maze;
  private Wall wall;

  public SimpleWallDrawer(PApplet pApplet, Maze m, Wall w)
  {
    pa = pApplet;
    maze = m;
    wall = w;
  }

  @Override
  public void display()
  {
    pa.rect();
  }
}
