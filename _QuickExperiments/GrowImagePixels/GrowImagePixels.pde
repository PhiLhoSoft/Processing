PImage img;
int radius;
int dir = 2;
int MAX_RADIUS = 60;
int CIRCLE_NB = 25;
PVector[] toGrow = new PVector[CIRCLE_NB];

void setup()
{
  size(400, 400);
  img = loadImage("E:/Dev/PhiLhoSoft/Processing/SqMe.png");
  println(img);
  noStroke();
  smooth();
  for (int i = 0; i < CIRCLE_NB; i++)
  {
    toGrow[i] = new PVector();
  }
}

void draw()
{ 
  image(img, 0, 0);
  radius += dir;
  if (radius == 0)
  {
    GetPoints();
    dir = -dir;
  }
  else if (radius == MAX_RADIUS)
  {
    dir = -dir;
  }
  for (int i = 0; i < CIRCLE_NB; i++)
  {
    PVector v = toGrow[i];
    color pix = img.get(int(v.x), int(v.y));
    fill(pix, 127);
    ellipse(v.x, v.y, radius / 2, radius / 2);
  }
} 

void GetPoints()
{
  for (int i = 0; i < CIRCLE_NB; i++)
  {
    PVector v = toGrow[i];
    v.x = MAX_RADIUS / 2 + int(random(img.width - MAX_RADIUS));
    v.y = MAX_RADIUS / 2 + int(random(img.height - MAX_RADIUS));
  }
}

