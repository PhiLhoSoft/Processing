final int INTERVAL = 10;
final boolean TO_RIGHT = true;

void setup()
{
  size(400, 400);
  smooth();
  background(255);
}

void draw()
{
  // Scroll one line of pixels per frame
  loadPixels();
  if (TO_RIGHT)
  {
    for (int r = 0; r < height; r++)
    {
      arrayCopy(pixels, width * r, pixels, width * r + 1, width - 1);
    }
  }
  else
  {
    arrayCopy(pixels, 0, pixels, width, (height - 1) * width);
  }
  updatePixels();
  // Add a line from time to time
  if (frameCount % INTERVAL == 0)
  {
    stroke(color(random(0, 50), random(50, 200), random(100, 255)));
    strokeWeight(random(2, 10));
    if (TO_RIGHT)
    {
      line(random(INTERVAL, width), 0, random(INTERVAL, width), height);
    }
    else
    {
      line(0, random(height - INTERVAL), width, random(height - INTERVAL));
    }
  }
}

