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
      PVector tmpPos = new PVector(i*xInc+xMargin, j*yInc+yMargin);
      // make a particle
      Node newN = new Node(tmpPos);
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
  for (int i=1; i<numNodesX; ++i) {
    for (int j=0; j<numNodesY; ++j) {

        Node n1 = nodeList[i][j];
        Node n2 = nodeList[i-1][j];

        line(n1.pos.x, n1.pos.y, n2.pos.x, n2.pos.y);

    }

	Node n1 = nodeList[i][0];
	Node n2 = nodeList[i][numNodesY-1];

	line(n1.pos.x, n1.pos.y, n2.pos.x, n2.pos.y);
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
