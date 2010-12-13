// Maze generation

/**
 * A generic simple cell of the maze.
 *
 * A cell can be on the border of the maze (it isn't drawn),
 * or in the maze itself.
 * A border cell has 0 (on top and left borders) or 1 wall.
 * A maze cell has two walls: top and left.
 */
public class Cell
{
  /** Coordinates of the cell. Row. 0 = top row. verticalMazeDim+1 = bottom row. */
  private int row;
  /** Coordinates of the cell. Column. 0 = left column. horizontalMazeDim+1 = right row. */
  private int column;
  /** Top wall. */
  private Wall topWall;
  private Wall leftWall;

  public Cell(int r, int c)
  {
    row = r;
    column = c;
    if (r != 0)
    {
      topWall = new Wall(true);
    }
    if (c != 0)
    {
      leftWall = new Wall(false);
    }
  }

  @Override public String toString()
  {
    return "Cell (" + r + ", " + c + ") [" + topWall + "; " + leftWall + "]";
  }
}
