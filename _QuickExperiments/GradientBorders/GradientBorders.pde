final int MARGIN = 25;

void setup()
{
  size(600, 400);
  smooth();
    
  posX = width / 2;
  posY = height / 2;
}

float posX, posY;
void draw()
{
  background(255);
  
  color c = #2222FF;
  int w = width - 1;
  int h = height - 1;
  strokeWeight(1);
  for (int i = 0; i < MARGIN; i++)
  {
    stroke(c, i * 100.0 / MARGIN);
    line(i, i + 1, i, h - i - 1);
    line(w - i, i + 1, w - i, h - i - 1);
    line(i, i, w - i, i);
    line(i, h - i, w - i, h - i);
  }
  fill(c, 100);
  noStroke();
  rect(MARGIN, MARGIN, w - 2 * MARGIN + 1, h - 2 * MARGIN + 1);
  
  stroke(#EEEE00);
  strokeWeight(8);
  fill(#AAFF44);
  posX += random(-1, 1);
  posY += random(-1, 1);
  ellipse(posX, posY, height / 3, height / 3);

  noFill(); stroke(#FFFF00); strokeWeight(1); rect(0, 0, w, h);
}

