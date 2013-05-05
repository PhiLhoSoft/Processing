class Info
{
  Position previous;
  Position current;
  int index;
}
Info[] debugInfo = new Info[IMAGE_GRID_SIZE * IMAGE_GRID_SIZE];

void drawDebug(float angle, int sector, int alpha)
{
  pushMatrix();
  strokeWeight(4);
  translate(width / 2, height / 2);
  rotate(PI / 8);
  for (int i = 0; i < 8; i++)
  {
    line(0, 0, 800, 0);
    rotate(PI / 4);
  }
  popMatrix();
  int moveDist = width / 4;
  noFill();
  ellipse(width / 2, height / 2, moveDist * 2, moveDist * 2);
  
  showGrid();

  fill(#00FF00);
  textSize(20);
  text("Angle: " + degrees(angle), 10, 30);
  text("Sector: " + sector, 10, 60);
  text("Alpha: " + alpha, 10, 90);
  text("Position: " + currentPosition.x + ", " + currentPosition.y + " - " + currentPosition.getArrayIndex(), 10, 120);
}

void drawInfo()
{
  fill(#00FF00);
  textSize(18);
  for (int x = 0; x < IMAGE_GRID_SIZE; x++)
  {
    for (int y = 0; y < IMAGE_GRID_SIZE; y++)
    {
      int idx = x + y * IMAGE_GRID_SIZE;
      text(debugInfo[idx].previous.toString(), x * width / IMAGE_GRID_SIZE + 10, y * height / IMAGE_GRID_SIZE + 20);
      text(debugInfo[idx].current.toString(),  x * width / IMAGE_GRID_SIZE + 10, y * height / IMAGE_GRID_SIZE + 40);
      text(idx + " " + debugInfo[idx].index,   x * width / IMAGE_GRID_SIZE + 10, y * height / IMAGE_GRID_SIZE + 60);
    }
  }
}

void shiftInfo(Offset move)
{
  Offset shift = move.getOpposite();

  // Make a new array, it avoids to think about copy order...
  Info[] shiftedInfo = new Info[IMAGE_GRID_SIZE * IMAGE_GRID_SIZE];
  for (int y = 0; y < IMAGE_GRID_SIZE; y++)
  {
    for (int x = 0; x < IMAGE_GRID_SIZE; x++)
    {
      Position pos = new ImagePosition(x, y).moveTo(move);
      int idx = pos.getArrayIndex();
      debugInfo[idx].previous = debugInfo[idx].current;
      debugInfo[idx].current = debugInfo[idx].current.moveTo(move);
    }
  }
  for (int y = 0; y < IMAGE_GRID_SIZE; y++)
  {
    for (int x = 0; x < IMAGE_GRID_SIZE; x++)
    {
      Position pos = new ImagePosition(x, y).moveTo(move);
      shiftedInfo[x + y * IMAGE_GRID_SIZE] = debugInfo[pos.getArrayIndex()];
    }
  }
  debugInfo = shiftedInfo;
}

void showGrid()
{
  stroke(#55AA55);
  strokeWeight(2);
  for (int x = 1; x < IMAGE_GRID_SIZE; x++)
  {
    int pos = x * (width / IMAGE_GRID_SIZE);
    line(pos, 0, pos, height);
  }
  for (int y = 1; y < IMAGE_GRID_SIZE; y++)
  {
    int pos = y * (height / IMAGE_GRID_SIZE);
    line(0, pos, width, pos);
  }
  for (int sector = 0; sector < sectorToGridIndex.length; sector++)
  {
    int alpha = computeAlpha(sector);
    
    // Yeah, same computing than in the above! That's debug
    Offset offset = sectorToOffset[sector];
    Position pos = centerPosition.moveTo(offset);
    // Divide screen in IMAGE_GRID_SIZE cells, compute the center of the cell at pos
    int cellWidth = width / IMAGE_GRID_SIZE;
    int cellWHeight = height / IMAGE_GRID_SIZE;
    int posX = pos.x * cellWidth - cellWidth / 2;
    int posY = pos.y * cellWHeight - cellWHeight / 2;

    text(alpha, posX, posY);
  }
}

