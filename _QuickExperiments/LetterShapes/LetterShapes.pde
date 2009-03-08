LetterShape lI, lY, lZ;
void setup()
{
  size(800, 400);
  smooth();
  int pos = 0;
  lI = new LetterI(this, pos, 0);
  pos += LetterShape.RECT_SCALE * (1 + LetterI.WIDTH);
  lZ = new LetterZ(this, pos, 0);
  pos += LetterShape.RECT_SCALE * (1 + LetterZ.WIDTH);
  lY = new LetterY(this, pos, 0);
}

void draw()
{
  background(200);
  fill(#195060);
  translate(mouseX, mouseY);
  lI.drawLetter();
  lZ.drawLetter();
  lY.drawLetter();
  // Matrix is reset here
}

