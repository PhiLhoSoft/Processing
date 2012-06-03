// A grid of cells
class Grid
{
  // The cells
  Cell[][] cells;
  // The number of cells per side
  int size; // A bit redundant, but shorter than cells.length
  // The size of a cell, in pixels
  int cellSize;

  // Constructor with the message to display in the first column,
  // determining the number of cells.
  Grid(String message)
  {
    size = message.length();
    // Build the arrau of cells
    cells = new Cell[size][size];
    
    cellSize = (width - 2 * MARGIN) / size;
    
    // Build the rows
    for (int row = 0; row < size; row++)
    {
      // First column is filled with chars from the message. It is read only.
      cells[row][0] = new Cell(message.charAt(row), cellSize, true); // true for read only
      // Build the columns for this row
      for (int col = 1; col < size; col++) // Starts at 1!
      {
        // A random letter from the alphabet, or a space
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
        cells[row][col] = new Cell(c, cellSize);
      }
    }
  }

  void draw()
  {
    // Take in account the margin
    int x = MARGIN;
    int y = MARGIN;
    // Draw each row
    for (int row = 0; row < size; row++)
    {
      // For each column
      for (int col = 0; col < size; col++) // Starts at 1!
      {
        Cell c = cells[row][col];
        // And draw the cell there
        c.draw(x, y);
        // Move to the next column
        x += cellSize;
      }
      // Move one cell down
      y += cellSize;
      // And reset the column position
      x = MARGIN;
    }
  }
  
  // Return the cell at the given pixel position
  Cell getCell(int posX, int posY)
  {
    if (posX < MARGIN || posX > width - MARGIN ||
        posY < MARGIN || posY > height - MARGIN)
    {
      // Position isn't on a cell
      return null;
    }
    
    int col = getPos(posX);
    int row = getPos(posY);
    
    if (col >= size || row >= size)
      return null; // No cell there!
      
    return cells[row][col];
  }
  
  int getPos(int coord)
  {
    return (coord - MARGIN) / cellSize;
  }
  
  int getCoord(int pos)
  {
    return MARGIN + pos * cellSize;
  }
}

