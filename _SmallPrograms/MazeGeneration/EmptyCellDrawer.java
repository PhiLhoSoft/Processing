// Maze generation

/**
 * Displays a cell (do nothing).
 */
public class EmptyCellDrawer implements CellDisplayer
{
  private PApplet pa;
  private Maze maze;
  private Cell cell;

  public EmptyCellDrawer(PApplet pApplet, Cell c)
  {
    pa = pApplet;
    maze = m;
    cell = c;
  }
  @Override
  public void display()
  {
  }
}
