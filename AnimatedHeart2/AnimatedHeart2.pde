/**
AnimatedHeart2.pde: Draw an animated heart in Processing.
http://processing.org/

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.01.000 -- 2008/05/27 (PL) -- Export with gifAnimation.
 1.00.000 -- 2008/05/25 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/
// http://www.extrapixel.ch/processing/gifAnimation/
import gifAnimation.*;

final int CANVAS_HEIGHT = 50;
final int CANVAS_WIDTH = 50;
Heart g_h;
float g_heartSize;
final int MAX_PULSE = 12;
int g_pulse = 0;
final float MIN_FACTOR = 0.5, MAX_FACTOR = 1.2;

boolean bUseGifExport = true;
//~ String EXPORT_FILE = "Heart-##.png";  // If using saveFrame
String EXPORT_FILE = "Heart.gif";
GifMaker gifExport;

void setup()
{
  smooth();
  size(CANVAS_HEIGHT, CANVAS_WIDTH);
  frameRate(30);

  g_heartSize = (CANVAS_WIDTH / 2) - 8;
  //   Heart(float x, float y, float size, float proportion,
  //    float topFactor, float bottomFactor, float bottomAngle,
  //    int lineWidth, color colorLine, color colorFill
  g_h = new Heart(CANVAS_WIDTH / 2, CANVAS_WIDTH / 3, g_heartSize,
      1.5, 0.7, 0.9, 45, 3, #FF5500, #FF7788);

  if (bUseGifExport)
  {
    gifExport = new GifMaker(this, EXPORT_FILE);
//~     gifExport = new GifMaker(this, EXPORT_FILE, 10);  // Quality
//~     gifExport = new GifMaker(this, EXPORT_FILE, 10, #FFFFFF);  // Quality, transparent color
    gifExport.setRepeat(0); // make it an "endless" animation
//~     gifExport.setTransparent(0, 0, 0);  // black is transparent
  }
}

void draw()
{
  float factor = sin((float) TWO_PI * g_pulse / MAX_PULSE);  // -1 to +1
  background(color(0x40, 0x80 + 0x20 * factor, 0xA0 + 0x30 * factor));
  // Clamp the factor
  factor = MIN_FACTOR + (MAX_FACTOR - MIN_FACTOR) * (factor + 1.0) / 2;
  g_h.m_size = g_heartSize * factor;
  g_h.Update();
  g_h.Draw();

  if (bUseGifExport)
  {
    gifExport.setDelay(200);
    gifExport.addFrame();
  }
  else
  {
    saveFrame(EXPORT_FILE);
  }
  g_pulse = ++g_pulse % MAX_PULSE;
  if (g_pulse == 0)
  {
    if (bUseGifExport)
    {
      gifExport.finish();
    }
    exit();
  }
}
