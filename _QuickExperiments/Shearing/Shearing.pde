final int MARGIN = 100;
final int WIDTH = 200;

void setup()
{
  size(500, 500);
}

void draw()
{
  background(255); // First, clear the screen
  
  // Visual parameters
  fill(#000088); // Dark blue
  stroke(#000055);
  strokeWeight(3);
  
  float amount = (float) mouseX / width; // Using mouse position as parameter
  float offset = WIDTH * amount;
  
  beginShape();
  // Bottom left
  vertex(MARGIN, height - MARGIN);
  // Top left
  vertex(MARGIN + offset, MARGIN);
  // Top right
  vertex(MARGIN + offset + WIDTH, MARGIN);
  // Bottom right
  vertex(MARGIN + WIDTH, height - MARGIN);
  endShape(CLOSE);
}

