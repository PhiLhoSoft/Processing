float R;
int prevMouseX = -1, prevMouseY = -1;

void setup()
{
  size(800, 800);
  R = 0xFFFFFF / sqrt(sq(width) + sq(height));
  background(#ABCDEF);
  strokeWeight(4);
}

void draw()
{
}

void mousePressed()
{
  float len = sqrt(sq(prevMouseX - mouseX) + sq(prevMouseY - mouseY));
  color col = 0xFF000000 + int(len * R); // Alpha = opaque
  print(hex(col) + " ");
  stroke(col);
  if (prevMouseX >= 0)
    line(prevMouseX, prevMouseY, mouseX, mouseY);
  else
    line(mouseX, mouseY, mouseX, mouseY);
  prevMouseX = mouseX; prevMouseY = mouseY;
}
    
