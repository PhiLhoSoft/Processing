BoxList boxes;
CircleList circles;
Box boxx; Circle circle;

void setup() {
  noStroke();
  size(800, 800);
  frameRate(60);
  rectMode(CENTER);
  ellipseMode(CENTER);  // Default...

  boxes = new BoxList();
  circles = new CircleList();
}

void draw() {
  background(100, 100, 100);
  // Boxes
  boxes.display();
  circles.display();

  // Pick latest box
  if (boxes.size() > 0)
    boxx = boxes.get(boxes.size() - 1);
  if (circles.size() > 0)
    circle = circles.get(circles.size() - 1);
}

void mousePressed() {
  boxes.onMousePressed();
  circles.onMousePressed();
}
void mouseDragged() {
  boxes.onMouseDragged();
  circles.onMouseDragged();
}
void mouseReleased() {
  boxes.onMouseReleased();
  circles.onMouseReleased();
}

void keyReleased() {
  if (keyCode == 'B') {
    boxes.add(new Box(100, 100));
  }
  if (keyCode == 'C') {
    circles.add(new Circle(100, 100));
  }
}

// Abstract so it cannot be instanciated
public abstract class Shape {
  // No need to initialize class fields to default values
  float posX;
  float posY;

  protected float sWidth = 100;
  protected float sHeight = 100;

  private boolean isOver;
  private boolean isLocked;
  private float difx;
  private float dify;

  // Can be changed per shape
  color baseColor = color(255, 255, 255);
  // Should be static (ie. shared by all instances) but cannot here
  color moveColor = color(255, 128, 128);
  // Color of this instance
  color sColor = baseColor;

  Shape(float xxx, float yyy) {
    posX = xxx;
    posY = yyy;
  }

  void display() {
    fill(sColor);
    pushMatrix();
    translate(posX, posY);
    showShape();
    popMatrix();
  }
  abstract protected void showShape();

  // Might be overridden depending on shape
  protected boolean isOver() {
    // Picking
    return mouseX > posX - sWidth/2 && mouseX < posX + sWidth/2 &&
        mouseY > posY - sHeight/2 && mouseY < posY + sHeight/2;
  }

  protected void onMousePressed() {
    if (mouseButton == LEFT) {
      if (isOver()) {
        isLocked = true;
        sColor = moveColor;
        difx = mouseX - posX;
        dify = mouseY - posY;
      } else {
        isLocked = false;
        sColor = baseColor;
      }
    }
  }

  protected void onMouseDragged() {
    if (mouseButton == LEFT && isLocked) {
      posX = mouseX - difx;
      posY = mouseY - dify;
    }
  }

  protected void onMouseReleased() {
    isLocked = false;
    sColor = baseColor;
  }
}

public class Box extends Shape {
  Box(float xxx, float yyy) {
    super(xxx, yyy);
  }

  void showShape() {
    strokeWeight(1);
    rect(0, 0, sWidth, sHeight);
  }
}

class Circle extends Shape {
  boolean spaceoverbottom = false;
  boolean locktobottom = true;

  Circle(float xxx, float yyy) {
    super(xxx, yyy);
  }

  void showShape() {
    noStroke();
    ellipse(0, 0, sWidth, sHeight);
  }

  protected void onMouseReleased() {
    super.onMouseReleased();
    if (locktobottom && circle != null && boxx != null) {
      if (circle.posY+100 >= boxx.posY+150 && circle.posY-300 <= boxx.posY-50 &&
          circle.posX >= boxx.posY-200 && circle.posX <= boxx.posX+150)
      {
        spaceoverbottom = true;
      } else {
        spaceoverbottom = false;
      }
    }
    if (spaceoverbottom) {
      posX = boxx.posX;
      posY = boxx.posY + 100;
    }
  }
}

abstract class ShapeList extends ArrayList {
  Shape get(int i) {
    return (Shape) super.get(i);
  }
  void display() {
    for (int i = 0; i < size(); i++) {
      get(i).display();
    }
  }
  void onMousePressed() {
    for (int i = 0; i < size(); i++) {
      get(i).onMousePressed();
    }
  }
  void onMouseDragged() {
    for (int i = 0; i < size(); i++) {
      get(i).onMouseDragged();
    }
  }
  void onMouseReleased() {
    for (int i = 0; i < size(); i++) {
      get(i).onMouseReleased();
    }
  }
}

class BoxList extends ShapeList {
  Box get(int i) {
    return (Box) super.get(i);
  }
}

class CircleList extends ShapeList {
  Circle get(int i) {
    return (Circle) super.get(i);
  }
}
