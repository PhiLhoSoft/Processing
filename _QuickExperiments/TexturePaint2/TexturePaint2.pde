// [url=http://processing.org/discourse/yabb2/YaBB.pl?num=1229687224/5#5]Re: fill shape with pattern[/url]
// See also [url=http://processing.org/reference/texture_.html]texture()[/url] (P2D, P3D, OPENGL)
PGraphics texture;
PGraphics mask;

PVector v1, v2, v3;
PVector s1, s2, s3;
PFont font;

static final int D_TRIANGLE = 1;
static final int D_TEXT = 2;

int m1, m2;

void setup()
{
  size(800, 500);
  PImage smallImage = loadImage("greenfoil.png");
  font = loadFont("AmericanTypewriter-24.vlw");

  mask = createGraphics(width, height, JAVA2D);

  // Make tiled texture
  texture = createGraphics(width, height, JAVA2D);
  texture.beginDraw();
  for (int x = 0; x < width; x += smallImage.width)
  {
    for (int y = 0; y < height; y += smallImage.height)
    {
      texture.image(smallImage, x, y);
    }
  }
  texture.endDraw();

  // Define a triangle
  v1 = new PVector(50, 50);
  v2 = new PVector(width - 50, 50);
  v3 = new PVector(width / 2, height / 2);
  m1 = m2 = 5;
}

void draw()
{
  background(230);

  drawTextured(D_TRIANGLE);
  drawTextured(D_TEXT);
  v1.x += m1; if (v1.x > width || v1.x < 0) m1 = -m1;
  v2.x -= m2; if (v2.x > width || v2.x < 0) m2 = -m2;
  v1.y += 6*sin(v1.x/36);
  v2.y += 6*cos(v2.x/36);
}

// I would pass an interface and a make drawing class instead
// but I wanted to make it simple here
void drawTextured(int drawing)
{
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.noStroke();
  if (drawing == D_TRIANGLE)
  {
    mask.triangle(v1.x, v1.y, v2.x, v2.y, v3.x, v3.y);
  }
  else if (drawing == D_TEXT)
  {
    mask.textFont(font, 120);
    mask.text("Processing", 50, 2*height/3);
  }
  mask.endDraw();

  PImage maskedResult = texture.get();
  maskedResult.mask(mask);
  image(maskedResult, 0, 0);
}

