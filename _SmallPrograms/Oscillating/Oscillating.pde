float x1, x2, ym;
float p1x, p2x, p3x;
float p1y, p2y, p3y;
float flatness = 50;

float angle;

void setup()
{
  size(800, 400);
  x1 = 20; x2 = width - 20;
  ym = height/2;
  
  // Just keep fixed x pos for now
  // we might do variations later
  p1x = lerp(x1, x2, 0.25);
  p2x = lerp(x1, x2, 0.50);
  p3x = lerp(x1, x2, 0.75);
}

void draw()
{
  background(#CCFFEE);
  fill(#FF9955);
  ellipse(x1, ym, 10, 10);
  ellipse(x2, ym, 10, 10);
  stroke(#8899FF);
//  line(x1, ym, x2, ym);

  angle += 0.1;
  p1y = height/2 + (height/2- 11) * sin(angle);
  // Central point don't move much
  p2y = height/2 * (1.0 - 0.33 * cos(angle * 0.11));
  p3y = height/2 + (height/2 - 17) * cos(angle);

  noFill();
  beginShape();
  vertex(x1, ym);
  bezierVertex(x1 + flatness, ym,
      p1x - flatness, p1y,
      p1x, p1y);
  bezierVertex(p1x + flatness, p1y,
      p2x - flatness, p2y,
      p2x, p2y);
  bezierVertex(p2x + flatness, p2y,
      p3x - flatness, p3y,
      p3x, p3y);
  bezierVertex(p3x + flatness, p3y,
      x2 - flatness, ym,
      x2, ym);
  endShape();
}

