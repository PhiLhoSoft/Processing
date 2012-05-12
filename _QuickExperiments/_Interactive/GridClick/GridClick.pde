int MARGIN = 20;
int CELL_SIZE = 50;
int CELL_NB = 8;

// To display click position
int posX, posY;
String info = "";

void setup()
{
  size(500, 500);
}

void draw()
{
  background(255);
  fill(#0000AA);
  for (int i = 0; i <= CELL_NB; i++)
  {
    line(MARGIN + i * CELL_SIZE, MARGIN, MARGIN + i * CELL_SIZE, MARGIN + CELL_NB * CELL_SIZE);
    line(MARGIN, MARGIN + i * CELL_SIZE, MARGIN + CELL_NB * CELL_SIZE, MARGIN + i * CELL_SIZE);
  }
  fill(#FF0000);
  text(info, posX, posY);
}

void mousePressed()
{
  int cellX = (mouseX - MARGIN) / CELL_SIZE;
  int cellY = (mouseY - MARGIN) / CELL_SIZE;
  posX = MARGIN + cellX * CELL_SIZE + CELL_SIZE / 2;
  posY = MARGIN + cellY * CELL_SIZE + CELL_SIZE / 2;
  info = cellX + " " + cellY;
}

