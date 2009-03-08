/**
Some simple geometry primitives.

// by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
// File/Project history:
 1.00.000 -- 2008/04/15 (PL) -- Start of creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/

class Point
{
	final float m_x, m_y;	// Yeah, no getter...

	Point(float x, float y)
	{
		m_x = x; m_y = y;
	}

	Point(Point p)
	{
		m_x = p.m_x; m_y = p.m_y;
	}

	/** Move the point along a vector given by its length and the angle it has with vertical
	 * axis. Ie. an angle of 0 is toward top, and positive angle goes to the right.
	 * Angle is given in degrees for simplicity.
	 */
	Point Move(float length, float angle)
	{
		float x, y;
		// Normalize angle
		float radAngle = radians(90.0 - angle);
		x = m_x + cos(radAngle) * length;
		y = m_y - sin(radAngle) * length;
		return new Point(x, y);
	}

	String toString()
	{
		return "Point(" + m_x + ", " + m_y + ")";
	}
}

/** A geometric vector, not the Java Collection class.
 */
class Vector
{
	private Point m_startPoint;
	private Point m_endPoint;	// A bit redundant with length and angle, but allow faster drawing
	private color m_color;	// Stroke color
	private float m_width;	// Ie. stroke weight
	private float m_length;	// Absolute
	private float m_angle;	// Relative to vertical axis

	Vector(Point startPoint, color vectColor, float width, float length, float angle)
	{
		m_startPoint = startPoint;
		m_color = vectColor;
		m_width = width;
		m_length = length;
		m_angle = angle;

		ComputeEndPoint();
	}

	Vector(Vector vector)
	{
		this(vector.m_startPoint,
				vector.m_color,
				vector.m_width,
				vector.m_length,
				vector.m_angle);
	}

	void Draw()
	{
		stroke(m_color);
		strokeWeight(m_width);
		line(m_startPoint.m_x, m_startPoint.m_y, m_endPoint.m_x, m_endPoint.m_y);
	}

	Point GetStartPoint()
	{
		return m_startPoint;
	}
	Point GetEndPoint()
	{
		return m_endPoint;
	}
	color GetColor()
	{
		return m_color;
	}
	float GetWidth()
	{
		return m_width;
	}
	float GetLength()
	{
		return m_length;
	}
	float GetAngle()
	{
		return m_angle;
	}

	void SetStartPoint(Point startPoint)
	{
		m_startPoint = startPoint;
		ComputeEndPoint();
	}
	void SetColor(color vectColor)
	{
		m_color = vectColor;
	}
	void SetWidth(float width)
	{
		m_width = width;
	}
	void SetLength(float length)
	{
		m_length = length;
		ComputeEndPoint();
	}
	void SetAngle(float angle)
	{
		m_angle = angle;
		ComputeEndPoint();
	}

	private void ComputeEndPoint()
	{
		Point endPoint = new Point(m_startPoint);
		m_endPoint = endPoint.Move(m_length, m_angle);
	}

	String toString()
	{
		return "Vector(C=" + hex(m_color) + ", W=" + m_width + ", L=" + m_length +", A=" + m_angle +
			", XS=" + m_startPoint.m_x + ", YS=" + m_startPoint.m_y +
			", XE=" + m_endPoint.m_x + ", YE=" + m_endPoint.m_y + ")";
	}
}
