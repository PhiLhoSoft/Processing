import java.awt.geom.AffineTransform;
import java.awt.geom.NoninvertibleTransformException;

final static int GRID_ROWS = 4;
final static int GRID_COLS = 6;
final static int GRID_CELL_SIZE = 50;

final static int GRID_WIDTH = GRID_CELL_SIZE * GRID_COLS;
final static int GRID_HEIGHT = GRID_CELL_SIZE * GRID_ROWS;

final static color COLOR_DEFAULT  = #2244FF;
final static color COLOR_ALL_OVER = #FF4422;
final static color COLOR_OVER     = #44FF22;
color cellColor;

float angle;
float noiseScale = 0.01;
float noiseX, noiseY;

float origX, origY;
float gxl;
float gxr;
float gyt;
float gyb;
PVector transform;

// Matrix inverse of the current transform
double[] inverse = new double[6];


void setup()
{
  size(800, 800);
  smooth();
  origX = width / 2;
  origY = height / 2;

  gxl = 0;
  gxr = GRID_WIDTH;
  gyt = 0;
  gyb = GRID_HEIGHT;

  noiseX = mouseX; noiseY = mouseY;
  cellColor = COLOR_DEFAULT;
}

void draw()
{
  background(#ABCDEF);

  noiseX += noiseScale; noiseY += noiseScale;
  float noiseVal = noise(noiseX, noiseY);

  angle = noiseVal * TWO_PI;

  ApplyTransform();
  DrawGrid();
}

void ApplyTransform()
{
  translate(origX, origY);
  rotate(angle);
  translate(-GRID_WIDTH/2, -GRID_HEIGHT/2);
  DrawPoint(gxl, gyt);
  DrawPoint(gxl, gyb);
  DrawPoint(gxr, gyt);
  DrawPoint(gxr, gyb);

  Graphics2D g2 = ((PGraphicsJava2D) g).g2;
  AffineTransform at = g2.getTransform();
  AffineTransform iat = null;
  try
  {
    iat = at.createInverse();
  }
  catch (NoninvertibleTransformException e)
  {
    println("Ouch!");
    exit();
  }
  iat.getMatrix(inverse);
}
float GetTransformedMouseX()
{
  return (float) inverse[0] * mouseX + (float) inverse[2] * mouseY + (float) inverse[4];
}
float GetTransformedMouseY()
{
  return (float) inverse[1] * mouseX + (float) inverse[3] * mouseY + (float) inverse[5];
}

void mouseMoved()
{
  float mx = GetTransformedMouseX();
  float my = GetTransformedMouseY();
  if (mx > gxl && mx < gxr && my > gyt && my < gyb)
  {
    cellColor = COLOR_ALL_OVER;
  }
  else
  {
    cellColor = COLOR_DEFAULT;
  }
}
void mousePressed()
{
}
void mouseDragged()
{
}
void mouseReleased()
{
}

void keyReleased()
{
}

void DrawGrid()
{
  float mx = GetTransformedMouseX();
  float my = GetTransformedMouseY();

  stroke(0);
  for (int r = 0; r < GRID_ROWS; r++)
  {
    for (int c = 0; c < GRID_COLS; c++)
    {
      if (mx > gxl + c * GRID_CELL_SIZE && mx < gxl + (c + 1) * GRID_CELL_SIZE &&
          my > gyt + r * GRID_CELL_SIZE && my < gyt + (r + 1) * GRID_CELL_SIZE)
      {
        fill(COLOR_OVER);
      }
      else
      {
        fill(cellColor);
      }
      rect(0, 0, GRID_CELL_SIZE, GRID_CELL_SIZE);
      translate(GRID_CELL_SIZE, 0);
    }
    translate(-GRID_CELL_SIZE * (GRID_ROWS + 2), GRID_CELL_SIZE);
  }
}

void DrawPoint(float x, float y)
{
  fill(#FF0000);
  noStroke();
  ellipse(x, y, 5, 5);
}

void DrawPoint2(float x, float y)
{
  fill(#FFFF00);
  noStroke();
  rect(x, y, 5, 5);
}

