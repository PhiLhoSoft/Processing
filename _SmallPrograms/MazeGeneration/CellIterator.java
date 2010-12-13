// Maze generation

/**
 * An iterator on the cells of the maze.
 */
public class CellIterator implements Iterator<Cell>
{
  public CellIterator()
  {
  }

  @Override public boolean hasNext()
  {
    return true;
  }

  @Override public Cell next()
  {
    return null;
  }

  @Override public void remove()
  {
    throw new UnsupportedOperationException();
  }
}
