int[] distribution = { 2, 3, 3, 2 };
int[] stats = new int[distribution.length];

void setup()
{
  size(500, 200);
  randomSeed(System.nanoTime());
}

void draw()
{
  int rnd = 1 + int(random(10));
  int total = 0;
  int pos = -1;
  for (int i = 0; i < distribution.length; i++)
  {
    total += distribution[i];
    if (rnd <= total)
    {
      pos = i;
      break;
    }
  }
  assert pos >= 0;
  stats[pos]++;
  
  background(255);
  int xpos = 20;
  for (int i = 0; i < stats.length; i++)
  {
    fill(100, 255 - i * 20, 128 + i * 20);
    rect(xpos, height - stats[i], 50, stats[i]);
    xpos += 70;
  }
}


