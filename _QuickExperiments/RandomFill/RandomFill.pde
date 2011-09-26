int idx = 0;
int[] indices;

void setup()
{
  size(50, 50);
  background(255);
  indices = new int[width * height];
  // Generate a list of random indices
  // http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
  // inside-out algorithm
  for (int i = 1; i < indices.length; i++)
  {
    int j = int(random(0, i+1));
    indices[i] = indices[j];
    indices[j] = i;
  }
}

void draw()
{
  if (idx >= width * height)
  {
    println("Done!");
    noLoop();
    return;
  }
  
  loadPixels();
  pixels[indices[idx++]] = 0xFF000000 + idx * 64; //#000000;
  updatePixels();
}

