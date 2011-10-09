PImage imgC, imgBW;
// Size of transparency area around the mouse
int HALF_HOLE_SIZE = 20;
// Change to true to avoid restoring opacity (ie. paint with background image)
boolean bPersist = false;

void setup()
{
  size(300, 400);
  // Load a color image
  imgC = loadImage("H:/PhiLhoSoft/images/me.jpg");
  // Load a black & white image (the same)
  imgBW = loadImage("H:/PhiLhoSoft/images/me_BW.jpg");
  // Indicate we need transparency on this image
  imgBW.format = ARGB;
  noStroke();
  smooth();
  background(255);
}

void draw()
{ 
  // Draw the color image
  image(imgC, 0, 0);
  if (!bPersist)
  {
    // Restore opacity on previous position
    ChangePixels(pmouseX, pmouseY, true);
  }
  // Make pixels transparent around the mouse position
  ChangePixels(mouseX, mouseY, false);
  // Draw the altered B&W image
  image(imgBW, 0, 0);
} 

void ChangePixels(int x, int y, boolean bMakeOpaque)
{
  // Primitive, lazy tests, should be improved (
  if (x <= HALF_HOLE_SIZE || x >= imgBW.width - HALF_HOLE_SIZE) return;
  if (y <= HALF_HOLE_SIZE || y >= imgBW.height - HALF_HOLE_SIZE) return;
  // Get the pixel data
  imgBW.loadPixels();
  // Walk a square around the given position
  for (int i = x - HALF_HOLE_SIZE; i <= x + HALF_HOLE_SIZE; i++)
  {
    for (int j = y - HALF_HOLE_SIZE; j <= y + HALF_HOLE_SIZE; j++)
    {
      if (dist(i, j, x, y) > HALF_HOLE_SIZE) continue;
      if (bMakeOpaque)
      {
        imgBW.pixels[i + j * imgBW.width] |= 0xFF000000;
      }
      else // Make transparent
      {
        imgBW.pixels[i + j * imgBW.width] &= 0x00FFFFFF;
      }
    }
  }
  // Update the modified pixels
  imgBW.updatePixels();
}

