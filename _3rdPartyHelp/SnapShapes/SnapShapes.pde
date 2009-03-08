// Lists' objects interaction mess <http://processing.org/discourse/yabb_beta/YaBB.cgi?board=Syntax;action=display;num=1230492855>

BoxList boxes;
CircleList circles;

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
  background(222);
  // Boxes
  boxes.display();
  circles.display();
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
  switch (keyCode) {
    case 'B':
      boxes.add(new Box(100, 100));
      break;
    case 'C':
      circles.add(new Circle(100, 100));
      break;
    case 'D': // Debug...
      for (int i = 0; i < boxes.size(); i++) {
        Box box = (Box) boxes.get(i);
        println("B" + i + ": " + box.posX + " " + box.posY);
      }
      for (int i = 0; i < circles.size(); i++) {
        Circle circle = (Circle) circles.get(i);
        println("C" + i + ": " + circle.posX + " " + circle.posY);
      }
      break;
  }
}

// Abstract so it cannot be instanciated
public abstract class Shape {
  // No need to initialize class fields to default values
  float posX;
  float posY;

  protected float sWidth;
  protected float sHeight;

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

  Shape(float w, float h) {
    posX = mouseX;
    posY = mouseY;
    sWidth = w;
    sHeight = h;
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
  public boolean isLocked() {
    return isLocked;
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
  Box(float w, float h) {
    super(w, h);
  }

  void showShape() {
    strokeWeight(2);
    stroke(128);
    rect(0, 0, sWidth, sHeight);
  }
}

class Circle extends Shape {
  boolean locked;

  Circle(float w, float h) {
    super(w, h);
  }

  void showShape() {
    strokeWeight(1);
    stroke(128);
    ellipse(0, 0, sWidth, sHeight);
  }

  protected void onMouseReleased() {
    super.onMouseReleased();
    for (int i = 0; i < boxes.size(); i++) {
      Box box = (Box) boxes.get(i);
      if (posX >= box.posX - 2 * box.sWidth &&
          posX <= box.posX + 2 * box.sWidth &&
          posY >= box.posY + box.sHeight / 2 &&
          posY <= box.posY + box.sHeight * 2) {
        locked = true;
        // Reposition the circle
        posX = box.posX;
        posY = box.posY + box.sHeight;
        break;
       }
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
      if (keyPressed && key == CODED && keyCode == SHIFT && get(i).isLocked()) {
        // Shift drag, we drag only the first shape found under the cursor
        // Helps when two circles snap to the same location...
        break;
      }
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
