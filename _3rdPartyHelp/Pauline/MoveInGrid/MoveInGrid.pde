// We have two grids: a big one, named "virtual grid", where we move;
// and a smaller one, "image grid", where the current images to display are loaded.

// Dimensions of the virtual grid
final int ROWS = 16;
final int COLS = 144;
// Dimension (one, it is a square) of the image grid
final int IMAGE_GRID_SIZE = 5;
// The image grid
PImage[] images = new PImage[IMAGE_GRID_SIZE * IMAGE_GRID_SIZE];

/*
Image grid:
 0  1  2  3  4
 5  6  7  8  9
10 11 12 13 14
15 16 17 18 19
20 21 22 23 24

Sectors (direction of movement):
     2
  3     1
4    .    0
  5     7
     6
*/
final int[] sectorToGridIndex = { 13, 8, 7, 6, 11, 16, 17, 18, 12 };
final int centerIndex = 12;
final ImagePosition centerPosition = new ImagePosition((IMAGE_GRID_SIZE + 1) / 2, (IMAGE_GRID_SIZE + 1) / 2);
final int[][] sectorToIndexesToUpdate =
{
              { 4, 9, 14, 19, 24 },
  { 0, 1, 2, 3, 4, 9, 14, 19, 24 },
  { 0, 1, 2, 3, 4 },
  { 0, 1, 2, 3, 4, 5, 10, 15, 20  },
              { 0, 5, 10, 15, 20 },
              { 0, 5, 10, 15, 20, 21, 22, 23, 24 },
                            { 20, 21, 22, 23, 24 },
              { 4, 9, 14, 19, 20, 21, 22, 23, 24 },
};
final Offset[] gridIndexToOffset =
{
  new Offset(-2, -2), new Offset(-1, -2), new Offset( 0, -2), new Offset(+1, -2), new Offset(+2, -2),
  new Offset(-2, -1), new Offset(-1, -1), new Offset( 0, -1), new Offset(+1, -1), new Offset(+2, -1),
  new Offset(-2,  0), new Offset(-1,  0), new Offset( 0,  0), new Offset(+1,  0), new Offset(+2,  0),
  new Offset(-2, +1), new Offset(-1, +1), new Offset( 0, +1), new Offset(+1, +1), new Offset(+2, +1),
  new Offset(-2, +2), new Offset(-1, +2), new Offset( 0, +2), new Offset(+1, +2), new Offset(+2, +2),
};

final Offset[] sectorToOffset =
{
  new Offset(+1,  0),
  new Offset(+1, -1),
  new Offset( 0, -1),
  new Offset(-1, -1),
  new Offset(-1,  0),
  new Offset(-1, +1),
  new Offset( 0, +1),
  new Offset(+1, +1),
  
  new Offset( 0,  0),
};

Position currentPosition = new VirtualPosition(COLS / 2, ROWS / 2);

void setup()
{
  size(1024, 768);
  textSize(24);

println("Load images");
  for (int i = 0; i < images.length; i++)
  {
    Position pos = currentPosition.moveTo(gridIndexToOffset[i]);
    int idx = pos.getArrayIndex();
    images[i] = getImage(idx);

    debugInfo[i] = new Info();
    debugInfo[i].previous = debugInfo[i].current = pos;
    debugInfo[i].index = idx;
  }
println("Images loaded.");
}

void draw()
{
  float angle = getAngle();
  int sectorD = findSector(angle);

  for (int sector = 0; sector < sectorToGridIndex.length; sector++)
  {
    int alpha = computeAlpha(sector);
    tint(255, alpha);
    image(images[sectorToGridIndex[sector]], 0, 0);
  }

  if (keyPressed && key == 'i')
  {
    drawInfo();
  }
  else
  {
    drawDebug(angle, sectorD, 0);
  }
/*
  if (dist(width / 2, height / 2, mouseX, mouseY) >= moveDist)
  {
    shiftImages(sector);
    updateImages(sector);
  }
*/
}

