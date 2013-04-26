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
final int[] sectorToGridIndex = { 13, 8, 7, 6, 11, 16, 17, 18 };
final int centerIndex = 12;
final int[][] sectorToImagesToUpdate =
{
  { 4, 9, 14, 19, 24 },
  { 0, 1, 2, 3, 4, 9, 14, 19, 24 },
  { 0, 1, 2, 3, 4 },
  { 0, 1, 2, 3, 4, 5, 10, 15, 20  },
  { 0, 5, 10, 15, 20 },
  { 0, 5, 10, 15, 20, 21, 22, 23, 24 },
  { 20, 21, 22, 23, 24 },
  { 4, 9, 14, 19, 20, 21, 22, 23, 24,  },
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
};

Position currentPosition = new VirtualPosition(ROWS / 2, COLS / 2);

void setup()
{
  size(1024, 768);
  textSize(24);

println("Load images");
  for (int i = 0; i < sectorToGridIndex.length; i++)
  {
    int idx = currentPosition.moveTo(sectorToOffset[i]).getArrayPosition();
    images[sectorToGridIndex[i]] = getImage(idx);
  }
  images[centerIndex] = getImage(currentPosition.getArrayPosition());
println("Images loaded. Last = " + currentPosition.getArrayPosition());  
}

void draw()
{
  float angle = normalizeAngle(PI - atan2(height / 2 - mouseY, width / 2 - mouseX));
  int sector = findSector(angle);

  PImage image1 = images[centerIndex], image2 = images[sectorToGridIndex[sector]];
  int alpha = int(200 * dist(width / 2, height / 2, mouseX, mouseY) / (width / 2));
  tint(255, 255 - alpha);
  image(image1, 0, 0);
  tint(255, alpha);
  image(image2, 0, 0);

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

  text(degrees(angle), 10, 30);
  text(sector, 10, 60);
  text(alpha, 10, 90);

  if (dist(width / 2, height / 2, mouseX, mouseY) >= moveDist)
  {
    shiftImages(sector);
    updateImages(sector);
  }
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
  println("load " + nf(i, 4));
  return loadImage("H:/Temp/Pauline/" + nf(i, 4) + ".jpg");
}

void shiftImages(int sector)
{
  Offset move = sectorToOffset[sector];
  Offset shift = move.getOpposite();

  // Make a new array, it avoids to think about copy order...
  PImage[] shiftedImages = new PImage[IMAGE_GRID_SIZE * IMAGE_GRID_SIZE];
  for (int y = 0; y < IMAGE_GRID_SIZE; y++)
  {
    for (int x = 0; x < IMAGE_GRID_SIZE; x++)
    {
      Position pos = new ImagePosition(x, y).moveTo(shift);
      shiftedImages[x + y * IMAGE_GRID_SIZE] = images[pos.getArrayPosition()];
    }
  }
  images = shiftedImages;
}

void updateImages(int sector)
{
  int[] updates = sectorToImagesToUpdate[sector];
  for (int toUpdate : updates)
  {
    Offset updateOffset = gridIndexToOffset[toUpdate];
    Position positionToUpdate = currentPosition.moveTo(updateOffset);
    images[toUpdate] = getImage(positionToUpdate.getArrayPosition());
  }
}
