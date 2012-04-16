// https://forum.processing.org/topic/rotation-question-beginner

int shapeW = 150;
int shapeH = 100;
void setup() 
{
  size (600, 600);
  smooth();
  noStroke();
  ellipseMode(CENTER);
}

float angle;
void draw () 
{
  background (255);
  
  // Move the origin to the point where we want the rotation to occur
  translate(width / 3, height / 3);
  // Do the rotation
  rotate(radians(angle++));
  // A translation to change the rotation point in the shape
  float rotX = -shapeW / 3;
  float rotY = -shapeH / 3;
  translate(-rotX, -rotY);
  
  fill(#00AA00);
  // x, y always 0 since translations do the job of placing
  rect(0, 0, shapeW, shapeH);
  
  // Mark the center point
  fill(#FF0000);
  ellipse(rotX, rotY, 8, 8);
  
  // Mark the bottom-rigth corner
  fill(#0000FF);
  ellipse(shapeW-1, shapeH-1, 8, 8);
}

void mousePressed()
{
  noLoop();
}

