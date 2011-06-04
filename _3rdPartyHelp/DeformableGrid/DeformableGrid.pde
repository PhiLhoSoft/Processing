final int numNodesX = 20;
final int numNodesY = 40;

final int xInc = 50;
final int yInc = 20;
final int xMargin = 50;
final int yMargin = 50;

final int bBoxX = numNodesX * xInc + 2 * xMargin;
final int bBoxY = numNodesY * yInc + 2 * yMargin;

final int MOVER_NB = 3;
float interval = (float) (bBoxY - 2 * yMargin) / MOVER_NB;

Mover[] movers = new Mover[MOVER_NB];

Node[][] nodeList = new Node[numNodesX][numNodesY];

boolean bDebug = false;

void setup() {
  size(bBoxX, bBoxY);

  for (int i=0; i<numNodesX; ++i) {
    for (int j=0; j<numNodesY; ++j) {
      // make a vector
      PVector pos = new PVector(i*xInc+xMargin, j*yInc+yMargin);
      // make a particle
      Node newN = new Node(pos);
      nodeList[i][j] = newN;
    }
  }

if (bDebug) println("Height: " + height + ", interval: " + interval);
  float curPos = yMargin + interval / 2;
  for (int i = 0; i < MOVER_NB; i++) {
    movers[i] = new Mover((int) curPos, (int) interval, random(-PI, PI));
    curPos += interval;
  }
//  noLoop();
}

void draw() {
  background(250);

  for (int i=0; i<numNodesX; ++i) {
    for (int j=0; j<numNodesY; ++j) {
      nodeList[i][j].update();
    }
    bFirst = false;
  }

  // Debug drawing
if (bDebug)
{
  strokeWeight(2);
  for (Mover mover : movers) {
    stroke(#FF5555);
    line(xMargin, mover.origin, width - xMargin, mover.origin);
    stroke(#885555);
    line(xMargin, mover.origin - interval / 2, width - xMargin, mover.origin - interval / 2);
    line(xMargin, mover.origin + interval / 2, width - xMargin, mover.origin + interval / 2);
  }
}

  stroke(180);
  strokeWeight(1);
  noFill();
  drawVerticalLine(0);
  for (int i=1; i<numNodesX; ++i) {
    for (int j=0; j<numNodesY; ++j) {

      Node n1 = nodeList[i][j];
      Node n2 = nodeList[i-1][j];

      drawLine(n1, n2);

    }

    drawVerticalLine(i);
  }
  
  for (Mover mover : movers) {
    mover.update();
  }
}

class Node {

  PVector pos;
  float offset;

  Node(PVector pos_) {
    pos = pos_;
  }

  void update() {
    for (int i = 0; i < MOVER_NB; i++) {
      if (movers[i].isMoverOK(pos.y)) {
        offset = movers[i].getMove(pos.x, pos.y);
        break;
      }
    }
//    offset = 0;
    strokeWeight(4);
    stroke(255, 0, 0);
    point(pos.x, pos.y + offset);
  }
}

// The following functions assume drawing parameters are already set

void drawLine(Node n1, Node n2)
{
  line(n1.pos.x, n1.pos.y + n1.offset, n2.pos.x, n2.pos.y + n2.offset);
}

void drawVerticalLine(int n)
{
  Node n1 = nodeList[n][0];
  Node n2 = nodeList[n][numNodesY-1];
  drawLine(n1, n2);
}

boolean bFirst = true;
class Mover
{
  // Starting angle
  float start;
  // The vertical center of the move
  int origin;
  // The scope of the move, amplitude above and below the origin
  int scope;

  Mover(int origin_, int scope_, float start_)
  {
    origin = origin_;
    scope = scope_ / 2;
    start = start_;
  }

  boolean isMoverOK(float posY)
  {
    return posY >= origin - scope && posY <= origin + scope;
  }

  float getMove(float posX, float posY)
  {
if (bDebug)
{
strokeWeight(20 * getAmount(posY));
stroke(0, 255, 0);
point(posX, posY);
}
    return scope / 2 * sin(start + 4 * PI * posX / width) * getAmount(posY);
  }
  
  void update()
  {
    start += PI / 200;
  }

  private float getAmount(float posY)
  {
    // The farther we are from the origin, the less amount we have
    // Amount is between -1 and 1
    float amount = (posY - origin) / scope;
if (bDebug && bFirst) println(posY + " " + origin + " -> " + amount);
    return 1.0 - abs(amount);
  }
}

