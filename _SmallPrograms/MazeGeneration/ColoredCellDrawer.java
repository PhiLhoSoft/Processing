// Maze generation
import processing.core.PApplet;

/**
 * Displays a cell (do nothing).
 */
public class ColoredCellDrawer implements CellDisplayer
{
  private PApplet pa;
  private GraphicalMaze maze;
  /** Responsible of displaying a wall. */
  private WallDisplayer wallDisplayer;

  public ColoredCellDrawer(PApplet pApplet, GraphicalMaze m)
  {
    pa = pApplet;
    maze = m;
  }

  public void setWallDisplayer(WallDisplayer wd)
  {
    wallDisplayer = wd;
  }

  //@Override
  public void display(Cell cell)
  {
    int x = cell.getColumn() * maze.getCellSize();
    int y = cell.getRow() * maze.getCellSize();
    int s = maze.getCellSize();
    pa.fill(cell.isCellBorder() ? pa.color(255, 100, 100) : pa.color(100, 200, 255));
    pa.noStroke();
    pa.rect(x, y, s, s);

    wallDisplayer.display(cell, cell.getTopWall());
    wallDisplayer.display(cell, cell.getLeftWall());
  }
}
