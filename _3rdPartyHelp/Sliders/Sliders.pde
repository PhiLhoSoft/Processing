Slider sliderA;
Slider sliderB;

int topRowY = 4;
int topRowY2 = 306;
int midRowY = 348;
int midRowY2 = 568;
int bottomRowY = 610;
int bottomRowY2 = 674;


void setup() {

  size(1008, bottomRowY2+4);
  rectMode(CORNER);
  smooth();
  background(255);

  sliderA = new Slider(topRowY2 + 2, 5, 1);
  sliderB = new Slider(midRowY2 + 2, 64, 5);
}


void draw() {
  background(255);

  sliderA.display();
  sliderB.display();

  boolean isOverA = sliderA.mouseOverCheck();
  boolean isOverB = sliderB.mouseOverCheck();
  if (isOverA || isOverB) cursor(HAND);
  else cursor(CROSS);
}

void mousePressed() {
  sliderA.pressed();
  sliderB.pressed();
}

void mouseDragged() {

  sliderA.dragged();
  sliderB.dragged();
}

void mouseReleased() {
  sliderA.released();
  sliderB.released();
}


class Slider {

  //these are global variables for the class
  int daysInRow;
  int daysInBracket;
  int arrowHeight = 16;
  int arrowWidth = 10;
  int bracketWidth;
  int bracketHeight = 10;
  int xPos = 4;
  int yPos;
  int sWidth; // Here I don't use width to avoid masking the global 'width' variable

  int handlePosition;

  boolean isOver;
  boolean isLocked;

  //this is the constructor

  Slider(int tempyPos, int tempDaysInRow, int tempDaysInBracket) {

    daysInRow = tempDaysInRow;
    daysInBracket = tempDaysInBracket;

    yPos = tempyPos + bracketHeight;
    sWidth = width - 2 * xPos;
    //makes bracket width of the
    bracketWidth = (width / daysInRow) * daysInBracket;
    constrainHandle();
  }

  //these are functions that live within slider


  //draws the slider at the x position it is given in the parameter. x is middle of arrow/ bracket

  void display() {

    //draw rectangles to clear slider
    fill(255);
    noStroke();
    rectMode(CORNER);
    rect(xPos, yPos - bracketHeight, sWidth, yPos + arrowHeight + bracketHeight);


    //draw triangles
    fill(0);
    stroke(0);
    beginShape();
    vertex(handlePosition - arrowWidth/2, yPos);
    vertex(handlePosition + arrowWidth/2, yPos);
    vertex(handlePosition - arrowWidth/2, yPos + arrowHeight);
    vertex(handlePosition + arrowWidth/2, yPos + arrowHeight);
    endShape();

    //draw top bracket
    noFill();
    beginShape();
    vertex(xPos, yPos - bracketHeight);
    vertex(xPos, yPos);
    vertex(xPos + sWidth, yPos);
    vertex(xPos + sWidth, yPos - bracketHeight);
    endShape();

    //drawMovingBracket
    beginShape();
    vertex(handlePosition - bracketWidth/2, yPos + arrowHeight + bracketHeight);
    vertex(handlePosition - bracketWidth/2, yPos + arrowHeight);
    vertex(handlePosition + bracketWidth/2, yPos + arrowHeight);
    vertex(handlePosition + bracketWidth/2, yPos + arrowHeight + bracketHeight);
    endShape();
  }

  void constrainHandle() {
    handlePosition = constrain(mouseX, xPos + bracketWidth/2 + 4, sWidth - bracketWidth/2 - 4);
  }

  //this checks if mouse is over bracket and says "yea, hey, I'm totally over bracket"

  boolean mouseOverCheck() {

    isOver = mouseX > (handlePosition - arrowWidth/2 - 4) &&
        mouseX < (handlePosition + arrowWidth/2 + 4) &&
        mouseY > (yPos - 4) && mouseY < (yPos + arrowHeight + 4);
//    println(isOver);
// The two sliders are competiting for this one, must be resolved at global level
//    if (isOver) cursor(HAND);
//    else cursor(CROSS);
    return isOver;
  }

  void pressed() {

    isLocked = isOver;
  }

  void dragged() {

    if (isLocked) {

      constrainHandle();
      //println(handlePosition);
    }
  }

  void released() {
    isLocked = false;
  }
}
