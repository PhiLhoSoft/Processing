PShape bot;
float angle;

void setup()
{
  size(600, 400);
  smooth();
  background(#DDEEFF);

  bot = loadShape("bot1.svg");
  PShape usa = loadShape("usa-wikipedia.svg");
  PShape chessK = loadShape("Chess_klt45+.svg");
//  PShape chessB = loadShape("Chess_blt45.svg"); // Uses unsupported arc

  shape(usa, 0, 0, width, height);

  shapeMode(CENTER);
  shape(bot, 50, 50, 50, 50);
  shapeMode(CORNER);
  shape(bot, 50, 50, 50, 50);
  shape(bot, 400, 0, 200, 200);

  shape(chessK, 100, 100, 100, 100);
  shape(chessK, 100, 200, 200, 200);
  shape(chessK, 200, 50, 300, 300);
}

void draw()
{
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
