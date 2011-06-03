final int numNodesX = 20;
final int numNodesY = 10;

final int xInc = 50;
final int yInc = 35;
final int xMargin = 50;
final int yMargin = 50;

final int bBoxX = numNodesX * xInc + 2 * xMargin;
final int bBoxY = numNodesY * yInc + 2 * yMargin;

Node[][] nodeList;

ArrayList lineList;

void setup() {
  size(bBoxX, bBoxY);

  nodeList = new Node[numNodesX][numNodesY];

  for (int i=0; i<numNodesX; ++i) {
    for (int j=0; j<numNodesY; ++j) {
      // make a vector
      PVector pos = new PVector(i*xInc+xMargin, j*yInc+yMargin);
      // make a particle
      Node newN = new Node(pos);
      nodeList[i][j] = newN;
    }
  }
}

void draw() {
  background(250);

  for (int i=0; i<numNodesX; ++i) {
    for (int j=0; j<numNodesY; ++j) {
      nodeList[i][j].update();
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
}

class Node {

  PVector pos;

  Node(PVector pos_) {
    pos = pos_;
  }

  void update() {
    strokeWeight(4);
    stroke(255,0,0);
    point(pos.x, pos.y);
  }
}

// The following functions assume drawing parameters are already set

void drawLine(Node n1, Node n2) {
  line(n1.pos.x, n1.pos.y, n2.pos.x, n2.pos.y);
}

void drawVerticalLine(int n) {
  Node n1 = nodeList[n][0];
  Node n2 = nodeList[n][numNodesY-1];
  drawLine(n1, n2);
}

