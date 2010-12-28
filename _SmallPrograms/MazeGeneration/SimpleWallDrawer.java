// Maze generation
import processing.core.PApplet;

/**
 * Displays a simple wall (a rectangle).
 */
public class SimpleWallDrawer implements WallDisplayer
{
  private PApplet pa;
  private GraphicalMaze maze;

  public SimpleWallDrawer(PApplet pApplet, GraphicalMaze m)
  {
    pa = pApplet;
    maze = m;
  }

  //@Override
  public void display(Cell cell, Wall wall)
  {
    if (wall == null)
      return; // Some cells has no wall
    if (!wall.isUp())
      return; // Don't draw a down wall

    int x = cell.getColumn() * maze.getCellSize();
    int y = cell.getRow() * maze.getCellSize();
    int w = 0;
    int h = 0;
    if (wall.getKind() == Wall.TOP)
    {
      w = maze.getCellSize();
      h = maze.getWallThickness();
    }
    else
    {
      w = maze.getWallThickness();
      h = maze.getCellSize();
    }
    pa.fill(wall.getKind() == Wall.TOP ? pa.color(255, 200, 128) : pa.color(255, 255, 255));
    pa.stroke(128, 128);
    pa.rect(x, y, w, h);
  }
}

