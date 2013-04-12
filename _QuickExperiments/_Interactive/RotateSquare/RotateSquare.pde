int cornerX;
int cornerY;
int markerSize = 10;
 
void setup() 
{
  size(500, 500);
  smooth();
  ellipseMode(CENTER);
  rectMode(CORNER);
  
  cornerX = width / 2;
  cornerY = height / 2;
}
 
void draw() 
{
  background(#EEFFEE);
  
  float rot = PI * 3 / 4 + atan2(cornerY - mouseY, cornerX - mouseX);
  float rectSize = dist(cornerY, cornerX, mouseX, mouseY) * sqrt(2) / 2;

  pushMatrix();
  
  translate(cornerX, cornerY);
  rotate(rot);
 
  stroke(0);
  fill(255);
  rect(0, 0, rectSize, rectSize);
 
  fill(#88FF88);
  ellipse(0, 0, markerSize, markerSize);
 
  popMatrix();
 
  noStroke();
  fill(#AAAAFF);
  ellipse(mouseX, mouseY, markerSize, markerSize);
}

