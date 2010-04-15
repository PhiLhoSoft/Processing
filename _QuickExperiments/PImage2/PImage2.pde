int lineNb = 50;
int lengthIncrement = 7;
boolean bDoBlend;

void setup()
{
  size(500, 500);
  smooth();
  noLoop();
  background(#99EEFF);
  colorMode(HSB, 1000);

  DrawImage();
}

void draw() {} // To handle events

void keyPressed()
{
  PImage img = get();
  println(img.width + " x " + img.height);

  switch (key)
  {
  case 'b':
    // Activate
    bDoBlend = !bDoBlend;
    println("Blend? " + bDoBlend);
    break;
  case 'i':
    println("Inverted");
    DrawInverted(img);
    break;
  case 'r':
    println("Reflected");
    DrawReflected(img);
    break;
  case 's':
    println("Shifted");
    DrawShifted(img);
    break;
  }
  redraw();
}

void DrawImage()
{
  strokeWeight(7);
//  stroke(#005080);
  int cH = 200, cS = 1000, cB = 500;
  int lineLength = 5;
  int x, y;
  int px, py;
  px = x = width / 2;
  py = y = height / 2;
  
  for (int i = 0; i < lineNb; i++)
  {
    switch (i % 4)
    {
    case 0:
      x -= lineLength;
      break;
    case 1:
      y -= lineLength;
      break;
    case 2:
      x += lineLength;
      break;
    case 3:
      y += lineLength;
      break;
    }
    stroke(cH, cS, cB);
    cH += 1000 / lineNb;
    cS -= 1000 / lineNb;
    cB += 10;
    line(px, py, x, y);
    px = x; py = y;
    lineLength += lengthIncrement;
  }
}

void DrawInverted(PImage img)
{
  pushMatrix();
  translate(img.width, img.height);
  rotate(PI);
//  blend(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height, BLEND);
  image(img, 0, 0);
  popMatrix();
}

void DrawReflected(PImage img)
{
  pushMatrix();
  translate(0, img.height);
  scale(1.00, -1.00);
//  blend(img, 0, 0, img.width, img.height, 0, -img.height, img.width, img.height, BLEND);
  image(img, 0, 0);
  popMatrix();
}

void DrawShifted(PImage img)
{
  pushMatrix();
  translate(3 * lengthIncrement, 3 * lengthIncrement);
  scale(1.20, 1.20);
//  blend(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height, ADD);
  image(img, 0, 0);
  popMatrix();
}
