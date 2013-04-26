int ROWS = 16;
int COLS = 144;

PImage[] images = new PImage[25];

int[] sectorToGridIndex = { 13, 8, 7, 6, 11, 16, 17, 18 };
int centerIndex = 12;

Offset[] sectorToOffset =
{
  new Offset(+1,  0),
  new Offset(+1, -1),
  new Offset( 0, -1),
  new Offset(-1, -1),
  new Offset(-1,  0),
  new Offset(-1, +1),
  new Offset( 0, +1),
  new Offset(+1, +1)
};

Position currentPosition = new Position(ROWS / 2, COLS / 2);

void setup()
{
  size(1024, 768);
  textSize(24);
  
  for (int i = 0; i < sectorToGridIndex.length; i++)
  {
    int idx = sectorToOffset[i].getNewPosition(currentPosition).getArrayPosition();
    images[sectorToGridIndex[i]] = getImage(idx);
  }
  images[centerIndex] = getImage(currentPosition.getArrayPosition());
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
  
  text(degrees(angle), 10, 30);
  text(sector, 10, 60);
  text(alpha, 10, 90);
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
  return loadImage("H:/Temp/Pauline/" + nf(i, 4) + ".jpg");
}

