PImage niceImage;
PImage maskImage;
PGraphics graphicalMask;
int iw, ih;
int dw, dh;

void setup()
{
  size(500, 500);
  niceImage = loadImage("E:/Dev/PhiLhoSoft/Processing/me.png");
  iw = niceImage.width;
  ih = niceImage.height;
  dw = width - iw;
  dh = height - ih;
  graphicalMask = createGraphics(iw, ih, JAVA2D);
}

void draw()
{
  background(200);

  graphicalMask.beginDraw();
  // Erase graphics
  graphicalMask.background(0);
  // Draw the mask
  int x = mouseX - dw/2;
  int y = mouseY - dh/2;
  graphicalMask.fill(255);
  graphicalMask.noStroke();
  graphicalMask.ellipse(x, y, 100, 50);
  graphicalMask.stroke(128);
  graphicalMask.strokeWeight(5);
  graphicalMask.line(0, y, iw, y);
  graphicalMask.line(x, 0, x, ih);
  graphicalMask.endDraw();

  // Copy the original image (kept as reference)
  maskImage = niceImage.get();
  // Apply the mask
  maskImage.mask(graphicalMask);
  // Display the result
  image(maskImage, dw/2, dh/2);
}