void keyPressed()
{
  if (key == ' ')
  {
    int sector = findSector(getAngle());
    Offset move = sectorToOffset[sector];
    println("Move by " + move);

    currentPosition = currentPosition.moveTo(move);
    shiftImages(move);
    shiftInfo(move);
    updateImages(sector);
  }
}



float getAngle()
{
  return normalizeAngle(PI - atan2(height / 2 - mouseY, width / 2 - mouseX));
}

// Get any angle, between -infinite and +infinite, and clamp it between 0 and 2*PI
float normalizeAngle(float angle)
{
  // First, limit it between -2*PI and 2*PI, using modulo operator
  float na = angle % (2 * PI);
  // If the result is negative, bring it back to 0, 2*PI interval
  if (na < 0) na = 2*PI + na;
  return na;
}

int findSector(float angle)
{
  float a = PI / 8;
  for (int i = 0; i < 8; i++)
  {
    if (angle < a)
      return i;
    a += PI / 4;
  }
  return 0;
}

PImage getImage(int i)
{
  PImage img = loadImage("H:/Temp/Pauline/" + nf(i, 4) + ".jpg");
//   println("load " + nf(i, 4) + " " + img);
  return img;
}


/**
 * Given the movement of the user (as offset toward this direction),
 * shift the images in the grid in the opposite direction.
 */
void shiftImages(Offset move)
{
//  Offset shift = move.getOpposite();

  // Make a new array, it avoids to think about copy order...
  PImage[] shiftedImages = new PImage[IMAGE_GRID_SIZE * IMAGE_GRID_SIZE];
  for (int y = 0; y < IMAGE_GRID_SIZE; y++)
  {
    for (int x = 0; x < IMAGE_GRID_SIZE; x++)
    {
      Position pos = new ImagePosition(x, y).moveTo(move);
      shiftedImages[x + y * IMAGE_GRID_SIZE] = images[pos.getArrayIndex()];
    }
  }
  images = shiftedImages;
}

/**
 * Depending on the given sector (direction taken by user), loads the new images in the grid,
 * those left empty after the shift corresponding to the movement.
 */
void updateImages(int sector)
{
  int[] updates = sectorToIndexesToUpdate[sector];
  for (int toUpdate : updates)
  {
    Offset updateOffset = gridIndexToOffset[toUpdate];
    Position positionToUpdate = currentPosition.moveTo(updateOffset);
    images[toUpdate] = getImage(positionToUpdate.getArrayIndex());

    println("updateImages: " + toUpdate + " <- " + positionToUpdate + " (" + positionToUpdate.getArrayIndex() + ")");
    debugInfo[toUpdate].current = positionToUpdate;
    debugInfo[toUpdate].index = positionToUpdate.getArrayIndex();
  }
}

/**
 * For the given sector (as a grid index around the current position), and the distance of the mouse
 * cursor (to adapt to tablet movement?) to the center of this grid cell, compute the alpha
 * giving the contribution of the image of this grid position to the final image.
 */
int computeAlpha(int sector)
{
  Offset offset = sectorToOffset[sector];
  Position pos = centerPosition.moveTo(offset);
  // Divide screen in IMAGE_GRID_SIZE cells, compute the center of the cell at pos
  int cellWidth = width / IMAGE_GRID_SIZE;
  int cellWHeight = height / IMAGE_GRID_SIZE;
  int posX = pos.x * cellWidth - cellWidth / 2;
  int posY = pos.y * cellWHeight - cellWHeight / 2;
  // Compute the distance between this center and the mouse cursor position
  float dist = dist(posX, posY, mouseX, mouseY);
  // Relative amount (arbitrary! to adjust...)
  float amount = 2 * dist / dist(0, 0, width, height);
  int alpha = 255 - int(255 * amount);
  return constrain(alpha, 0, 255);
}


