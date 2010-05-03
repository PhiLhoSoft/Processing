PShape bot, chessboard, usa;
float angle;
boolean bStatic = true;

void setup()
{
  size(800, 800);
  smooth();
  background(#DDEEFF);

  bot = loadShape("bot1.svg");
  chessboard = loadShape("Chess_Board.svg");
  usa = loadShape("usa-wikipedia.svg");
  // Chess shapes from Wikipedia
  // This one is modified so it doesn't appear all black
  // Change "black" to "#000000" and "white" to "#FFFFFF"
  PShape chessK = loadShape("Chess_klt45+.svg");
//  PShape chessB = loadShape("Chess_blt45.svg"); // Uses unsupported arc
  PShape check = loadShape("Check.svg");
  PShape checkGR = loadShape("Check_gr.svg");

  chessboard.disableStyle();
  fill(#884422); noStroke();
  shape(chessboard, 0, 0, width, height);
  shape(usa, 0, 0, width, height);

  fill(#FFAA55);
  shape(check, 100, 300, 200, 200);
  ellipse(100, 300, 4, 4);
  shape(check, 300, 300, 500, 500);
  ellipse(300, 300, 6, 6);
  shape(checkGR, 100, 600, 200, 200);
  ellipse(100, 600, 4, 4);

  bot.disableStyle();
  stroke(#FF0000);
  fill(#88EEFF);
  shapeMode(CENTER);
  shape(bot, 100, 100, 100, 100);

  // Markers of origin
  noStroke();
  fill(#FF0055);
  ellipse(100, 100, 4, 4);

  bot.enableStyle();
  shapeMode(CORNER);
  shape(bot, 100, 100, 100, 100);
  ellipse(100, 100, 4, 4);
  shape(bot, 500, 400, 200, 200);
  ellipse(500, 400, 5, 5);

  fill(#00FF55); 
  shape(chessK, 100, 500, 100, 100);
  ellipse(100, 500, 4, 4);
  shape(chessK, 480, 50, 200, 200);
  ellipse(480, 50, 5, 5);
  shape(chessK, 200, 70, 300, 300);
  ellipse(200, 70, 6, 6);
}

void draw()
{
  if (bStatic)
    return;
    
  shape(chessboard, 0, 0, width, height);
  shape(usa, 0, 0, width, height);

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

void mousePressed()
{
  bStatic = false;
}
