static final int DISK_NB = 8;
static final int DISK_DIAMETER = 64;
static final int MIN_RADIUS = 64, MAX_RADIUS = 200;
static final float ANGLE_STEP = TWO_PI / DISK_NB;

int[] maskArray;
static final int blendFactor = 85;
PImage previousFrame;

void setup()
{
  size(800, 800);
//  frameRate(10);

  maskArray = new int[width * height];
  Arrays.fill(maskArray, blendFactor);
}

void draw()
{
  previousFrame = get();
  previousFrame.mask(maskArray);

  background(#AAEEFF);
  noFill();
  noStroke();
  DrawCircles();

  blend(previousFrame, 0, 0, width, height, 0, 0, width, height, BLEND);
}

void DrawCircles()
{
  float step = (PI / 30) * frameCount;
  float radius = (MAX_RADIUS - MIN_RADIUS) * (1.0 + sin(step)) + MIN_RADIUS;
  float angle = 0;
  for (int i = 0; i < DISK_NB; i++)
  {
    angle += ANGLE_STEP;
    int cg = 128 + int(32 * (1.0 + cos(angle)));
    int cb = 128 + int(32 * (1.0 + sin(angle)));
    fill(color(0, cg, cb));
    float x = width / 2 + radius * cos(step + angle);
    float y = height / 2 + radius * sin(step + angle);
    ellipse(x, y, DISK_DIAMETER, DISK_DIAMETER);
  }
}

