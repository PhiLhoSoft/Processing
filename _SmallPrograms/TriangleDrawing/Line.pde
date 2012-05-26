class Line
{
  /** End point definitions. */
  PVector p1, p2;
  // We can add color, etc. Not now.

  Line(PVector pv1, PVector pv2)
  {
    p1 = pv1;
    p2 = pv2;
  }

  void draw()
  {
    line(p1.x, p1.y, p2.x, p2.y);
  }
}
