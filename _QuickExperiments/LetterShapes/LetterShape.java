import processing.core.*;

abstract class LetterShape
{
  static final int RECT_SCALE = 10;
  PApplet pa;

  int x, y; // Position
  // You can add other parameters like color...

  public LetterShape(PApplet pap, int posX, int posY)
  {
    pa = pap;
    x = posX;
    y = posY;
  }

  void drawLetter() // Not the global draw!
  {
    pa.pushMatrix();
    pa.translate(x, y);
    drawShape();
    pa.popMatrix();  // Undo translate
  }

  void drawRect(int px, int py, int w, int h)
  {
    pa.rect(px*RECT_SCALE, py*RECT_SCALE, w*RECT_SCALE, h*RECT_SCALE);
  }

  abstract void drawShape();
}

class LetterZ extends LetterShape
{
  public static final int WIDTH = 5;

  public LetterZ(PApplet p, int x, int y) { super(p, x, y); }

  void drawShape()
  {
    drawRect(1, 1, 5, 1);
    drawRect(4, 2, 2, 1);
    drawRect(2, 3, 3, 1);
    drawRect(1, 4, 2, 1);
    drawRect(1, 5, 5, 1);
  }
}

class LetterI extends LetterShape
{
  public static final int WIDTH = 1;

  public LetterI(PApplet p, int x, int y) { super(p, x, y); }

  void drawShape()
  {
    drawRect(1, 1, 1, 5);
  }
}

class LetterY extends LetterShape
{
  public static final int WIDTH = 3;

  public LetterY(PApplet p, int x, int y) { super(p, x, y); }

  void drawShape()
  {
    drawRect(1, 1, 1, 3);
    drawRect(2, 2, 1, 4);
    drawRect(3, 1, 1, 3);
  }
}

