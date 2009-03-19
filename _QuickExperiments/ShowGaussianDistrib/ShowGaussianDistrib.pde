int RANGE = 500;

void setup()
{
  size(500, 300);
  background(255);
  
  int[] vals = new int[RANGE];
  
  Random rnd = new Random();
  double mx = 0, mn = 1000;
  for (int i = 0; i < 30000; i++)
  {
    double v = rnd.nextGaussian();
    if (v > mx) mx = v;
    if (v < mn) mn = v;
    // Found that values seem to go from -4 to 4
    // with occasional abs values beyond (below 4.5)
    double val = (v + 5) / 10;
    int idx = (int)(val * RANGE);
    if (idx < 0 || idx > RANGE)
    {
      // Rare but happens
      println("Oops: " + v);
      continue;
    }
    vals[idx]++;
  }
  println("MX " + mx + " MN " + mn);
  stroke(#000088);
  for (int i = 0; i < RANGE; i++)
  {
    line(i, height, i, height - vals[i]);
  }
}

