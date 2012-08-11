PImage img;
int radius;
int speed = 2;
int maxRadius;
int MIN_RADIUS = 4;
int MAX_RADIUS = 32;
int CIRCLE_NB = 16;
PVector[] toGrow = new PVector[CIRCLE_NB];
boolean bRandom = false;

void setup()
{
  size(400, 400);
  img = loadImage("SqMe.png");
  noStroke();
  smooth();
  background(255);
  for (int i = 0; i < CIRCLE_NB; i++)
  {
    toGrow[i] = new PVector();
  }
  if (!bRandom)
  {
    maxRadius = MAX_RADIUS * 2;
  }
}

void draw()
{ 
//  image(img, 0, 0);
  radius += speed;
  for (int i = 0; i < CIRCLE_NB; i++)
  {
    PVector v = toGrow[i];
    color pix = img.get(int(v.x), int(v.y));
    fill(pix);
    ellipse(v.x, v.y, radius / 2, radius / 2);
  }
  if (radius >= maxRadius)
  {
    GetPoints();
    radius = 0;
  }
} 

void GetPoints()
{
  if (bRandom)
  {
    maxRadius = int(random(MIN_RADIUS, MAX_RADIUS - MIN_RADIUS));
  }
  else
  {
    if (maxRadius > MIN_RADIUS / 2)
    {
      maxRadius--;
    }
  }
  for (int i = 0; i < CIRCLE_NB; i++)
  {
    PVector v = toGrow[i];
    v.x = random(maxRadius / 4, img.width - maxRadius / 2);
    v.y = random(maxRadius / 4, img.height - maxRadius / 2);
  }
}

