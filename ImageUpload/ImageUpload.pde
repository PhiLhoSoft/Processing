/**
Example of Processing sketch using my DataUpload class.
Just a demo / test of that class.

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.01.000 -- 2008/07/24 (PL) -- Fix of Jpeg images (get rid of alpha channel).
 1.00.000 -- 2008/07/23 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/
//~ import com.sun.image.codec.jpeg.*;
import javax.imageio.*;
import javax.imageio.stream.*;
import java.awt.image.BufferedImage;

final color START_COLOR_TOP    = #335533;
final color START_COLOR_BOTTOM = #55AA55;
final color END_COLOR_TOP      = #333355;
final color END_COLOR_BOTTOM   = #5555AA;

final int MAX_FRAME_NB = 120;

float x = 0, y = 0;
float size = 0;
float top = 0, bottom = 0;
float dx = 0, dy = 0;

String currentFormat = "png";

color GetRandomColor()
{
  return color(random(0, 256), random(0, 256), random(0, 256));
}
color InterpolateColor(color startC, color endC)
{
  return lerpColor(startC, endC, (float) frameCount / (float) MAX_FRAME_NB);
}

void DrawBackground()
{
  color topColor = InterpolateColor(START_COLOR_TOP, END_COLOR_TOP);
  color bottomColor = InterpolateColor(START_COLOR_BOTTOM, END_COLOR_BOTTOM);
  for (int line = 0; line < height; line++)
  {
    color sc = lerpColor(topColor, bottomColor, (float) line / (float) height);
    stroke(sc);
    line(0, line, width - 1, line);
  }
}

void setup()
{
  smooth();
  frameRate(24);
  size(400, 400);
}

void draw()
{
  DrawBackground();

  if (frameCount % 24 == 0)
  {
    fill(GetRandomColor());
    stroke(GetRandomColor());
    strokeWeight(random(1, 8));
    x = random(100, 300); y = random(150, 350);
    size = random(20, 100);
    top = random(20, 80); bottom = random(20, 80);
    dx = random(10, 50); dy = random(20, 60);
  }

  beginShape();

  // The heart, symmetrical around vertical axis
  // Anchor point (highest sharp point)
  vertex(x, y);
  // Top left part
  bezierVertex(
      x, y - top,
      x - size, y - top,
      x - size, y);
  // Bottom left part
  bezierVertex(
      x - size, y + top,
      x - dx, y + bottom - dy,
      x, y + bottom);
  // Bottom right part
  bezierVertex(
      x + dx, y + bottom - dy,
      x + size, y + top,
      x + size, y);
  // Top right part
  bezierVertex(
      x + size, y - top,
      x, y - top,
      x, y);

  endShape();
}

void keyPressed()
{
  if (key == 'j')
  {
    currentFormat = "jpg";
  }
  if (key == 'J')
  {
    currentFormat = "jpeg";
  }
  if (key == 'p')
  {
    currentFormat = "png";
  }
  if (key == 's')
  {
    DataUpload du = new DataUpload();
    boolean bOK = false;
    // Upload the currently displayed image with a fixed name, and the chosen format
    if (currentFormat.equals("png"))
    {
      bOK = du.UploadImage("snapshot." + currentFormat, (BufferedImage) g.image);
    }
    else
    {
      // We need a new buffered image without the alpha channel
      BufferedImage imageNoAlpha = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
      loadPixels();
      imageNoAlpha.setRGB(0, 0, width, height, g.pixels, 0, width);
      bOK = du.UploadImage("snapshot." + currentFormat, imageNoAlpha);
    }
    if (!bOK)
      return; // Some problem on Java side. Do nothing

    // Get the answer of the PHP script
    int rc = du.GetResponseCode();
    String feedback = du.GetServerFeedback();
    println("----- " + rc + " -----\n" + feedback + "---------------");

    // Extract the URL of the image from the PHP feedback
    // I use the hard way, the script could just answer the right URL...
    String[] m = match(feedback, "<img src='([^']+)'");
    if (m != null)  // Found!
    {
      println("\n=> " + m[0] + "\n");
      // Open in a popup window
      link(m[0], "UploadedImage");
    }
  }
}
