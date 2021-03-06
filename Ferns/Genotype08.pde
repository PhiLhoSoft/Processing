/**
Genotype file for the Fern Processing project.

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2008/05/17 (PL) -- Split of genotypes.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/

class Genotype08 implements Genotype
{
	int m_trunkNb = 0;
	int m_direction = 1;
	color m_baseColor = #00B080;

	Genotype08() {}	// Default constructor, for default genotype
	Genotype08(boolean bReverse, color baseColor)
	{
		if (bReverse) m_direction = -1;
		if (baseColor != 0) m_baseColor = baseColor;
	}

	float GetBaseLength(Object seg)
	{
		if (seg == null) return CANVAS_HEIGHT / 10.0;	// For trunk
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetLength() * 0.40;	// For branch
		case 'B': return segment.GetLength() * 0.30;	// For leaf
		default:  return 0;
		}
	}
	float GetLength(Object seg)
	{
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetLength() * 0.70;	// For trunk
		case 'B': return segment.GetLength() * 0.50;	// For branch
		default:  return 0;
		}
	}
	float GetBaseWidth(Object seg)
	{
		if (seg == null) return CANVAS_WIDTH / 60.0;	// For trunk
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetWidth() * 0.50;	// For branch
		case 'B': return segment.GetWidth() * 0.50;	// For leaf
		default:  return 0;
		}
	}
	float GetWidth(Object seg)
	{
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetWidth() * 0.80;	// For trunk
		case 'B': return segment.GetWidth() * 0.40;	// For branch
		default:  return 0;
		}
	}
	float GetAbsoluteAngle(Object seg, boolean bIsLeft)
	{
		if (seg == null)
		{
			m_trunkNb = 0;
			return m_direction * 16.0;	// For trunk
		}
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetAbsoluteAngle() + (bIsLeft ? -70.0 : -20.0);	// For branch
		case 'B': return segment.GetAbsoluteAngle() + (bIsLeft ? -10.0 : +10.0);	// For leaf
		default:  return 0;
		}
	}
	float GetAngle(Object seg, boolean bIsLeft)
	{
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T':
			m_trunkNb++;
			return m_direction * -30.0 * (1 + (float)m_trunkNb / 5);	// For trunk
		case 'B': return m_direction * (bIsLeft ? -30.0 : -30.0);	// For branch
		default:  return 0;
		}
	}
	color GetBaseColor(Object seg)
	{
		if (seg == null) return m_baseColor;	// Stump color
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetColor();	// Base of branch = same color as base segment from trunk
		case 'B': return segment.GetColor();	// Leaf: same color as base segment from branch
		default:  return 0;
		}
	}
	color GetColor(Object seg)
	{
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return color(0, green(segment.GetColor()) + 10, 0);	// For trunk
		case 'B': return color(0, green(segment.GetColor()) + 1, blue(segment.GetColor()) + 1);	// For branch
		default:  return 0;
		}
	}
	boolean ShouldAddSegment(Object seg)
	{
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetLength() > 1.0;	// For trunk
		case 'B': return segment.GetLength() > 1.0;	// For branch
		default:  return false;
		}
	}
}
