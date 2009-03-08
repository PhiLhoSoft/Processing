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

class Genotype09 implements Genotype
{
	private Genotype m_g;

	Genotype09()	// Default constructor, for default genotype
	{
		m_g = new Genotype06();
	}
	Genotype09(boolean bReverse, color baseColor)
	{
		m_g = new Genotype06(bReverse, baseColor);
	}

	float GetBaseLength(Object seg)
	{
		return m_g.GetBaseLength(seg) * 0.95;
	}
	float GetLength(Object seg)
	{
		return m_g.GetLength(seg) * 0.95;
	}
	float GetBaseWidth(Object seg)
	{
		return m_g.GetBaseWidth(seg) * 0.95;
	}
	float GetWidth(Object seg)
	{
		return m_g.GetWidth(seg) * 0.95;
	}
	float GetAbsoluteAngle(Object seg, boolean bIsLeft)
	{
		return m_g.GetAbsoluteAngle(seg, bIsLeft);
	}
	float GetAngle(Object seg, boolean bIsLeft)
	{
		return m_g.GetAngle(seg, bIsLeft);
	}
	color GetBaseColor(Object seg)
	{
		return m_g.GetBaseColor(seg);
	}
	color GetColor(Object seg)
	{
		return m_g.GetColor(seg);
	}
	boolean ShouldAddSegment(Object seg)
	{
		return m_g.ShouldAddSegment(seg);
	}
}
