PImage niceImage;
PImage maskedImage;
PGraphics graphicalMask;
int iw, ih;
int dw, dh;

void setup()
{
  size(500, 500);
  niceImage = loadImage("D:/_PhiLhoSoft/Processing/me.png");
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
  // Erase graphics with black background
  graphicalMask.background(0);
  // Draw the mask, depending on mouse position
  int x = mouseX - dw/2;
  int y = mouseY - dh/2;
  // Draw in white
  graphicalMask.fill(255);
  graphicalMask.noStroke();
  // An ellipse to see a good part of the image
  graphicalMask.ellipse(x, y, 100, 50);
  // Draw in gray, resulting in translucent mask
  graphicalMask.stroke(128);
  graphicalMask.strokeWeight(5);
  // Draw a thick cross-wire
  graphicalMask.line(0, y, iw, y);
  graphicalMask.line(x, 0, x, ih);
  graphicalMask.endDraw();

  // Copy the original image (kept as reference)
  maskedImage = niceImage.get();
  // Apply the mask
  maskedImage.mask(graphicalMask);
  // Display the result
  image(maskedImage, dw/2, dh/2);
}

