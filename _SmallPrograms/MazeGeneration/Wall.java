// Maze generation

/** A generic simple wall of the maze. */
public class Wall
{
  /** State of wall. */
  private boolean bIsUp = true;
  /** A wall is either a top wall or a left wall. */
  private boolean bIsTop;

  public Wall(boolean bTopWall)
  {
    bIsTop = bTopWall;
  }

  public isUp()
  {
    return bIsUp;
  }

  public bringDown()
  {
    bIsUp = false;
  }

  public isTop()
  {
    return bIsTop;
  }

  @Override public String toString()
  {
    return "Wall: T=" + bIsTop + " U=" + bIsUp;
  }
}
