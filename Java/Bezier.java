/**
Wrapper of Bézier curves.
http://en.wikipedia.org/wiki/B%C3%A9zier_curve

A class for Processing.org language extension.
Made by following excellent instructions at http://www.mostpixelsever.com/tutorial/eclipse

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
package org.philhosoft.processing;

import processing.core.PApplet;

import org.philhosoft.geometry.Point;

class BezierCurve
{
   private PApplet $;
	private Point m_startPoint, m_endPoint;
	private Point m_startControlPoint, m_endControlPoint;
   private boolean m_bShowBug = false;	// If true, uses Processing's bezierTangent function, which is bugged in 0135. Allows to show the issue.

	public BezierCurve(PApplet pa, Point startPoint, Point startControlPoint, Point endControlPoint, Point endPoint)
	{
      $ = pa;
		m_startPoint = startPoint;
		m_endPoint = endPoint;
		m_startControlPoint = startControlPoint;
		m_endControlPoint = endControlPoint;
	}

	/**
	 * Gets a point on the Bézier curve, given a relative "distance" from the starting point,
	 * expressed as a float number between 0 (start point) and 1 (end point).
	 */
	public Point GetPoint(float pos)
	{
		float x = $.bezierPoint(m_startPoint.GetX(), m_startControlPoint.GetX(),
				m_endControlPoint.GetX(), m_endPoint.GetX(),
				pos);
		float y = $.bezierPoint(m_startPoint.GetY(), m_startControlPoint.GetY(),
				m_endControlPoint.GetY(), m_endPoint.GetY(),
				pos);
		return new Point(x, y);
	}

	// The fixed function as seen in SVN: http://dev.processing.org/source/index.cgi/trunk/processing/core/src/processing/core/PGraphics.java?rev=3787&view=markup
	public public float bezierTangent(float a, float b, float c, float d, float t)
	{
		return 3*t*t * (-a+3*b-3*c+d) +
				6*t * (a-2*b+c) +
				3 * (-a+b);
	}
	/**
	 * Gets the tangent of a point (see GetPoint) on the Bézier curve, as an angle with positive x axis.
	 * Uses Processing's bezierTangent, which is broken in 0135, and should be fixed for 0136 and higher.
	 */
	public float GetTangent(float pos)
	{
		float x = $.bezierTangent(m_startPoint.GetX(), m_startControlPoint.GetX(),
				m_endControlPoint.GetX(), m_endPoint.GetX(),
				pos);
		float y = $.bezierTangent(m_startPoint.GetY(), m_startControlPoint.GetY(),
				m_endControlPoint.GetY(), m_endPoint.GetY(),
				pos);
		return $.atan2(y, x);
	}

	/**
	 * Gets the tangent of a point (see GetPoint) on the Bézier curve, as an angle with positive x axis.
	 * Uses fixed routine...
	 */
	public float GetRealTangent(float pos)
	{
		float x = bezierTangent(m_startPoint.GetX(), m_startControlPoint.GetX(),
				m_endControlPoint.GetX(), m_endPoint.GetX(),
				pos);
		float y = bezierTangent(m_startPoint.GetY(), m_startControlPoint.GetY(),
				m_endControlPoint.GetY(), m_endPoint.GetY(),
				pos);
		return Math.atan2(y, x);
	}

	public void Draw()
	{
		$.bezier(m_startPoint.GetX(), m_startPoint.GetY(),
				m_startControlPoint.GetX(), m_startControlPoint.GetY(),
				m_endControlPoint.GetX(), m_endControlPoint.GetY(),
				m_endPoint.GetX(), m_endPoint.GetY());
	}

	/**
	 * Visualizes control points.
	 */
	public void DrawControls()
	{
		$.noFill();
		$.stroke(0xFF8000);
		$.strokeWeight(1);

		$.line(m_startPoint.GetX(), m_startPoint.GetY(), m_startControlPoint.GetX(), m_startControlPoint.GetY());
		$.ellipse(m_startControlPoint.GetX(), m_startControlPoint.GetY(), 4, 4);

		$.line(m_endPoint.GetX(), m_endPoint.GetY(), m_endControlPoint.GetX(), m_endControlPoint.GetY());
		$.ellipse(m_endControlPoint.GetX(), m_endControlPoint.GetY(), 4, 4);
	}

	/**
	 * Visualizes details on curve.
	 */
	public void DrawDetails(int pointNb, float tanLength)
	{
		if (pointNb <= 1) pointNb = 2;
      // Yeah, I know, no control over colors and size
		$.stroke(0xFF0000);
		$.strokeWeight(1);

		for (int i = 0; i < pointNb; i++)
		{
			float pos = (float) i / (pointNb - 1);

			Point pt = GetPoint(pos);
			float x = pt.GetX(), y = pt.GetY();
         if (tanLength > 0)
         {
            float a = bShowBug ? GetTangent(pos) : GetRealTangent(pos);

            $.line(x, y, Math.cos(a) * tanLength + x, Math.sin(a) * tanLength + y);
         }
			$.ellipse(x, y, 3, 3);
		}
	}
}
