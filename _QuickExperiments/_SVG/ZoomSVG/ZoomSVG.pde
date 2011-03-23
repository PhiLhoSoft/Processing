PShape bot;

int posX, posY;
int clickX, clickY;
int sizeX, sizeY;
float scale = 1.0;
float scaleFactor = 2.0;

void setup()
{
  size(800, 800);
  smooth();
  frameRate(5); // Draw slowly to avoid tear effect
  
  posX = width / 2;
  posY = height / 2;
  sizeX = sizeY = 100;

  bot = LoadSVG("bot1.svg");
  shapeMode(CENTER);
}

void draw()
{
  background(#DDEEFF);

  translate(posX, posY);
  shape(bot, 0, 0, sizeX * scale, sizeY * scale);
}

PShape LoadSVG(String name)
{
  File path = new File(sketchPath);
  // data path common to several sketches
  String dataPath = path.getParent() + File.separator + "data" + File.separator + name;
  return loadShape(dataPath);
}

void mousePressed()
{
  clickX = int((mouseX - width/2) * scale);
  clickY = int((mouseY - height/2) * scale);
  if (mouseButton == LEFT)
  {
    scale *= scaleFactor;
  }
  else if (mouseButton == RIGHT)
  {
    scale /= scaleFactor;
  }
//  println(scale);
  println("C " + clickX + " " + clickY);
  println("P " + posX + " " + posY);
  posX -= clickX;
  posY -= clickY;
  println(posX + " " + posY);
}

