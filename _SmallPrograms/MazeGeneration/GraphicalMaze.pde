// Maze generation

/** A graphical representation of a maze. */
class GraphicalMaze
{
  /** The maze model. */
  Maze maze;
  /** Base cell size, in pixels. */
  int cellSize = 10;
  /** Wall thickness, in pixels. */
  int wallThickness = 1;

  public GraphicalMaze(int rn, int cn)
  {
    maze = new Maze(rn, cn);
  }

  public void setCellSize(int cs)
  {
    cellSize = cs;
  }
  public int getCellSize()
  {
    return cellSize;
  }

  public void setWallThickness(int wt)
  {
    wallThickness = wt;
  }
  public int getWallThickness()
  {
    return wallThickness;
  }

  public void display()
  {
  }
}
