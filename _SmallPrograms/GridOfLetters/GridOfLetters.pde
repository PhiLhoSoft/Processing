String message = "Dream Land";

Grid grid;

void setup()
{
  size(800, 800);
  smooth();
  textAlign(CENTER, CENTER);
  textSize(24);
  
  grid = new Grid(message);
}

void draw()
{
  background(255);
  
  grid.draw();
}

