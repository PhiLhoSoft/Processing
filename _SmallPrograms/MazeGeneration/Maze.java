// Maze generation
import java.util.Iterator;

/** The rectangular maze. */
public class Maze implements Iterable
{
  /** The number of rows. */
  private int rowNb;
  /** The number of columns. */
  private int colNb;
  /** The cells. */
  Cell[][] cells;

  public Maze(int rn, int cn)
  {
    rowNb = rn;
    colNb = cn;
    InitMaze();
  }

  public void InitMaze()
  {
    // Create the cells, make room for the borders
    cells = new Cell[rowNb + 2][colNb + 2];
    for (int r = 0; r < rowNb+1; r++)
    {
      for (int c = 0; c < colNb+1; c++)
      {
        cells[r][c] = new Cell(r, c);
      }
    }
  }

  @Override public Iterator<Cell> iterator()
  {
    return new CellIterator();
  }

  @Override public String toString()
  {
    return "Maze (" + rowNb + ", " + colNb + ")";
  }

  /**
   * An iterator on the cells of the maze.
   */
  private class CellIterator implements Iterator<Cell>
  {
    /** Current row. */
    int cursorRow;
    /** Current column. */
    int cursorCol;
    /** True if we have reached the end of the list of cells. */
    boolean bAtEnd;

    public CellIterator()
    {
    }

    @Override public boolean hasNext()
    {
      return cursor != rowNb * colNb;
    }

    @Override public Cell next()
    {
      try
      {
        Cell next = cells[cursorRow][cursorCol++];
        if (cursorCol > colNb)
        {
          cursorCol = 0;
          cursorRow++;
          if (cursorRow > rowNb)
          {
            bAtEnd = true;
          }
        }
        return next;
	    }
      catch (IndexOutOfBoundsException e)
      {
        throw new NoSuchElementException();
	    }
    }

    @Override public void remove()
    {
      throw new UnsupportedOperationException();
    }
  }
}
