
void Spherize(int xPos, int yPos, int width, int height)
{
  for (int x = 0; x < width; x++)
  {
    for (int y = 0; y < height; y++)
    {
      // Center + rescale coords in [-1, 1]
      double xk = ((double)x / width) * 2 - 1;
      double yk = ((double)y / height) * 2 - 1;

      // Outside of the sphere -> skip
      double square = sq(yk) + sq(xk);
      if (square >= 1)
        continue;

      // Compute zk from (xk, yk)
      double zk = sqrt(1 - square);

      // Cartesian coords (xk, yk, zk) in [-1, 1] -> spherical coords (xs, ys) in [-1, 1]
      double xs = atan(xk / zk) * 2 / PI;
      double ys = atan(yk / zk) * 2 / PI;

      // Spherical coords (xs, ys) -> texture coords
      int xtex = (int)(width * (xs + 1) / 2);
      int ytex = (int)(height * (ys + 1) / 2);

      // Set pixel value
      output[x][y] = input[xtex][ytex];
    }
  }
}

void Spherize(int xPos, int yPos, int radius)
{
  int tlx = xPos - radius, tly = yPos - radius;
  PImage pi = get(tlx, tly, radius * 2, radius * 2);
  for (int x = - radius; x < radius; x++)
  {
    for (int y = - radius; y < radius; y++)
    {
      // Rescale cartesian coords between -1 and 1
      double cx = (double)x / radius;
      double cy = (double)y / radius;

      // Outside of the sphere -> skip
      double square = sq(cx) + sq(cy);
      if (square >= 1)
        continue;

      // Compute cz from cx & cy
      double cz = sqrt(1 - square);

      // Cartesian coords cx, cy, cz -> spherical coords sx, sy, still in -1, 1 range
      double sx = atan(cx / cz) * 2 / PI;
      double sy = atan(cy / cz) * 2 / PI;

      // Spherical coords sx & sy -> texture coords
      int tx = xPos + (int)((sx + 1) / 2) * radius;
      int ty = yPos + (int)((sy + 1) / 2) * radius;

      // Set pixel value
      pi.set(radius + x, radius + y, get(tx, ty));
    }
  }
  set(tlx, tly, pi);
}
