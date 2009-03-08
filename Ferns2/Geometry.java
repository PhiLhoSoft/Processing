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
import processing.core.*;

/**
 * A geometric 2D Point.
 */
class GeomPoint
{
	final float m_x, m_y;	// Yeah, no getter...

	GeomPoint(float x, float y)
	{
		m_x = x; m_y = y;
	}

	GeomPoint(GeomPoint p)
	{
		m_x = p.m_x; m_y = p.m_y;
	}

	/** Move the point along a vector given by its length and the angle it has with vertical
	 * axis. Ie. an angle of 0 is toward top, and positive angle goes to the right.
	 * Angle is given in degrees for simplicity.
	 */
	GeomPoint Move(float length, float angle)
	{
		float x, y;
		// Normalize angle
		float radAngle = PApplet.radians(90.0 - angle);
		x = m_x + PApplet.cos(radAngle) * length;
		y = m_y - PApplet.sin(radAngle) * length;
		return new Point(x, y);
	}

	String toString()
	{
		return "GeomPoint(" + m_x + ", " + m_y + ")";
	}
}

/**
 * A geometric 2D vector.
 */
class GeomVector
{
	private GeomPoint m_startPoint;
	private GeomPoint m_endPoint;	// A bit redundant with length and angle, but allow faster drawing
	private int m_color;	// Stroke color
	private float m_width;	// Ie. stroke weight
	private float m_length;	// Absolute
	private float m_angle;	// Relative to vertical axis

	Vector(GeomPoint startPoint, int vectColor, float width, float length, float angle)
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

	GeomPoint GetStartPoint()
	{
		return m_startPoint;
	}
	GeomPoint GetEndPoint()
	{
		return m_endPoint;
	}
	int GetColor()
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

	void SetStartPoint(GeomPoint startPoint)
	{
		m_startPoint = startPoint;
		ComputeEndPoint();
	}
	void SetColor(int vectColor)
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
		GeomPoint endPoint = new GeomPoint(m_startPoint);
		m_endPoint = endPoint.Move(m_length, m_angle);
	}

	String toString()
	{
		return "Vector(C=" + PApplet.hex(m_color) + ", W=" + m_width + ", L=" + m_length +", A=" + m_angle +
			", XS=" + m_startPoint.m_x + ", YS=" + m_startPoint.m_y +
			", XE=" + m_endPoint.m_x + ", YE=" + m_endPoint.m_y + ")";
	}
}
