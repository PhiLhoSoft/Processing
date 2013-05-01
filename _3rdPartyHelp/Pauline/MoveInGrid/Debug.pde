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
