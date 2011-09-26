class Node {
  int level;
  Node[] n;
  float x, y, r;

  Node(int level, int amountNodes, float x, float y, float r) {
    this.level = level;
    this.x = x;
    this.y = y;
    this.r = r;
    n = new Node[amountNodes];
  }

  void makeNodes(int borderX, int borderY) {
    int l = level + 1;
    for (int i = 0; i < n.length; i++) {
      n[i] = new Node(l,
          (int)random(1, 10), 
          random(x - borderX/2, x + borderX/2),
          random(y - borderY/2, y + borderY/2),
          5);
      if (level < MAX_LEVELS-1) {
        n[i].makeNodes(100 / l, 100 / l);
      }
    }
  }
  
  void display() {
//    println("L " + level + " N " + n.length);
    stroke(colors[level]);
    ellipse(x, y, r, r);
    
    if (level >= MAX_LEVELS)
      return; // No sub-nodes to display
    for (int i = 0; i < n.length; i++) {
      stroke(colors[level+1]);
      line(x, y, n[i].x, n[i].y);
      n[i].display();
    }
  }
}



