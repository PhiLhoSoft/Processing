/**
 * Defines fitting algorithm over a number of points.
 */
public interface Fitting
{
  /** Gives the number of points needed to apply the fitting algorithm. */
  int getNeededPointNb();
  /** Gives the number of points fitting enough to indicate the model is good. */
  int getCloseDataNb();
  /** Finds a line fitting to this set of points, according to this fitting algorithm. */
  Line estimateModel(List<Point> points);
  /** Estimate the error between the given model and the given point. */
  float estimateError(Point point, Line model);
}

// Can be global because we are in a PDE file, so all classes are actually inner classes!
/**
 * A simple implementation, just taking the line going through two points.
 */
public class SimpleFitting implements Fitting
{
  public int getNeededPointNb() { return 2; }
  public int getCloseDataNb() { return 5; }

  public Line estimateModel(List<Point> points)
  {
    assert points.size() == getNeededPointNb() : "You should provide the number of points required by the fitting algorithm";
    Point p1 = points.get(0);
    Point p2 = points.get(1);
    return new Line(p1, p2);
  }

  public float estimateError(Point point, Line model)
  {
    // Projection of the point to the line following the vertical axis
    float y = model.a * point.x + model.b;
    return abs(point.y - y) / sqrt(1 + model.a * model.a);
  }
}
