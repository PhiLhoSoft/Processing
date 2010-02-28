/**
Show randomly chosen kanji & kana Japanese characters.

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2010/02/27 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2010 Philippe Lhoste / PhiLhoSoft
*/
/*
Color of character will depend on its grade
grade = color - hue on a 1000 scale
G1 = white   - S=0
G2 = yellow  - 160
G3 = orange  - 90
G4 = green   - 380
G5 = blue    - 630
G6 = brown   - 54 & S= & B=
G8 = black   - B=0

Yes, these are judo belt colors...
Also:
hiragana = violet - 823
katakana = red    - 0
*/
final color START_COLOR_TOP    = #335533;
final color START_COLOR_BOTTOM = #55AA55;
final color END_COLOR_TOP      = #333355;
final color END_COLOR_BOTTOM   = #5555AA;

final int MAX_FRAME_NB  = 72;

int colorCycleDirection = 1;
int colorCycleCursor;

void setup()
{
  size(1000, 700);
  colorMode(HSB, 1000, 100, 100);

  smooth();
//  noLoop();
  background(150);
  noFill();

}

void draw()
{
  DrawBackground();
}

color InterpolateColor(color startC, color endC)
{
  colorCycleCursor += colorCycleDirection;
  if (colorCycleCursor >= MAX_FRAME_NB || colorCycleCursor < 0)
  {
    colorCycleDirection = -colorCycleDirection;
    colorCycleCursor += colorCycleDirection;
  }
  return lerpColor(startC, endC, (float) colorCycleCursor / (float) MAX_FRAME_NB);
}


void DrawBackground()
{
  color topColor = InterpolateColor(START_COLOR_TOP, END_COLOR_TOP);
  color bottomColor = InterpolateColor(START_COLOR_BOTTOM, END_COLOR_BOTTOM);
  for (int l = 0; l < height; l++)
  {
    color sc = lerpColor(topColor, bottomColor, (float) l / (float) height);
    stroke(sc);
    line(0, l, width - 1, l);
  }
}

