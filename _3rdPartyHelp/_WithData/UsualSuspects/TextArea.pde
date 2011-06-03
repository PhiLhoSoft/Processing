class TextArea implements Comparable {
  int x, y;
  int endPoint;
  int textAreaWidth;
  String align;
  int id;
  boolean useLeft;
  boolean useRight;
  boolean leftInPosition;
  boolean rightInPosition;

  TextArea(int x, int y, String align, int id, boolean useLeft, boolean useRight) {
    this.x = x;
    this.y = y;
    this.align = align;
    this.id = id;
    this.useLeft = useLeft;
    this.useRight = useRight;
  }

  String toString() {
    return "id: " + id + "\ttextAreaWidth: " + textAreaWidth + "\tx: " + x + "\ty: " + y + "\tendPoint: " + endPoint + "\talign: " + align;
  }

  void setEndPoint(int endPoint){
    this.endPoint = endPoint;
    textAreaWidth = endPoint-x;
  }

  void display() {
    pushStyle();
    rectMode(CORNERS);
    noFill();
    stroke(128, 128);
    rect(x, y, endPoint, y+lineHeight);
    popStyle();
  }

  int compareTo(Object anotherTextArea) throws ClassCastException {
    if (!(anotherTextArea instanceof TextArea)) {
      throw new ClassCastException(" A TextArea object expected.");
    }
    return int(textAreaWidth - ((TextArea) anotherTextArea).textAreaWidth);
  }
}


