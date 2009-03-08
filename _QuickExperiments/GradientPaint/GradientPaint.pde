PGraphics pgGradient;
PGraphics pgMask;
PGraphics pgShape;

PVector v1, v2, v3;
PVector s1, s2, s3;
PFont font;

static final int D_TRIANGLE = 1;
static final int D_TEXT = 2;

int m1, m2;

void setup()
{
  size(800, 500);

  pgMask = createGraphics(width, height, JAVA2D);
  pgShape = createGraphics(width, height, P2D);
  font = loadFont("AmericanTypewriter-24.vlw");

  // Make gradient
  pgGradient = CreateGradient(width / 3, height / 3, 200, #00FF00, #0088FF);

  // Define a triangle
  v1 = new PVector(50, 50);
  v2 = new PVector(width - 50, 50);
  v3 = new PVector(width / 2, height / 2);
  m1 = m2 = 5;
}

void draw()
{
  background(230);

  DrawTextured(D_TRIANGLE);
  DrawTextured(D_TEXT);
  v1.x += m1; if (v1.x > width || v1.x < 0) m1 = -m1;
  v2.x -= m2; if (v2.x > width || v2.x < 0) m2 = -m2;
  v1.y += 6*sin(v1.x/36);
  v2.y += 6*cos(v2.x/36);
}

// I would pass an interface and a make drawing class instead
// but I wanted to make it simple here
void DrawTextured(int drawing)
{
  pgMask.background(0);
  pgMask.fill(255);
  pgMask.noStroke();
  if (drawing == D_TRIANGLE)
  {
    DrawTriangle(pgMask);
  }
  else if (drawing == D_TEXT)
  {
    DrawText(pgMask);
  }
  PImage piMask = pgMask.get(0, 0, width, height);

  pgShape.image(pgGradient, 0, 0);
  pgShape.mask(piMask);

  image(pgShape, 0, 0);
}

void DrawTriangle(PGraphics g)
{
  g.beginDraw();
  g.triangle(v1.x, v1.y, v2.x, v2.y, v3.x, v3.y);
  g.endDraw();
}

void DrawText(PGraphics g)
{
  g.beginDraw();
  g.textFont(font, 120);
  g.text("Processing", 50, 2*height/3);
  g.endDraw();
}

PGraphics CreateGradient(int centerX, int centerY, int radius, color startColor, color endColor)
{
  PGraphics pgGradient = createGraphics(width, height, JAVA2D);
//  pgGradient.beginDraw();
  pgGradient.loadPixels();
  for (int x = 0; x < width; x++)
  {
    for (int y = 0; y < height; y++)
    {
      float d = dist(x, y, centerX, centerY);
      color c = endColor;
      if (d <= radius)
      {
        c = lerpColor(startColor, endColor, d / radius);
      }
      pgGradient.pixels[x + y * width] = c;
    }
  }
  pgGradient.updatePixels();
//  pgGradient.endDraw();
  return pgGradient;
}
