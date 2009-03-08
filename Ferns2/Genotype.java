/**
Definition of genotype interface and segment abstract class for a fern.

// by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
// File/Project history:
 1.00.000 -- 2008/06/04 (PL) -- Separation from Fern.pde.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/
import processing.core.*;

/**
 * A segment of the plant: part of the trunk, of a branch or a leaf.
 */
abstract class Segment extends ProcessingWrapper
{
   /**
    * Graphical vector.
    */
   class GraphVector extends GeomVector
   {
      void Draw()
      {
         p$.stroke(m_color);
         p$.strokeWeight(m_width);
         p$.line(m_startPoint.m_x, m_startPoint.m_y, m_endPoint.m_x, m_endPoint.m_y);
      }
   }

	private GraphVector m_vector;	// Position, size, direction, color and width of the segment
	Genotype m_genotype;
	private Segment m_baseSegment;	// The segment to which this one is attached
	private float m_relativeAngle;	// Relative to base segment

	Segment(Point basePoint, Genotype genotype)
	{
		m_genotype = genotype;
		m_baseSegment = null;
		m_vector = new GraphVector(
				basePoint,
				0xFF000000,
				1.0,
				20.0,
				0.0
				);
		m_relativeAngle = 0;
	}

	Segment(Segment baseSegment)
	{
		m_genotype = baseSegment.GetGenotype();
		m_baseSegment = baseSegment;
		m_vector = new GraphVector(baseSegment.GetVector());
		m_vector.SetStartPoint(baseSegment.GetEndPoint());
		m_relativeAngle = 0;
	}

	Genotype GetGenotype()
	{
		return m_genotype;
	}

	void Draw()
	{
		m_vector.Draw();
	}

	void SetLength(float length)
	{
		m_vector.SetLength(length);
	}
	void SetAbsoluteAngle(float angle)	// For segments without base
	{
		m_relativeAngle = 0;
		m_vector.SetAngle(angle);
	}
	void SetAngle(float angle)
	{
//~ 		PrintType();
		m_relativeAngle = angle;
		if (m_baseSegment == null)
		{
			println("ERROR: Don't call SetAngle without base segment.");
		}
		else
		{
//~ 			print("bs:a=" + angle + "/A=" + m_baseSegment.GetAngle());
			m_vector.SetAngle(m_baseSegment.GetAbsoluteAngle() + angle);
//~ 			println("/ra:" + m_vector.GetAngle());
		}
	}
	void SetColor(int segColor)
	{
		m_vector.SetColor(segColor);
	}
	void SetWidth(float width)
	{
		m_vector.SetWidth(width);
	}

	Vector GetVector()
	{
		return m_vector;
	}

	Point GetStartPoint()
	{
		return m_vector.GetStartPoint();
	}
	Point GetEndPoint()
	{
		return m_vector.GetEndPoint();
	}
	float GetLength()
	{
		return m_vector.GetLength();
	}
	float GetWidth()
	{
		return m_vector.GetWidth();
	}
	float GetAngle()
	{
		return m_relativeAngle;
	}
	float GetAbsoluteAngle()
	{
		return m_vector.GetAngle();
	}
	int GetColor()
	{
		return m_vector.GetColor();
	}

	char GetType()
	{
		if (this instanceof Trunk)
			return 'T';
		else if (this instanceof Branch)
			return 'B';
		else if (this instanceof Leaf)
			return 'L';
		else
			return 'S';
	}
}

interface Genotype
{
	float GetBaseLength(Segment seg);
	float GetLength(Segment seg);
	float GetBaseWidth(Segment seg);
	float GetWidth(Segment seg);
	float GetAbsoluteAngle(Segment seg, boolean bIsLeft);
	float GetAngle(Segment seg, boolean bIsLeft);
	int GetBaseColor(Segment seg);
	int GetColor(Segment seg);
	boolean ShouldAddSegment(Segment seg);
}
