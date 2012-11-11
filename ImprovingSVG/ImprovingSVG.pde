PShape bot, chessboard, usa;
PShape circles, chessK, check, checkGR, arrowHeart;
float angle;
boolean bStatic = true;
boolean bGradients = false;

void setup()
{
  size(800, 800);
  smooth();

  bot = loadPLShape("bot1.svg");
//  usa = loadPLShape("usa-wikipedia.svg");
  // Chess shapes from Wikipedia
  chessboard = loadPLShape("Chess_Board.svg");
  chessK = loadPLShape("Chess_klt45.svg");
//  PShape chessB = loadPLShape("Chess_blt45.svg"); // Uses unsupported arc
  circles = loadPLShape("ThreeCircles.svg");
  // Custom personal shape
  check = loadPLShape("Check.svg");
  // Idem, with gradient
  checkGR = loadPLShape("Check_gr.svg");
  // Two kinds of gradients
  arrowHeart = loadPLShape("ArrowHeart.svg");

  loadGradients();

  drawEverything();
}

void draw()
{
  if (bStatic)
    return;

  shape(chessboard, 0, 0, width, height);
//  shape(usa, 0, 0, width, height);

  // Put in place
  translate(mouseX, mouseY);
  // Do the rotation around the top-left corner
  rotate(angle);
  angle += 0.01;
  // Re-center the shape
  translate(-bot.width / 2, -bot.height / 2);
  // Draw it
  shape(bot, 0, 0);
}

void drawEverything()
{
  if (bGradients)
  {
    drawGradients();
    return;
  }
  background(#DDEEFF);

  chessboard.disableStyle();
  fill(#884422); noStroke();
  shape(chessboard, 0, 0, width, height);
//  shape(usa, 0, 0, width, height);

  drawShapeAndOrigin(circles, 10, 10, #FFAA55);
  drawShapeAndOrigin(check, 100, 300, 200, 200, #FFAA55);
  drawShapeAndOrigin(check, 300, 300, 500, 500, #FFAA55);
  drawShapeAndOrigin(checkGR, 100, 600, checkGR.width / 3, checkGR.height / 3, #00FF55);
  // Why are they drawn without gradient?!
  drawShapeAndOrigin(arrowHeart, 300, 300, arrowHeart.width * 0.65, arrowHeart.height * 0.65, #00FF55);
  drawShapeAndOrigin(arrowHeart, 450, 0, #00FF55);

  bot.disableStyle();
  stroke(#FF0000);
  fill(#88EEFF);
  shapeMode(CENTER);
  shape(bot, 100, 100, 100, 100);

  bot.enableStyle();
  shapeMode(CORNER);
  drawShapeAndOrigin(bot, 100, 100, 100, 100, #FF0055);
  drawShapeAndOrigin(bot, 500, 400, 200, 200, #FF0055);

  drawShapeAndOrigin(chessK, 20, 700, #00FF55);
  drawShapeAndOrigin(chessK, 100, 500, 100, 100, #00FF55);
  drawShapeAndOrigin(chessK, 620, 220, 200, 200, #00FF55);
  drawShapeAndOrigin(chessK, 250, 70, 300, 300, #00FF55);
}

void drawShapeAndOrigin(PShape shape, float xPos, float yPos, float sWidth, float sHeight, color originColor)
{
  shape(shape, xPos, yPos, sWidth, sHeight);
  pushStyle();
  fill(originColor); noStroke();
  ellipse(xPos, yPos, sWidth / 25, sHeight / 25);
  popStyle();
}

void drawShapeAndOrigin(PShape shape, float xPos, float yPos, color originColor)
{
  shape(shape, xPos, yPos);
  pushStyle();
  fill(originColor); noStroke();
  ellipse(xPos, yPos, 5, 5);
  popStyle();
}

String[] gradientShapes =
{
  "ArrowHeart.svg",
//  "Beetle_icon.svg", // Uses elliptical arc, to keep for further tests!
//  "Blue_Edison_lamp.svg", // Idem
//  "Book.svg",  // TODO: a gradient use 'white' as stop-color
//  "Bookmark.svg", // Idem
  "Check_gr.svg",
//  "Crystal_128_error.svg", // Uses filters...
//  "Deletion_icon.svg", // TODO: java.lang.ArrayIndexOutOfBoundsException: 0 at processing.core.PShapeSVG$RadialGradientPaint$RadialGradientContext.getRaster
  "Google_plus.svg",
//  "Globe1.svg",
//  "Hourglass_2.svg",
};
PShape[] shapes;
void loadGradients()
{
  shapes = new PShape[gradientShapes.length];
  for (int i = 0; i < gradientShapes.length; i++)
  {
    shapes[i] = loadPLShape(gradientShapes[i]);
  }
}
// Specifically show shapes with gradients from Inkscape and Illustrator, images from Wikipedia too
void drawGradients()
{
  noStroke();
  int nb = 20;
  int szW = width / nb;
  int szH = height / nb;
  for (int i = 0; i < nb; i++)
  {
    for (int j = 0; j < nb; j++)
    {
      fill((i + j) % 2 == 0 ? #F0F0FF : #557755);
      rect(i * szW, j * szH, szW, szH);
    }
  }
  shapeMode(CORNER);
  for (int i = 0; i < shapes.length; i++)
  {
//    println(gradientShapes[i]);
    drawShapeAndOrigin(shapes[i], i * 200, i * 200, 200, 200, #FFCC55);
  }
}

void mousePressed()
{
  bStatic = !bStatic;
  if (bStatic)
  {
    resetMatrix();
    drawEverything();
  }
}

void keyPressed()
{
  if (key == 'g' && bStatic)
  {
    bGradients = !bGradients;
    drawEverything();
  }
}

