import java.awt.Rectangle;

PImage rects;
ArrayList foundRectangles = new ArrayList();
int MARGIN = 50;
boolean bShowAlgo = false;
float depth = 400;
float volume;

void setup()
{
  if (bShowAlgo)
  {
    size(550, 300);
  }
  else
  {
    size(800, 800, P3D);
  }
  rects = loadImage("testpicture1.png");
  volume = rects.width * rects.height * 5;
  FindRectangles(rects, #FFFFFF, #000000);

  if (bShowAlgo)
  {
    image(rects, MARGIN, MARGIN);
    rects.updatePixels();
    image(rects, 300, MARGIN);
    noLoop();
  }
}

void draw()
{
  if (bShowAlgo)
  {
    background(#ABCDEF);
    noFill();
    stroke(#00FF00);
    for (int i = 0; i < foundRectangles.size(); i++)
    {
      Rectangle r = (Rectangle) foundRectangles.get(i);
      rect(MARGIN + r.x, MARGIN + r.y, r.width, r.height);
    }
  }
  else
  {
    // Inspired by CubicGrid example
    background(255);
    image(rects, 0, 0);

    // Center and spin result
    translate(width/2, height/2, -depth);
    rotateY(frameCount * 0.01);
    rotateX(frameCount * 0.01);

    fill(200, 90);
    stroke(#0000FF);
    DrawBox(0, 0, MARGIN, rects.width, rects.height, MARGIN);

    fill(128, 80);
    stroke(#008800, 70);
    for (int i = 0; i < foundRectangles.size(); i++)
    {
      Rectangle r = (Rectangle) foundRectangles.get(i);
      float boxHeight = volume / r.width / r.height;
      DrawBox(r.x, r.y, 0, r.width, r.height, boxHeight);
    }
  }
}

// It changes img, pass a copy if you need it intact...
void FindRectangles(PImage img, color backColor, color rectColor)
{
  int iw = img.width;
  int ih = img.height;
  println("Image: " + iw + "x" + ih);

  color markColor = #FF0000;

  // Top-left coordinate
  int left, top;
  // Botttom-right coordinate
  int right, bottom;
  // Current pos
  int posX = 0, posY = 0;
  while (posY < ih)
  {
    while (posX < iw)
    {
      if (img.pixels[posX + iw * posY] == rectColor)
      {
        // Top-left corner
        left = posX;
        top = posY;
        // Walk the upper side
        while (posX < iw && img.pixels[posX + iw * posY] == rectColor)
        {
          posX++;
        }
        right = posX - 1;
        // Walk the right side, marking it (and the left side too)
        while (posY < ih && img.pixels[right + iw * posY] == rectColor)
        {
          img.pixels[left + iw * posY] = img.pixels[right + iw * posY] = markColor;
          posY++;
        }
        bottom = posY - 1;
        posY = top;
        Rectangle r = new Rectangle(left, top, right - left, bottom - top);
        foundRectangles.add(r);
        println(r);
      }
      else if (img.pixels[posX + iw * posY] == markColor)
      {
        // A known rectangle, skip it
        do
        {
          posX++;
        } while (img.pixels[posX + iw * posY] != markColor);
        posX++;
      }
      else
      {
        posX++;
      }
    }
    posX = 0;
    posY++;
  }
}

// Boxes seems to be drawn centered (not documented?)
// Draw a box with reference on a corner
void DrawBox(float x, float y, float z, float w, float h, float d)
{
  pushMatrix();
  translate(-x - w / 2, -y - h / 2, -(z - d / 2));
  box(w, h, d);
  popMatrix();
}

