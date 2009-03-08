//String lines[] = loadStrings("text3.txt");
// Too lazy to create the file...
String lines[] = 
{
    "A", "S", "C", "T", "B", "S", "H", "B", "C", "H",
    "H", "T", "B", "A", "H", "C", "S", "T", "S", "T",
    "T", "B", "A"
};

void init()
{
  println("INIT");
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();
}

void setup()
{
  size(400, 400);
  smooth();
  noLoop();
  ellipseMode(CORNER);
  rectMode(CORNER);

  println("SETUP");
  
  int posX = 0, posY = 0;
  int shapeSize = 40;
  for (int i = 0; i < lines.length; i++)
  {
//    println(lines[i]);
    if (lines[i].equals("A"))
    {
      fill(#000080);
      triangle(posX, posY + shapeSize,
          posX + shapeSize, posY + shapeSize,
          posX + shapeSize/2, posY);
    }
    else if (lines[i].equals("B"))
    {
      fill(#880000);
      ellipse(posX, posY, shapeSize, shapeSize);
    }
    else if (lines[i].equals("C"))
    {
      fill(#FF0000);
      arc(posX, posY, 2*shapeSize, shapeSize, PI - PI/3, PI + PI/3);
    }
    else if (lines[i].equals("H"))
    {
      fill(#008000);
      rect(posX, posY, shapeSize, shapeSize);
    }
    else if (lines[i].equals("S"))
    {
      fill(#0000FF);
      ellipse(posX, posY, shapeSize, shapeSize);
    }
    else if (lines[i].equals("T"))
    {
      fill(#00FF00);
      rect(posX, posY, shapeSize, shapeSize);
    }
    posX += shapeSize;
    if ((i + 1) % 10 == 0)
    {
      posX = 0; posY += shapeSize;
    }
  }
}

void mousePressed()
{
  println(frame.getLocation() + " " + frame.getLocationOnScreen());
  frame.setLocation(mouseX, mouseY);
}

