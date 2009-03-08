void setup()
{
  size(500, 500);
  smooth();
  ellipseMode(CENTER);
}

float angle;

void draw()
{
  background(55);
  angle += PI/180;

  // Save defaults
  pushMatrix();
  // Move origin
  translate(width*0.325, height*0.325);
  // Rotate
  rotate(angle);
  // And draw
  DrawFace1();
  // Restore defaults: next drawing is independent
  popMatrix();

  pushMatrix();
  translate(width*0.68, height*0.68);
  rotate(-angle);
  DrawFace2();
  popMatrix();
}

void DrawFace1()
{
  noStroke();
  fill(#FFFF00);
  // Draw around the origin
  ellipse(0, 0, width/2, height/2);
  fill(0);
  ellipse(-width/8, -height/8, width/16, height/8);
  ellipse(+width/8, -height/8, width/16, height/8);
  strokeWeight(8);
  stroke(0);
  noFill();
  arc(0, 0, width/3, height/3, PI*0.2, PI*0.8);
}

void DrawFace2()
{
  noStroke();
  fill(#FFAAEE);
  // Draw around the origin
  ellipse(0, 0, width/2, height/2);
  fill(255);
  ellipse(-width/8, -height/16, width/6, height/12);
  ellipse(+width/8, -height/16, width/6, height/12);
  fill(#8888FF);
  ellipse(-width/8, -height/16, width/12, height/12);
  ellipse(+width/8, -height/16, width/12, height/12);
  strokeWeight(8);
  stroke(#FF2200);
  noFill();
  arc(0, height/4, width/3, height/3, PI*1.3, PI*1.7);
}

