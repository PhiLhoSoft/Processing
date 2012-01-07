String k = "";

void setup()
{
  size(1000, 50);
  smooth();
  textFont(createFont("Arial", 24));
  fill(0);
}

void draw()
{
  background(255);
  text(k, 10, 40);
}

void keyPressed()
{
  if (key != CODED)
  {
//    println(keyCode);
    if (keyCode == BACKSPACE)
    {
      int l = k.length();
      if (l > 0)
      {
        k = k.substring(0, k.length() - 1);
      }
    }
    else
    {
      k += key;
    }
  }// else println(keyCode);
}

