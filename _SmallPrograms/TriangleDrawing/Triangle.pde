class Triangle
{
  // There is a necessary (?) waste as triangles share their points.
  // Not a major problem. One can make a smart algorithm to reference other triangles,
  // not sure if it is worth the effort (unless having millions of triangles, perhaps).
  /** Corners definition. */
  PVector c1, c2, c3; // An array isn't useful here
  // We can add color, etc. Not now.
  
  Triangle(PVector p1, PVector p2, PVector p3)
  {
    c1 = p1;
    c2 = p2;
    c3 = p3;
  }
  
  void draw()
  {
    triangle(c1.x, c1.y, c2.x, c2.y, c3.x, c3.y);
  }
}

