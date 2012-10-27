/**
 * Drawing actions are kept here to keep Point and Line independent of the rendering system.
 */
class Drawer
{
  final int MARGIN = 20;
  final int POINT_SIZE = 10;
  final int LINE_SIZE = 3;

  Point makePoint()
  {
    return new Point(random(MARGIN, width - MARGIN), random(MARGIN, height - MARGIN));
  }

  void drawPoint(Point point, color pc)
  {
    noStroke();
    fill(pc);
    ellipse(point.x, point.y, POINT_SIZE, POINT_SIZE);
  }

  void drawLine(Line line, color pc)
  {
    stroke(pc);
    strokeWeight(LINE_SIZE);
//    println(line);
    if (line.isHorizontal())
    {
      float y = line.getY(0);
      line(0, y, width, y);
    }
    else if (line.isVertical())
    {
      float x = line.getX(0);
      line(x, 0, x, height);
    }
    else
    {
      float x1 = line.getX(0);
      float y1 = line.getY(x1);
      float x2 = line.getX(height);
      float y2 = line.getY(x2);
//      println(x1 + " " + y1 + " " + x2 + " " + y2);
      line(x1, y1, x2, y2);
    }
  }
}
