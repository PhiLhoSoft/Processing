static final int LARGE_PRIME = 444443;
static final int TEST_NB = 2;
int SMALL_IMAGE_NB = 6;
int SMALL_IMAGE_SIZE = 48;
int BIG_IMAGE_NB_H = 43;
int BIG_IMAGE_NB_V = 47;
int TOTAL_IMAGE_NB = BIG_IMAGE_NB_H * BIG_IMAGE_NB_V;

PGraphics bigImage;
PImage[] smallImages = new PImage[SMALL_IMAGE_NB];

void setup()
{
  for (int i = 0; i < SMALL_IMAGE_NB; i++)
  {
    smallImages[i] = loadImage("testImage" + (i + 1) + ".png");
  }
  if (TEST_NB == 1)
  {
    bigImage = createGraphics(SMALL_IMAGE_SIZE, SMALL_IMAGE_SIZE * SMALL_IMAGE_NB, JAVA2D);
  }
  else
  {
    bigImage = createGraphics(SMALL_IMAGE_SIZE * BIG_IMAGE_NB_H, SMALL_IMAGE_SIZE * BIG_IMAGE_NB_V, JAVA2D);
  }
  bigImage.beginDraw();
  if (TEST_NB == 1)
  {
    for (int i = 0; i < SMALL_IMAGE_NB; i++)
    {
      bigImage.image(smallImages[i], 0, i * SMALL_IMAGE_SIZE);
    }
  }
  else
  {
    for (int i = 0, position = 0; i < TOTAL_IMAGE_NB; i++)
    {
      position = (position + LARGE_PRIME) % TOTAL_IMAGE_NB;
      int x = (position % BIG_IMAGE_NB_H) * SMALL_IMAGE_SIZE;
      int y = (position / BIG_IMAGE_NB_H) * SMALL_IMAGE_SIZE;
      bigImage.image(smallImages[i % SMALL_IMAGE_NB], x, y);
    }
  }
  bigImage.endDraw();
  bigImage.save("BigImage-" + TEST_NB + ".png");
  exit();
}

