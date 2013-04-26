class Position
{
  public int x;
  public int y;
  
  public Position(int px, int py)
  {
    x = px;
    y = py;
    fixPosition();
  }
  
  int getArrayPosition()
  {
    return x + y * COLS;
  }
  
  void fixPosition()
  {
    if (x < 0) x += COLS;
    if (x >= COLS) x %= COLS;
    if (y < 0) y = 0;
    if (y >= ROWS) y = ROWS - 1;
  }
}


class Offset
{
  public int ox; // -1, 0, or +1
  public int oy; // -1, 0, or +1
  
  public Offset(int dx, int dy)
  {
    ox = dx;
    oy = dy;
  }
  
  int getArrayOffset()
  {
    return ox + oy * COLS;
  }
  
  Position getNewPosition(Position pos)
  {
    return new Position(pos.x + ox, pos.y + oy);
  }
}

