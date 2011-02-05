PImage photo;
final int MAX_LEVEL = 5;
int level = 4;

void setup()
{
  photo = loadImage("G:/Images/dr_house_17.jpg");
  size(photo.width, photo.height, P2D);
  photo.loadPixels(); // Probably do nothing, but good practice to call it anyway
}

void draw()
{
  float f = 255.0/ (pow(2, 2 * level) + 1);
  loadPixels();
  for (int x = 0; x < width; x++)
  {
    for (int y = 0; y < height; y++)
    {
      int pos = x + y * photo.width;
      color c = photo.pixels[pos];
      if (level < MAX_LEVEL) // Otherwise, just display the original image
      {
        // Compute the threshold to apply, depending on user input
        float threshold = level > 0 ? dizza(x, y, level) * f : 128;
        // Decompose the color in its components
        int red = (c >> 16) & 0xFF;
        int green = (c >> 8) & 0xFF;
        int blue = c & 0xFF;
        if (key == 'c')
        {
          // Above threshold, black, otherwise, white
          int r = threshold >= red ? 0 : 255;
          int g = threshold >= green ? 0 : 255;
          int b = threshold >= blue ? 0 : 255;
          // Recombine the color channels
          c = (r << 16) | (g << 8) | b;
        }
        else if (key == 'n')
        {
          // Black & White, compare threshold to the average of the three channels
          if (threshold >= (red + green + blue) / 3.0)
            c = color(0); // Black
          else
            c = color(255); // White
        }
      }
      pixels[pos] = c;
    }
  }
  updatePixels();
}

void mousePressed()
{
  if (--level < 0) level = MAX_LEVEL;
  println(level);
}

int dizza(int i, int j, int n)
{
  if (n == 1)
  {
    return (i % 2 != j % 2 ? 2 : 0) + j % 2;
  }
  else
  {
    // Recursive call
    return 4 * dizza(i % 2, j % 2, n-1) + dizza(int(i/2), int(j/2), n-1);
  }
}

