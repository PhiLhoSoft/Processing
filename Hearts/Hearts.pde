/**
Hearts.pde: Draw hearts in Processing.
http://processing.org/

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.01.000 -- 2012/08/04 (PL) -- Update to common Processing conventions.
 1.00.000 -- 2008/04/28 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008-2012 Philippe Lhoste / PhiLhoSoft
*/

Heart h1, h2, h3;

void setup()
{
  size(400, 400);
  smooth();
  noLoop();	// No animation

  h1 = new Heart(70f, 150f, 50f, 2.0, 1.0, 1.0, 0.0, 2, #FF0000, #FFA0A0);
  h2 = new Heart(200f, 50f, 50f, 1.2, 0.8, 0.5, 60.0, 8, #550000, #882020);
  h3 = new Heart(250f, 220f, 100f, #800000, #AA5555);
}

void draw()
{
  background(#88AAFF);
  h1.draw();
  h2.draw();
  h3.draw();
  
  noLoop();
}
