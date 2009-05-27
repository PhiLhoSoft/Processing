PImage akt_bild;
int[] lastFrame;
int pixelNb;

void setup()
{
  size(400, 400);
  pixelNb = width * height;
  frameRate(30);
  // Reference image
  akt_bild = loadImage("image.jpg");

  // to keep the old color of a pixel if the color change is not triggered 
  lastFrame = new int[pixelNb]; 
  for (int pixel = 0; pixel < pixelNb; pixel++)
  {
    if (random(1) > 0.5)
    {
      lastFrame[pixel] = #FFFFFF;
    }
    else
    {
      lastFrame[pixel] = #000000;
    }
  }
}

void draw()
{
  PImage displayedImage = akt_bild.get(); // Copy the image
  for (int stufen = 1; stufen < 31; stufen++) //splitting the image into 30 grey values that are overdrawn by different chances
  {
    for (int pixel = 0; pixel < pixelNb; pixel++)
    {
      int brightness = displayedImage.pixels[pixel] & 0xFF;
      if (brightness > 256 - 9 * stufen && brightness <= 256 - 9 * (stufen - 1))
      {
        if (random(256) > 256 - stufen)
        {
          int c;
          if (random(1) > 0.5)
          {
            c = #000000;
          }
          else
          {
            c = #FFFFFF;
          }
          displayedImage.pixels[pixel] = lastFrame[pixel] = c;
        }
        else
        {
          displayedImage.pixels[pixel] = lastFrame[pixel];
        }
      }
    }
  }
  displayedImage.updatePixels();
  image(displayedImage, 0, 0);
}
