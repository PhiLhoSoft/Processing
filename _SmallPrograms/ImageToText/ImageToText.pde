final int GRID_SIZE_H = 9;
final int GRID_SIZE_V = 9;
final int GRID_SIZE = GRID_SIZE_H * GRID_SIZE_V;
final String TEXT_TO_DISPLAY = "Picture yourself in a boat on a river With tangerine trees and marmalade skies";

void setup()
{
  size(600, 600);
  smooth();
  noStroke();
  background(0);

  PImage niceImage = loadImage("me.png");
  int niW  = niceImage.width;
  int niH = niceImage.height;
  int imgW = niW + 10;
  image(niceImage, 0, 0);

  PFont f = loadFont("Arial-Black-12.vlw");
  textFont(f);
  textAlign(CENTER);
  String textToDisplay = TEXT_TO_DISPLAY.toUpperCase().replaceAll("\\s", "");

  int pos = 0;
//  loadPixels();
  niceImage.loadPixels();
  for (int j = 0; j < niH - GRID_SIZE_V; j += GRID_SIZE_V)
  {
    for (int i = 0; i < niW -  GRID_SIZE_H; i += GRID_SIZE_H)
    {
      long avgR = 0, avgG = 0, avgB = 0;
      for (int x = 0; x < GRID_SIZE_H; x++)
      {
        for (int y = 0; y < GRID_SIZE_V; y++)
        {
          int c = niceImage.pixels[i + x + (j + y) * niW];
          avgR += (c >> 16) & 0xFF;
          avgG += (c >>  8) & 0xFF;
          avgB +=  c        & 0xFF;
//          pixels[i + x + (j + y) * width] = 0;
        }
      }
      color clr = color(avgR / GRID_SIZE, avgG / GRID_SIZE, avgB / GRID_SIZE);
      fill(clr);
      char chr = textToDisplay.charAt(pos++);
//      print(chr);
      pos = pos % textToDisplay.length();
      text(chr, i + imgW, j + 12);
    }
  }
//  updatePixels();
}
