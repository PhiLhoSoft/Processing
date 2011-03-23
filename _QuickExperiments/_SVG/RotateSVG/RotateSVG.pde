PShape bot;
float angle;

int rx = 500, ry = 500;
int sx = 200, sy = 200;

void setup()
{
  size(800, 800);
  smooth();

  bot = LoadSVG("bot1.svg");
  shapeMode(CENTER);
}

void draw()
{
  background(#DDEEFF);

  // Static bot
  shape(bot, 100, 100, 50, 150);

  pushMatrix();
  translate(width/2, height/2);
  shape(bot, 0, 0, 100, 100);
  popMatrix();
 
  pushMatrix();
  // Go to the point around which the shape must rotate
  translate(rx, ry);
  // Rotate the coordinate system
  rotate(angle);
  pushMatrix();
  // Translate a bit to center the shape on a given point
  translate(sx * 0.37, sy * 0.23);
  // Draw the shape
  shape(bot, 0, 0, sx, sy);
  popMatrix();
  // Mark the rotation center
  showRotationCenter();
  popMatrix();

  translate(mouseX, mouseY);
  rotate(angle);
  showRotationCenter();
  // Translate toward top and left, to rotate around the bottom-right corner
  translate(-bot.width / 2, -bot.height / 2);
  shape(bot, 0, 0);
  
  angle += 0.01;
}

void showRotationCenter()
{
  noStroke();
  fill(#FF8800);
  ellipse(0, 0, 10, 10);
}

PShape LoadSVG(String name)
{
  File path = new File(sketchPath);
  // data path common to several sketches
  String dataPath = path.getParent() + File.separator + "data" + File.separator + name;
  return loadShape(dataPath);
}

