PImage red, blue;
PGraphics image;

void setup()
{
  size(1024, 768);
  
  red = loadImage("H:/PhiLhoSoft/images/foret_0003_1024.jpg");
  blue = loadImage("H:/PhiLhoSoft/images/Hiver.jpg");
  image = createGraphics(width, height, JAVA2D);
  image(red, 0, 0);
  image(blue, width / 2, height / 2);
}

void draw()
{
  int c = 0;
  for (int i = 0; i < 16; i++)
  {
    for (int j = 0; j < 144; j++)
    {
      image.beginDraw();
      if (c % 2 == 0)
      {
        image.image(red, 0, 0);
      }
      else
      {
        image.image(blue, 0, 0);
      }
      
      String text = nf(c, 4);
      image.fill(255);
      image.textSize(128);
      image.text(text, (width - textWidth(text)) / 2, height / 2);
      
      if (c % 2 == 0)
      {
        image.fill(#88CCFF);
      }
      else
      {
        image.fill(#FFCC88);
      }
      image.textSize(72);
      float tw = image.textWidth(text);
      image.text(text, 20, 80);
      image.text(text, width - tw - 20, 80);
      image.text(text, 20, height - 80);
      image.text(text, width - tw - 20, height - 80);
      
      String subText = nf(j, 3) + " / " + nf(i, 2); 
      image.text(subText, (width - textWidth(subText)) / 2, height / 2 + 72);
      image.endDraw();
      print(text + " ");
      
      image.save("H:/PhiLhoSoft/images/Pauline/img" + text + ".jpg");
      c++;
    }
  }
  exit();
}

