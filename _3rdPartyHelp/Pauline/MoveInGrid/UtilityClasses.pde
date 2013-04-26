/**
 * An offset (movement, shifting, relative position, etc.) in a grid, any grid.
 */
class Offset
{
  public int ox; // relative, negative or positive or zero, of course
  public int oy; // idem

  public Offset(int dx, int dy)
  {
    ox = dx;
    oy = dy;
  }

  Offset getOpposite()
  {
    return new Offset(-ox, -oy);
  }

  int getArrayPosition(int gridWidth)
  {
    return ox + oy * gridWidth;
  }
}

/**
 * Position in a grid of given size.
 */
abstract class Position
{
  public int x;
  public int y;

  protected int width;
  protected int height;

  public Position(int px, int py)
  {
    x = px;
    y = py;
    setDimensions();
    fixPosition();
  }

  abstract void setDimensions();
  abstract Position getPosition(int x, int y);
  abstract void fixPosition(); // Depends on wrapping / truncating strategy

  int getArrayPosition()
  {
    return x + y * width;
  }

  Position moveTo(Offset o)
  {
    return getPosition(x + o.ox, y + o.oy);
  }
}

/**
 * Position in the virtual grid.
 * Uses the ROWS and COLS constants.
 */
class VirtualPosition extends Position
{
  public VirtualPosition(int px, int py)
  {
    super(px, py);
  }
  
  void setDimensions()
  {
    width = COLS;
    height = ROWS;
  }

  void fixPosition()
  {
    // Wrapping
    if (x < 0) x += width;
    if (x >= width) x %= width;
    // Constraint
    if (y < 0) y = 0;
    if (y >= height) y = height - 1;
  }

  Position getPosition(int x, int y)
  {
    return new VirtualPosition(x, y);
  }
}

/**
 * Position in the image grid.
 * Uses the IMAGE_GRID_SIZE constant.
 */
class ImagePosition extends Position
{
  public ImagePosition(int px, int py)
  {
    super(px, py);
  }
  
  void setDimensions()
  {
    width = IMAGE_GRID_SIZE;
    height = IMAGE_GRID_SIZE;
  }

  void fixPosition()
  {
    // Wrapping for both
    if (x < 0) x += width;
    if (x >= width) x %= width;
    if (y < 0) y += height;
    if (y >= height) y %= height;
  }

  Position getPosition(int x, int y)
  {
    return new ImagePosition(x, y);
  }
}

