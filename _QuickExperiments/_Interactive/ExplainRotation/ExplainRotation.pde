void setup() 
{
  size(800, 800);
  smooth();
}

void draw() 
{
  background(0);

  // Not necessary if no other transformation is done in draw(), but good practice anyway
  pushMatrix();
  
  // Move to rotation center
  translate(width / 2, height / 2);
  // Draw rotation point / center
  fill(255);
  noStroke();
  ellipse(0, 0, width / 100, height / 100);
  // Draw rotation ellipse
  noFill();
  stroke(255);
  ellipse(0, 0, 2 * width / 3, 2 * height / 3);
  
  // Do the rotation
  rotate(map(mouseX, 0, width, 0, TWO_PI));
  // Move to peripheral point, along the rotated X axis
  translate(2 * width / 6, 0);
  // Draw the rotated point
  fill(255);
  noStroke();
  ellipse(0, 0, width / 50, height / 50);
  
  popMatrix();
}

