/**
Draw Bézier vertex with visualization of anchor and control points.

A class for Processing.org language extension.

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2009/03/10 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2009 Philippe Lhoste / PhiLhoSoft
*/
//package org.philhosoft.processing;

class BezierHelper
{
	static void Vertex(float x, float y)
	{
		pushStyle();
		ellipseMode(CENTER);
		noStroke();
		// Reference point (if Bézier curve is drawn close of 0 and translated)
		fill(#FF00FF, 200);
		ellipse(0, 0, 5, 5);
		// Starting point of the curve
		fill(#FFFF00, 200);
		ellipse(x, y, 5, 5);
		popStyle();
	}

	// Simple version: no look parameters
	static void BezierVertex(float cx1, float cy1, float cx2, float cy2, float x, float y)
	{
		pushStyle();
		rectMode(CORNERS);
		ellipseMode(CENTER);

		// Anchor point
		fill(#0000FF, 200);
		noStroke();
		rect(x-1, y-1, x+1, y+1);

		// First control point
		stroke(#00FF00, 220);
		strokeWeight(1);
		line(x, y, cx1, cy1);
		fill(#00FF00, 200);
		noStroke();
		ellipse(cx1, cy1, 3, 3);

		// Second control point
		stroke(#FF0000, 220);
		strokeWeight(1);
		line(x, y, cx2, cy2);
		fill(#FF0000, 200);
		noStroke();
		ellipse(cx2, cy2, 3, 3);
		popStyle();
	}
}
