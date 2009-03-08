/**
Definition of a 2D graphical point.

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
package org.philhosoft.geometry;

/**
 * Simple 2D point class with float storage.
 * I know it is redundant with java.awt.geom.Point2D.Float...
 * But it has nothing to do with awt, and it is for my own limited use... :P
 */
public class Point
{
	private float m_x, m_y;

	Point()
   {
      this(0, 0);
   }
	Point(float x, float y)
	{
		m_x = x; m_y = y;
	}
	Point(Point p)
	{
		m_x = p.GetX(); m_y = p.GetY();
	}

	float GetX() { return m_x; }
	float GetY() { return m_y; }

	void SetLocation(float x, float y)
	{
		m_x = x; m_y = y;
	}
	void SetLocation(Point p)
	{
		m_x = p.GetX(); m_y = p.GetY();
	}

   /**
    * Move (change location) the point along a vector (length, angle),
    * ie. distance of move and direction.
    * Angle is given in radians, 0 being on the positive x axis.
    */
   void MoveByVector(float length, float angle)
   {
      m_x += length * Math.cos(angle);
      m_y += length * Math.sin(angle);
   }

   /**
    * Move (change location) the point by x and y offset.
    */
   void MoveByOffsets(float dx, float dy)
   {
      m_x += dx;
      m_y += dy;
   }

   boolean equals(Point p)
   {
      return m_x == p.GetX() && m_y == p.GetY();
   }

   float ComputeDistance(float x, float y)
   {
      return Math.sqrt((m_x - x) ^2 + (m_y - y) ^2);
   }
   float ComputeDistance(Point p)
   {
      return Math.sqrt((m_x - p.GetX()) ^2 + (m_y - p.GetY()) ^2);
   }

   boolean IsNear(float x, float y, float radius)
   {
      return ComputeDistance(x, y) <= radius;
   }
   boolean IsNear(Point p, float radius)
   {
      return ComputeDistance(p) <= radius;
   }

	String toString()
	{
		return "x=" + m_x + ", y=" + m_y;
	}
}
