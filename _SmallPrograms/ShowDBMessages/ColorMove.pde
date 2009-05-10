class ColorMove implements Drawer
{
  String message;
  color col1, col2;
  float duration;

  ColorMove(String m, color c1, color c2, float d)
  {
    message = m;
    col1 = c1;
    col2 = c2;
    duration = d;
  }
  void Draw(int frame)
  {
    float a = frame / (GetDuration() * frameRate);
    pushStyle();
    fill(lerpColor(col1, col2, a));
    float posX = lerp(width - textWidth(message), 0, a);
    float posY = lerp(height - BASE_DISPLAY_FONT_SIZE, 0, a);
    text(message, posX, posY);
    popStyle();
  }
  float GetDuration()
  {
    return duration;
  }
}
