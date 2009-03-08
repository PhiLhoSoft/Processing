/**
Handles demo: draw handles than can be dragged with the mouse.
http://processing.org/

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2008/04/29 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/

final int CANVAS_HEIGHT = 400;
final int CANVAS_WIDTH = 400;
final int HANDLE_NB = 10;
Handle[] g_h = new Handle[HANDLE_NB];
boolean g_bDragging;

void setup()
{
	smooth();
	size(CANVAS_HEIGHT, CANVAS_WIDTH);

	// Create random handles
	for (int i = 0; i < HANDLE_NB; i++)
	{
		int size = int(random(5, 20));
		g_h[i] = new Handle(random(CANVAS_HEIGHT - 10), random(CANVAS_WIDTH - 10),
				size, size / 5,
				color(random(0, 128), 0, 0), color(0, random(200, 255), 0), color(0, 0, random(200, 255))
		);
	}
}

void draw()
{
	background(#AADDFF);

	// We suppose we are not dragging by default
	boolean bDragging = false;
	// Check each handle
	for (int i = 0; i < HANDLE_NB; i++)
	{
		// Check if the user tries to drag it
		g_h[i].Update(g_bDragging);
		// Ah, this one is indeed dragged!
		if (g_h[i].IsDragged())
		{
			// We will remember a dragging is being done
			bDragging = true;
			// And move it to mouse position
			g_h[i].Move();
		}
		// In all case, we redraw the handle
		g_h[i].Draw();
	}
	// If no dragging is found, we reset the state
	g_bDragging = bDragging;
}
