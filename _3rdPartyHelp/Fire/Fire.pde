//  ========================================================
//
//  Fire Drag
//  arthurG, June 2011
//
//  questions, comments : arthurgraff -at- gmail
//  ========================================================

class FireParticle
{
  float x, y;
  float dirx, diry;
  float speed;
  float perlinPosX, perlinPosY;
  int amountA, amountR, amountG, amountB;
  boolean alive;

  FireParticle(float x, float y)
  {
    this.x = x;
    this.y = y;
    speed = 0.7 + random(0.7);

    amountA = 140 + (int) random(80);
    amountR =  65 + (int) random(65);
    amountG =  30 + (int) random(30);
    amountB =  20 + (int) random(20);

    perlinPosX = random(100);
    perlinPosY = random(100);

    dirx = random(-speed, speed);
    diry = random(-speed, speed);

    alive = true;
  }

  void update()
  {
    if (amountR > 0)
      amountR--;
    if (amountG > 0)
      amountG--;
    if (amountB > 0)
      amountB--;
    if (amountA > 0)
      amountA--;

    if (amountR == 0 && amountG == 0 && amountB == 0 && amountA == 0)
    {
      alive = false;
      return;
    }

    float dx = 2.0 * (0.5 - noise(perlinPosX));
    float dy = 2.0 * (0.5 - noise(perlinPosY));
    perlinPosX += scaleNoise * speed;
    perlinPosY += scaleNoise * speed;

    dirx = (dirx + dx * speed) / 2.0;
    diry = (diry + dy * speed) / 2.0;

    speed *= 0.99;

    x += dirx;
    y += diry;

    if (x < 0 || x >= width || y < 0 || y >= height)
      alive = false;
  }

  void draw()
  {
    int id = (int) x + (int) y * width;
    bufferR[id] = min(255, bufferR[id] + amountR);
    bufferG[id] = min(255, bufferG[id] + amountG);
    bufferB[id] = min(255, bufferB[id] + amountB);
    bufferA[id] = min(255, bufferA[id] + amountA);
  }
}

//  ========================================================


class FireSource
{
  float x, y;
  float lastx, lasty;

  ArrayList<FireParticle> particles;
  final int MAX_PARTICLES = 5000;

  FireSource(float x, float y)
  {
    this.x = x;
    this.y = y;

    lastx = x;
    lasty = y;

    particles = new ArrayList<FireParticle>();
  }

  void update(float x, float y, int n)
  {
    lastx = this.x;
    lasty = this.y;
    this.x = x;
    this.y = y;

    // Add some new particles around given position
    for (int i = 0; i < n && particles.size() < MAX_PARTICLES; i++)
    {
      float coef = random(1);
      particles.add(new FireParticle(
          x * coef + lastx * (1.0 - coef),
          y * coef + lasty * (1.0 - coef)
      ));
    }

    Iterator<FireParticle> iter = particles.iterator();
    while (iter.hasNext())
    {
      FireParticle particle = iter.next();
      particle.update();
      if (particle.alive)
      {
        particle.draw();
      }
      else
      {
        iter.remove();
      }
    }
  }

  void getImage(PImage img)
  {
    img.loadPixels();
    int val;
    for (int i = 0; i < width*height; i++)
    {
      img.pixels[i] = bufferA[i] << 24 | bufferR[i] << 16 | bufferG[i] << 8 | bufferB[i];
    }
    img.updatePixels();
  }
}

// ----------------------------------------------------------
//
//  fastBlur :
//  Blur an array by avoiding a 2nd temporary array
//
//  A B C D E F
//  G H I J K L  -> array
//  M N O P Q R
//
//  1st pass, blur the cells A, C, E, H, J, L, M, O, Q
//  2nd pass, blur the cells B, D, F, G, I, K, N, P, R
//
//  i.e. (2nd line) :
//  1st pass : H = (H+(B+G+I+N)/4)/2
//             J = (J+(D+I+K+P)/4)/2
//  2nd pass : I = (I+(C+H+J+O)/4)/2
//             K = (K+(E+J+L+Q)/4)/2
//
// ----------------------------------------------------------
void fastBlur(int[] buf, boolean coarse)
{
  int id, k;
  int lim = width*(height-1);
  int shift = coarse ? 2 : 3;

  id = width+1;
  k=0;
  for (; id<lim; id+=1+k+k)
  {
    for (int i=1+k; i<width-1; i+=2, id+=2)
    {
      if (!coarse)
      {
        buf[id] >>= 1;
      }
      buf[id] += (buf[id-1] + buf[id+1] + buf[id+width] + buf[id-width]) >> shift;
    }

    k = 1-k;
  }

  id = width+2;
  k=1;
  for (; id<lim; id+=1+k+k)
  {
    for (int i=1+k; i<width-1; i+=2, id+=2)
    {
      if (!coarse)
      {
        buf[id] >>= 1;
      }
      buf[id] += (buf[id-1] + buf[id+1] + buf[id+width] + buf[id-width]) >> shift;
    }
    k = 1-k;
  }
}

void cleanBorders(int[] buf)
{
  int id, lim;

  lim = width-1;
  for (id=1; id<lim; id++)
    buf[id] = 0;

  lim = width*height-1;
  for (id=width*(height-1)+1; id<lim; id++)
    buf[id] = 0;

  lim = width*height;
  for (id=0; id<lim; id+=width)
    buf[id] = 0;

  lim = width*height;
  for (id=width-1; id<lim; id+=width)
    buf[id] = 0;
}

//  ========================================================


PImage img;
int[] bufferR;
int[] bufferG;
int[] bufferB;
int[] bufferA;

FireSource source;

float scaleNoise = 0.01;

void setup()
{
  size(400, 400, P2D);

  img = createImage(width, height, ARGB);
  bufferR = new int[width*height];
  bufferG = new int[width*height];
  bufferB = new int[width*height];
  bufferA = new int[width*height];

  source = new FireSource(mouseX, mouseY);
}


void draw()
{
  background(255);

  // Add some particles to the mouse position (up to the max allowed)
  source.update(mouseX, mouseY, 16);

  cleanBorders(bufferA);
  cleanBorders(bufferR);
  cleanBorders(bufferG);
  cleanBorders(bufferB);

  fastBlur(bufferR, false);
  fastBlur(bufferG, false);
  fastBlur(bufferB, false);

  fastBlur(bufferA, false);
  fastBlur(bufferA, false);
  fastBlur(bufferA, true);

  source.getImage(img);
  image(img, 0, 0);
}
