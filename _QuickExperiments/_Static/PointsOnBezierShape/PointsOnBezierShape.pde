void setup() 
{
  size(800, 800);

  noFill();
  beginShape();
  vertex(61, 189);
  bezierVertex(61, 189, 196, 63, 237, 162);
  bezierVertex(278, 261, 287, 272, 340, 246);
  endShape();
  fill(#FF0000); 
  ellipse(61, 189, 10, 10);
  ellipse(237, 162, 10, 10);
  ellipse(340, 246, 10, 10);
  
  int steps = 10;
  fill(#00FF88);
  for (int i = 0; i <= steps; i++) 
  {
    float t = i / float(steps);
    float x = bezierPoint(61, 61, 196, 237, t);
    float y = bezierPoint(189, 189, 63, 162, t);
    ellipse(x, y, 5, 5);
  }
  
  fill(#0088FF);
  for (int i = 0; i <= steps; i++) 
  {
    float t = i / float(steps);
    float x = bezierPoint(237, 278, 287, 340, t);
    float y = bezierPoint(162, 261, 272, 246, t);
    ellipse(x, y, 5, 5);
  }
}

