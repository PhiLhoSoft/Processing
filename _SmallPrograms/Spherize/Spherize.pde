final float effectAmount = 0.75;

void Spherize(int xPos, int yPos, int radius)
{
  int tlx = xPos - radius, tly = yPos - radius;
  PImage pi = get(tlx, tly, radius * 2, radius * 2);
  for (int x = - radius; x < radius; x++)
  {
    for (int y = - radius; y < radius; y++)
    {
      // Rescale cartesian coords between -1 and 1
      float cx = (float)x / radius;
      float cy = (float)y / radius;

      // Outside of the sphere -> skip
      float square = sq(cx) + sq(cy);
      if (square >= 1)
        continue;

      // Compute cz from cx & cy
      float cz = sqrt(1 - square);

      // Cartesian coords cx, cy, cz -> spherical coords sx, sy, still in -1, 1 range
      float sx = atan(effectAmount * cx / cz) * 2 / PI;
      float sy = atan(effectAmount * cy / cz) * 2 / PI;

      // Spherical coords sx & sy -> texture coords
      int tx = tlx + (int)((sx + 1) * radius);
      int ty = tly + (int)((sy + 1) * radius);

      // Set pixel value
      int alpha = (int)(255 * sq(1 - square)) << 24;
      pi.set(radius + x, radius + y, alpha | (0xFFFFFF & get(tx, ty)));
    }
  }
  set(tlx, tly, pi);
  println("Done");
}

int startX, startY;
PImage me;

void setup()
{
  background(#ABCDEF);
  me = loadImage("D:/_PhiLhoSoft/Processing/me.png");
  size(me.width, me.height);
  image(me, 0, 0);
}

void draw()
{
}

void mousePressed()
{
  startX = mouseX; startY = mouseY;
}

void mouseReleased()
{
  float radius = sqrt(sq(startX - mouseX) + sq(startY - mouseY));
  Spherize(startX, startY, int(radius));
}
