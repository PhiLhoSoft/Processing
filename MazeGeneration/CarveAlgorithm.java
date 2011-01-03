// Maze generation

/**
 * Defines the interface for a class carving a maze, one cell/wall at a time.
 */
public interface CarveAlgorithm
{
  /** One step in the carving process. Returns false if it is the last step. */
  boolean carveMaze();
}
