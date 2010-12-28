// Maze generation
import java.util.Iterator;
import java.util.NoSuchElementException;

/** The rectangular maze. */
public class Maze implements Iterable<Cell>
{
  /** The number of visible columns. */
  private int colNb;
  /** The number of visible rows. */
  private int rowNb;
  /** The cells. */
  Cell[] cells;

  public Maze(int cn, int rn)
  {
    colNb = cn;
    rowNb = rn;
    InitMaze();
  }

  public void InitMaze()
  {
    // Create the cells, make room for the borders
    cells = new Cell[(rowNb + 2) * (colNb + 2)];
    for (int r = 0; r <= rowNb+1; r++)
    {
      for (int c = 0; c <= colNb+1; c++)
      {
        cells[r * (colNb + 2) + c] = new Cell(this, r, c);
      }
    }
  }

  public int getRowNb() { return rowNb; }
  public int getColNb() { return colNb; }

// Processing seems to use a Java 1.5 compiler, not accepting override annotation for interface methods
//  @Override 
  public Iterator<Cell> iterator()
  {
    return new CellIterator();
  }

  @Override 
  public String toString()
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

//    @Override 
    public boolean hasNext()
    {
      return !bAtEnd;
    }

//    @Override 
    public Cell next() throws NoSuchElementException
    {
      try
      {
        Cell next = cells[cursorRow * (colNb + 2) + cursorCol++];
        if (cursorCol > colNb + 1)
        {
          cursorCol = 0;
          cursorRow++;
          if (cursorRow > rowNb + 1)
          {
            bAtEnd = true;
          }
        }
        return next;
      }
      catch (ArrayIndexOutOfBoundsException e)
      {
        throw new NoSuchElementException();
      }
    }

//    @Override 
    public void remove()
    {
      throw new UnsupportedOperationException();
    }
  }
}
