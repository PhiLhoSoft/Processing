class Grid
{
  Cell[][] cells;
  int size; // A bit redundant, but shorter than cells.length

  Grid(String message)
  {
    size = message.length();
    cells = new Cell[size][size];
    for (int row = 0; row < size; row++)
    {
      cells[row][0] = new Cell(message.charAt(row), true); // true for read only
      for (int col = 1; col < size; col++) // Starts at 1!
      {
        int l = int(random(27));
        char c;
        if (l == 26)
        {
          c = ' '; // Some spaces in the grid
        }
        else
        {
          c = (char) ('A' + l);
        }
        cells[row][col] = new Cell(c);
      }
    }
  }

  void draw()
  {
    for (int row = 0; row < size; row++)
    {
      for (int col = 0; col < size; col++) // Starts at 1!
      {
        Cell c = cells[row][col];
        c.draw();
      }
    }
  }
}

