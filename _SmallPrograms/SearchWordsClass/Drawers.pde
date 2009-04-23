Drawer defaultDrawer = new PlainColor(#7F7F7F);

interface Drawer
{
  void Draw(String message, int x, int y, int frame);
}

class PlainColor implements Drawer
{
  color col;

  PlainColor(color c)
  {
    col = c;
  }
  void Draw(String message, int x, int y, int frame)
  {
    fill(col);
    text(message, x, y);
    // I don't use frame here
  }
}

class Fade implements Drawer
{
  color col1, col2;

  Fade(color c1, color c2)
  {
    col1 = c1;
    col2 = c2;
  }
  void Draw(String message, int x, int y, int frame)
  {
    fill(lerpColor(col1, col2, frame / (float) DISPLAY_TIME));
    text(message, x, y);
  }
}

class Growing implements Drawer
{
  Growing()
  {
  }
  void Draw(String message, int x, int y, int frame)
  {
    fill(0);
    textSize(lerp(0, DISPLAY_FONT_SIZE, frame / (float) DISPLAY_TIME));
    text(message, x, y);
  }
}

class Shrinking implements Drawer
{
  Shrinking()
  {
  }
  void Draw(String message, int x, int y, int frame)
  {
    float a = frame / (float) DISPLAY_TIME;
    pushStyle();
    fill(0);
    textSize(lerp(DISPLAY_FONT_SIZE, 0, a));
    float posX = lerp(width - textWidth(message), x, a);
    float posY = lerp(height - DISPLAY_FONT_SIZE, y, a);
    text(message, posX, posY);
    popStyle();
  }
}

