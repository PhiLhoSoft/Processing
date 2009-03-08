static final int LARGE_PRIME = 444443;
int[] pixels;
int iterator, position;

void setup()
{
  size(1000, 10);
  pixels = new int[width];
}

void draw()
{
  iterator++;
  if (iterator > width + 10) // Deliberately go slightly over to verify my check routine...
  {
     noLoop();
     for (int i = 0; i < width; i++) if (pixels[i] != 1) println("[" + i + "]=" + pixels[i]);
     println("END");
  }
  position = (position + LARGE_PRIME) % width;
  switch (pixels[position])
  {
  case 0: stroke(#00FFFF); break;
  case 1: stroke(#00FF00); break;
  case 2: stroke(#FFFF00); break;
  default: stroke(#FF0000); break;
  }
  point(position, height / 2);
  pixels[position]++;
}

