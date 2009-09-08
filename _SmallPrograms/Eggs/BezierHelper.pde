// [url=http://processing.org/discourse/yabb2/YaBB.pl?num=1236849784/2#2]Re: Why these bezierVertex don't make an egg[/url]

/*
 * Helper functions to visualize the vertices and control points of a Bézier curve.
 * Replace vertex() by Vertex() and bezierVertex() by BezierVertex().
 */
float BezierHelper_prevX = 0;
float BezierHelper_prevY = 0;

void Vertex(float x, float y)
{
  pushStyle();
  ellipseMode(CENTER);
  noStroke();
  // Reference point (if Bézier curve is drawn close of 0 and translated)
  fill(#FF00FF, 200);
  ellipse(0, 0, 5, 5);
  // Starting point of the curve
  fill(#FFFF00, 200);
  ellipse(x, y, 5, 5);
  popStyle();

  BezierHelper_prevX = x;
  BezierHelper_prevY = y;

  vertex(x, y);
}

void BezierVertex(float cx1, float cy1, float cx2, float cy2, float x, float y)
{
  pushStyle();
  rectMode(CORNERS);
  ellipseMode(CENTER);

  // Anchor point
  fill(#0000FF, 200);
  noStroke();
  rect(x-1, y-1, x+1, y+1);

  // First control point
  stroke(#00FF00, 220);
  strokeWeight(1);
  line(BezierHelper_prevX, BezierHelper_prevY, cx1, cy1);
  fill(#00FF00, 200);
  noStroke();
  ellipse(cx1, cy1, 3, 3);

  // Second control point
  stroke(#FF0000, 220);
  strokeWeight(1);
  line(x, y, cx2, cy2);
  fill(#FF0000, 200);
  noStroke();
  ellipse(cx2, cy2, 3, 3);
  popStyle();

  BezierHelper_prevX = x;
  BezierHelper_prevY = y;

  bezierVertex(cx1, cy1, cx2, cy2, x, y);
}
