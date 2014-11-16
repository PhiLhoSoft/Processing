PGraphics pg;

String[] shapeNames = { "Rectangle", "Star" };
PShape[] baseShapes = new PShape[shapeNames.length];
ArrayList<PositionedShape> shapes = new ArrayList<PositionedShape>();

int shapeWidth = 150;
int shapeHeight = 150;

boolean update = true;

color backgroundColor = color(255); // White
color stampColor = color(0, 128); // Semi-transparent black
color fillColor = color(127); // Resulting color on the background

void setup() 
{
  size(800, 800);

  shapeMode(CENTER);
  noSmooth();
  noStroke(); 

  for (int i = 0; i < shapeNames.length; i++) 
  {
    baseShapes[i] = loadShape("H:/Temp/" + shapeNames[i] + ".svg");
    baseShapes[i].disableStyle();
  }
  pg = createGraphics(700, 700);
  pg.beginDraw();
  pg.shapeMode(CENTER);
  pg.noSmooth();
  pg.noStroke(); 
  pg.fill(stampColor);
  pg.endDraw();

//  noLoop();
  println(hex(backgroundColor));
  println(hex(stampColor));
  println(hex(fillColor));
  
  shapes.add(createNewShape());
}

void keyPressed() 
{
  update = true;
}

void draw() 
{
  if (!update)
    return;
    
  update = false;
  
  println(frameCount);
  PositionedShape shape;
  int count = 0;
  do
  {
    pg.beginDraw();
    pg.background(backgroundColor);
    drawShapes(pg);
  
    shape = createNewShape();
    drawShape(pg, shape);

    pg.endDraw();
  } while (isOverlapping(pg) && ++count < 10);
  if (count == 10)
  {
    println("Cannot find an empty place");
  }
  else
  {
    shapes.add(shape);
  }

  background(255);
//  image(pg, 50, 50);
  // Vectorial display of shapes
  drawShapes(g); // g is the sketch's PGraphics
  
  println();
}

PositionedShape createNewShape()
{
  int idx = int(random(baseShapes.length));
  float x = shapeWidth / 2 + random(pg.width - shapeWidth / 2);
  float y = shapeHeight / 2 + random(pg.height - shapeHeight / 2);
  color c = color(random(255), random(255), random(255));
  return new PositionedShape(baseShapes[idx], x, y, shapeWidth, shapeHeight, c);
}

void drawShapes(PGraphics pg)
{
  for (int i = 0; i < shapes.size(); i++)
  {
    drawShape(pg, shapes.get(i));
  }
}
void drawShape(PGraphics pg, PositionedShape shape)
{
  if (pg == g) // On main sketch
  {
    fill(shape.c);
  }
  pg.shape(shape.shape, shape.x, shape.y, shape.w, shape.h);
}

boolean isOverlapping(PGraphics pg)
{
  pg.loadPixels();
  for (int i = 0; i < pg.pixels.length; i++)
  {
    color c = pg.pixels[i]; 
    if (c != backgroundColor && c != fillColor)
    {
      println("Collision at " + i);
      return true;
    }
  }
  return false;
}

class PositionedShape
{
  float x, y;
  int w, h;
  color c;
  PShape shape;
  
  PositionedShape(PShape shape, float x, float y, int w, int h, color c)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.shape = shape;
  }
}
