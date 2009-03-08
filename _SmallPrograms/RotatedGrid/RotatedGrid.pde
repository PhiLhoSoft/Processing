final static int GRID_ROWS = 4;
final static int GRID_COLS = 6;
final static int GRID_CELL_SIZE = 50;

final static int GRID_WIDTH = GRID_CELL_SIZE * GRID_COLS;
final static int GRID_HEIGHT = GRID_CELL_SIZE * GRID_ROWS;

final static color COLOR_DEFAULT = #2244FF;
final static color COLOR_OVER    = #FF4422;
color cellColor;

float angle;
float noiseScale = 0.01;
float noiseX, noiseY;

float origX, origY;
float scrX0, scrY0;
float scrX, scrY;
PVector transform;

void setup()
{
  size(800, 800);
  smooth();
  origX = width / 2;
  origY = height / 2;
  noiseX = mouseX; noiseY = mouseY;
  cellColor = COLOR_DEFAULT;
}

void draw()
{
  background(#ABCDEF);

  noiseX += noiseScale; noiseY += noiseScale;
  float noiseVal = noise(noiseX, noiseY);

  angle = noiseVal * TWO_PI;

pushMatrix();
  translate(origX, origY);
  rotate(angle);
  translate(-GRID_WIDTH/2, -GRID_HEIGHT/2);
  // Take coordinates of top-left corner on screen
  scrX = screenX(0, 0);
  scrY = screenY(0, 0);
  scrX0 = screenX(GRID_WIDTH/2, GRID_HEIGHT/2);
  scrY0 = screenY(GRID_WIDTH/2, GRID_HEIGHT/2);
  transform = new PVector(scrX, scrY);
  DrawGrid();
popMatrix();

  // Try and highlight grid's corners
  PVector tl = new PVector(scrX, scrY);
//  tl.add(transform);
  DrawPoint(tl);
  DrawPoint2(new PVector(scrX, scrY));
  DrawPoint2(new PVector(scrX0, scrY0));
/*
  PVector bl = new PVector(origX, origY + GRID_HEIGHT);
  bl.add(transform);
  DrawPoint(bl);
  PVector tr = new PVector(origX + GRID_WIDTH, origY);
  tr.add(transform);
  DrawPoint(tr);
  PVector br = new PVector(origX + GRID_WIDTH, origY + GRID_HEIGHT);
  br.add(transform);
  DrawPoint(br);

  tl = new PVector(origX, origY);
  tl.sub(transform);
  DrawPoint2(tl);
  bl = new PVector(origX, origY + GRID_HEIGHT);
  bl.sub(transform);
  DrawPoint2(bl);
  tr = new PVector(origX + GRID_WIDTH, origY);
  tr.sub(transform);
  DrawPoint2(tr);
  br = new PVector(origX + GRID_WIDTH, origY + GRID_HEIGHT);
  br.sub(transform);
  DrawPoint2(br);
*/
}

void mouseMoved()
{
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
/*
  stroke(#00FF00);
  for (int r = -height/2; r < height/2; r += GRID_CELL_SIZE)
  {
    for (int c = -width/2; c < width/2; c += GRID_CELL_SIZE)
    {
      line(c, -height/2, c, height/2); line(-width/2, r, width/2, r);
    }
  }
*/
  fill(cellColor);
  stroke(0);
  for (int r = 0; r < GRID_ROWS; r++)
  {
    for (int c = 0; c < GRID_COLS; c++)
    {
      rect(0, 0, GRID_CELL_SIZE, GRID_CELL_SIZE);
      translate(GRID_CELL_SIZE, 0);
    }
    translate(-GRID_CELL_SIZE * (GRID_ROWS + 2), GRID_CELL_SIZE);
  }
}

void DrawPoint(PVector pt)
{
  fill(#FF0000);
  noStroke();
  ellipse(pt.x, pt.y, 5, 5);
}

void DrawPoint2(PVector pt)
{
  fill(#FFFF00);
  noStroke();
  rect(pt.x, pt.y, 5, 5);
}

/*
void Null()
{
  PVector mouse = new PVector(mouseX, mouseY);
  // Apply transform
  mouse = mouse.add(transform);
}
*/
