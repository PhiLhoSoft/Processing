static final int LARGE_PRIME = 444443;

int SMALL_IMAGE_NB = 6;
int SMALL_IMAGE_SIZE = 48;
int HALF_SMALL_IMAGE_SIZE = SMALL_IMAGE_SIZE / 2;
int BIG_IMAGE_NB_H = 23;
int BIG_IMAGE_NB_V = 17;
int DISPLAYED_IMAGE_NB = BIG_IMAGE_NB_H * BIG_IMAGE_NB_V;

PImage[] smallImages = new PImage[SMALL_IMAGE_NB];

void setup()
{
  size(SMALL_IMAGE_SIZE * BIG_IMAGE_NB_H, SMALL_IMAGE_SIZE * BIG_IMAGE_NB_V);
  background(#5577AA);
  for (int i = 0; i < SMALL_IMAGE_NB; i++)
  {
    smallImages[i] = loadImage("testImage" + (i + 1) + ".png");
  }
}

int counter, position;

void draw()
{
  counter++;
  if (counter > DISPLAYED_IMAGE_NB)
  {
    noLoop();
    return;
  }
  position = (position + LARGE_PRIME) % DISPLAYED_IMAGE_NB;
  int x = (position % BIG_IMAGE_NB_H) * SMALL_IMAGE_SIZE;
  int y = (position / BIG_IMAGE_NB_H) * SMALL_IMAGE_SIZE;
  translate(x + HALF_SMALL_IMAGE_SIZE, y + HALF_SMALL_IMAGE_SIZE);
  rotate(counter * QUARTER_PI);
  translate(-HALF_SMALL_IMAGE_SIZE, -HALF_SMALL_IMAGE_SIZE);
  image(smallImages[counter % SMALL_IMAGE_NB], 0, 0);
}

