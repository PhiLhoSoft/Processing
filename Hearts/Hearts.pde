/**
Hearts.pde: Draw hearts in Processing.
http://processing.org/

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2008/04/28 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/

final int CANVAS_HEIGHT = 400;
final int CANVAS_WIDTH = 400;
Heart g_h1, g_h2, g_h3;

void setup()
{
	smooth();
	noLoop();	// No animation
	size(CANVAS_HEIGHT, CANVAS_WIDTH);
	background(#88AAFF);

	g_h1 = new Heart(70f, 150f, 50f, 2.0, 1.0, 1.0, 0.0, 2, #FF0000, #FFA0A0);
	g_h2 = new Heart(200f, 50f, 50f, 1.2, 0.8, 0.5, 60.0, 8, #550000, #882020);
	g_h3 = new Heart(250f, 220f, 100f, #800000, #AA5555);
}

void draw()
{
	g_h1.Draw();
	g_h2.Draw();
	g_h3.Draw();
}
