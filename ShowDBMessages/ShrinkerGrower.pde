class Shrinker implements Drawer
{
  String message;
  color col;

  Shrinker(String m, color c)
  {
    message = m;
    col = c;
  }
  void Draw(int frame)
  {
    float a = frame / (float) (GetDuration() * frameRate);
    pushStyle();
    fill(col);
    textSize(lerp(BASE_DISPLAY_FONT_SIZE, 0, a));
    float posX = lerp(width - textWidth(message), 0, a);
    float posY = lerp(height - BASE_DISPLAY_FONT_SIZE, 0, a);
    text(message, posX, posY);
    popStyle();
  }
  float GetDuration()
  {
    return BASE_MESSAGE_DISPLAY_TIME * 2;
  }
}

class Grower implements Drawer
{
  String message;
  color col;

  Grower(String m, color c)
  {
    message = m;
    col = c;
  }
  void Draw(int frame)
  {
    float a = frame / (float) (GetDuration() * frameRate);
    pushStyle();
    fill(col);
    textSize(lerp(0, BASE_DISPLAY_FONT_SIZE, a));
    float posX = lerp(width - textWidth(message), 0, a);
    float posY = lerp(height - BASE_DISPLAY_FONT_SIZE, 0, a);
    text(message, posX, posY);
    popStyle();
  }
  float GetDuration()
  {
    return BASE_MESSAGE_DISPLAY_TIME * 2;
  }
}

