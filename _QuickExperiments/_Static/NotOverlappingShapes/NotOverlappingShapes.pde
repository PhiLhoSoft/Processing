PGraphics pg;

String[] shapeNames = { "Rectangle", "Star" };
PShape[] shapes = new PShape[shapeNames.length];

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
    shapes[i] = loadShape("H:/Temp/" + shapeNames[i] + ".svg");
    shapes[i].disableStyle();
  }
  pg = createGraphics(700, 700);

//  noLoop();
  println(hex(backgroundColor));
  println(hex(stampColor));
  println(hex(fillColor));
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
  pg.beginDraw();
  pg.shapeMode(CENTER);
  pg.noSmooth();
  pg.noStroke(); 
  pg.background(backgroundColor);
  pg.fill(stampColor);
  drawShapes(pg);
  pg.endDraw();

  background(0);
  image(pg, 50, 50);
  
  println(isOverlapping(pg));
}

void drawShapes(PGraphics pg)
{
  for (int i = 0; i < shapes.length; i++)
  {
    float x = shapeWidth / 2 + random(pg.width - shapeWidth);
    float y = shapeHeight / 2 + random(pg.height - shapeHeight);
//    println(i + " " + x + ", " + y);
    pg.shape(shapes[i], x, y, shapeWidth, shapeHeight);
  }
}

boolean isOverlapping(PGraphics pg)
{
  pg.loadPixels();
  for (int i = 0; i < pg.pixels.length; i++)
  {
    color c = pg.pixels[i]; 
    if (c != backgroundColor && c != fillColor)
    {
      println(i + " " + hex(c));
      return true;
    }
  }
  return false;
}
