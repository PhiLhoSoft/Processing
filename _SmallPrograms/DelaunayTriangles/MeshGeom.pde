class MeshPoint
{
  float x, y;
  float linkCount;

  // Radius
  int r = 7;
  // Point color
  color c = #FF0000;

  MeshPoint(float px, float py)
  {
    x = px;
    y = py;
  }

  float GetX() { return x; }
  float GetY() { return y; }

  void Display()
  {
    fill(c);
    noStroke();
    ellipse(x, y, r, r);
  }
}

class Triangle
{
  float x1, y1;
  float x2, y2;
  float x3, y3;
  color c  = #888888;

  Triangle()
  {
  }
  Triangle(float px1, float py1, float px2, float py2, float px3, float py3)
  {
    x1 = px1;
    y1 = py1;
    x2 = px2;
    y2 = py2;
    x3 = px3;
    y3 = py3;
  }
  String toString()
  {
    Formatter formatter = new Formatter(Locale.US);
    formatter.format("%.1f %.1f, %.1f %.1f, %.1f %.1f", x1, y1, x2, y2, x3, y3);
    return formatter.out().toString();
  }

  void SetPoint(int idx, float x, float y)
  {
    switch (idx)
    {
    case 0:
      x1 = x; y1 = y;
      break;
    case 1:
      x2 = x; y2 = y;
      break;
    case 2:
      x3 = x; y3 = y;
      break;
    default:  // Ignore...
      println("Got point " + idx + " of triangle!");
    }
  }

  void SetColor(color tc)
  {
    c = tc;
  }

  void Display()
  {
    fill(c);
    noStroke();
    triangle(x1, y1, x2, y2, x3, y3);
//    if (frameCount % 20 == 0) println(this);
  }
  void Display(color co)
  {
    fill(co);
    noStroke();
    triangle(x1, y1, x2, y2, x3, y3);
  }
}

