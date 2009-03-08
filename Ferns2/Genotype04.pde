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

class Genotype04 implements Genotype
{
	int m_direction = 1;
	color m_baseColor = #008000;

	Genotype04() {}	// Default constructor, for default genotype
	Genotype04(boolean bReverse, color baseColor)
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
		case 'T': return segment.GetLength() * 0.50;	// For branch
		case 'B': return segment.GetLength() * 0.90;	// For leaf
		default:  return 0;
		}
	}
	float GetLength(Object seg)
	{
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetLength() * 0.50;	// For trunk
		case 'B': return segment.GetLength() * 0.70;	// For branch
		default:  return 0;
		}
	}
	float GetBaseWidth(Object seg)
	{
		if (seg == null) return CANVAS_WIDTH / 60.0;	// For trunk
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetWidth() * 0.60;	// For branch
		case 'B': return segment.GetWidth() * 0.50;	// For leaf
		default:  return 0;
		}
	}
	float GetWidth(Object seg)
	{
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetWidth() * 0.75;	// For trunk
		case 'B': return segment.GetWidth() * 0.60;	// For branch
		default:  return 0;
		}
	}
	float GetAbsoluteAngle(Object seg, boolean bIsLeft)
	{
		if (seg == null) return 0.0;	// For trunk
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return segment.GetAbsoluteAngle() + (bIsLeft ? -20.0 : +20.0);	// For branch
		case 'B': return segment.GetAbsoluteAngle() + (bIsLeft ? -10.0 : +10.0);	// For leaf
		default:  return 0;
		}
	}
	float GetAngle(Object seg, boolean bIsLeft)
	{
		Segment segment = (Segment)seg;
		switch (segment.GetType())
		{
		case 'T': return m_direction * 12.0;	// For trunk
		case 'B': return m_direction * (bIsLeft ? -8.0 : +8.0);	// For branch
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
		case 'T': return segment.GetLength() > 2.0;	// For trunk
		case 'B': return segment.GetLength() > 1.0;	// For branch
		default:  return false;
		}
	}
}
