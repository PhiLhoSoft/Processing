// PImage testing
PImage niceImage;

void setup()
{
  size(500, 800);
  smooth();
  noLoop();

  niceImage = loadImage("D:/_PhiLhoSoft/Processing/Globe.png");
  // Dimension to image size
  //size(niceImage.width,  niceImage.height);
  DrawReflected(niceImage);

/*
  // Display whole image
  image(niceImage, 0, 0);
  // Create a sub-image
  int posX = int(niceImage.width * 0.2);
  int posY = int(niceImage.height * 0.2);
  int subWidth = int(niceImage.width * 0.6);
  int subHeight = int(niceImage.height * 0.6);

  if (false)
  {
    PImage subImage = createImage(subWidth, subHeight, RGB);
    subImage.copy(niceImage, posX, posY, subWidth, subHeight, 0, 0, subWidth, subHeight);
    subImage.filter(INVERT);
    image(subImage, posX, posY, subWidth, subHeight);
  }
  else
  {
    // Simpler
    PImage subImage = get(posX, posY, subWidth, subHeight);
    subImage.filter(INVERT);
    set(posX, posY, subImage);
  }
*/
}

void DrawInverted(PImage img)
{
  image(img, 0, 0, img.width, img.height);

  pushMatrix();
  translate(img.width, img.height * 2);
  rotate(PI);
  image(img, 0, 0, img.width, img.height);
  popMatrix();
}

void DrawReflected(PImage img)
{
  image(img, 0, 0, img.width, img.height);

  pushMatrix();
  translate(0, img.height);
  scale(1.00, -1.00);
  image(img, 0, -img.height, img.width, img.height);
  popMatrix();
}
