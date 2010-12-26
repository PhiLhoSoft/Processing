// Maze generation

/**
 * A generic simple cell of the maze.
 * <p>
 * A cell can be on the border of the maze (it isn't drawn, one of its wall can be drawn),
 * or in the maze itself.<br>
 * A border cell has 0 (on top and left borders) or 1 wall.<br>
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
  /** Left wall. */
  private Wall leftWall;

  public Cell(Maze m, int r, int c)
  {
    row = r;
    column = c;
    if (r != 0 && c != 0 && c != m.getColNb())
    {
      topWall = new Wall(true);
    }
    if (c != 0 && r != 0 && r != m.getRowNb())
    {
      leftWall = new Wall(false);
    }
  }

  public boolean isCellBorder()
  {
    return topWall != null && leftWall != null;
  }

  @Override public String toString()
  {
    return "Cell (" + r + ", " + c + ") [" + topWall + "; " + leftWall + "]";
  }
}
