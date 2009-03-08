class AlgenKlasse
{
  int posX, posY;
  color sCol, fCol;

  AlgenKlasse() // Default constructor, with hopefully sensible default values
  {
    posX = width / 2; posY = height / 2;
    sCol = #005500;
    fCol = #00FF00;
  }

  AlgenKlasse(int x, int y, color sc, color fc)
  {
    posX = x; posY = y;
    sCol = sc; fCol = fc;
  }

  void draw()
  {
    stroke(sCol);
    fill(fCol);

    pushMatrix();
    translate(posX, posY);

    beginShape();
    // I suppose this is the origin point, so I set these coordinates to 0
    // and substract them from the other vertices
    vertex(0, 0);
    bezierVertex(7, -47, 5, -59, -8, -116);
    bezierVertex(-8, -116, -13, -89, -2, -34);
    endShape();

    popMatrix();
  }
}

final int ALGAE_NB = 20;
AlgenKlasse[] ak;
int curPos = 0;

void setup()
{
  smooth();
//~   noLoop();// No animation
  size(800, 800);

  ak = new AlgenKlasse[ALGAE_NB];
  ak[0] = new AlgenKlasse();  // Just to show default constructor use... ;)
  for (int i = 1; i < ALGAE_NB; i++)
  {
    ak[i] = new AlgenKlasse(int(random(10, 200)), int(random(70, height)),
        color(0, random(64, 200), random(0, 100)), color(0, random(128, 255), random(0, 128)));
  }
}

void draw()
{
  background(11, 55, 77);
  pushMatrix();
  translate(curPos, 0);

  for (int i = 0; i < ALGAE_NB; i++)
  {
    ak[i].draw();
  }

  popMatrix();
  curPos++;
}
