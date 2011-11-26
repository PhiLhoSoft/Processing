int[] distribution = { 2, 3, 5, 7, 5, 3, 2 };
int[] stats = new int[distribution.length];
int max;

PGraphics og; // Offline graphics
PImage maskI;

void setup()
{
  size(500, 200);
  randomSeed(System.nanoTime());
  // Mask works only with P2D
  og = createGraphics(width, height, P2D);
  for (int i = 0; i < distribution.length; i++)
  {
    max += distribution[i];
  }

  // Mask must be of same size as target image
  PGraphics maskG = createGraphics(width, height, JAVA2D);
  maskG.beginDraw();
  maskG.smooth();
  maskG.noStroke();
//  maskG.background(0); // Transparent background
  maskG.background(20); // Semi-transparent background
  maskG.fill(255); // Masking drawing
  maskG.ellipseMode(CENTER);
  maskG.ellipse(width / 2, height / 2, width - 40, height - 40);
  maskG.endDraw();
  // We can mask only with a PImage
  maskI = maskG.get(0, 0, width, height);
}

void draw()
{
  int rnd = 1 + int(random(max));
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

  // Draw on standard g
  background(#EEFFEE);
  PGraphics oldG = g; // Preserve original
  g = og; // Replace it with our graphics
  g.beginDraw(); // Still needed in this case

  // Further drawing go offline
  background(255);
  int xpos = 20;
  for (int i = 0; i < stats.length; i++)
  {
    fill(100, 255 - i * 20, 128 + i * 20);
    rect(xpos, height - stats[i], 50, stats[i]);
    xpos += 70;
  }

  g.endDraw();
  g = oldG; // Restore default
  og.mask(maskI);
  image(og, 0, 0);
}
