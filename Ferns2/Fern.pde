/**
Definition of a fern.

// by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
// File/Project history:
 1.01.000 -- 2008/05/15 (PL) -- Implementation of genotype.
 1.00.000 -- 2008/05/12 (PL) -- First viable fern.
 0.01.000 -- 2008/05/07 (PL) -- Start of serious work.
 0.00.000 -- 2008/04/15 (PL) -- Start of creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/

class Trunk extends Segment
{
	private Trunk m_nextTrunkSegment;	// The trunk part attached on this one (smaller)
	private Branch m_leftBranch;	// One branch attached to base of this trunk segment
	private Branch m_rightBranch;	// The other branch

	/** Default constructor, stump (first trunk segment)
	 */
	Trunk(GeomPoint startPosition, Genotype genotype)
	{
		super(startPosition, genotype);
		SetLength(genotype.GetBaseLength(null));
		SetWidth(genotype.GetBaseWidth(null));
		SetAbsoluteAngle(genotype.GetAbsoluteAngle(null, false));
		SetColor(genotype.GetBaseColor(null));

		Init();
	}

	/** Trunk constructor, based on the previous trunk segment:
	 * slight change of length, angle and color.
	 */
	Trunk(Trunk previousTrunkSegment)
	{
		super(previousTrunkSegment);

		SetLength(m_genotype.GetLength(previousTrunkSegment));
		SetWidth(m_genotype.GetWidth(previousTrunkSegment));
		SetAngle(m_genotype.GetAngle(previousTrunkSegment, false));
		SetColor(m_genotype.GetColor(previousTrunkSegment));

		Init();
	}

	private void Init()
	{
		if (m_genotype.ShouldAddSegment(this))
		{
			m_nextTrunkSegment = new Trunk(this);
		}
		m_leftBranch = new Branch(this, true);
		m_rightBranch = new Branch(this, false);
	}

	void Draw()
	{
		GetVector().Draw();
		if (m_leftBranch != null)
			m_leftBranch.Draw();
		if (m_rightBranch != null)
			m_rightBranch.Draw();
		if (m_nextTrunkSegment != null)
			m_nextTrunkSegment.Draw();
	}
}

class Branch extends Segment
{
	private Branch m_nextBranchSegment;	// The branch part attached on this one (smaller)
	private boolean m_bIsLeftBranch;
	private Leaf m_leftLeaf;	// One leaf attached to top of this branch segment
	private Leaf m_rightLeaf;	// The other leaf

	Branch(Trunk baseTrunk, boolean bIsLeftBranch)
	{
		super(baseTrunk);
		m_bIsLeftBranch = bIsLeftBranch;

		SetLength(m_genotype.GetBaseLength(baseTrunk));
		SetWidth(m_genotype.GetBaseWidth(baseTrunk));
		SetAbsoluteAngle(m_genotype.GetAbsoluteAngle(baseTrunk, bIsLeftBranch));
		SetColor(m_genotype.GetBaseColor(baseTrunk));

		Init();
	}

	Branch(Branch previousBranchSegment)
	{
		super(previousBranchSegment);
		m_bIsLeftBranch = previousBranchSegment.IsLeftBranch();

		SetLength(m_genotype.GetLength(previousBranchSegment));
		SetWidth(m_genotype.GetWidth(previousBranchSegment));
		SetAngle(m_genotype.GetAngle(previousBranchSegment, m_bIsLeftBranch));
		SetColor(m_genotype.GetColor(previousBranchSegment));

		Init();
	}

	private void Init()
	{
		if (m_genotype.ShouldAddSegment(this))
		{
			m_nextBranchSegment = new Branch(this);
		}
		m_leftLeaf = new Leaf(this, true);
		m_rightLeaf = new Leaf(this, false);
	}

	void Draw()
	{
		GetVector().Draw();
		if (m_leftLeaf != null)
			m_leftLeaf.Draw();
		if (m_rightLeaf != null)
			m_rightLeaf.Draw();
		if (m_nextBranchSegment != null)
			m_nextBranchSegment.Draw();
	}

	boolean IsLeftBranch()
	{
		return m_bIsLeftBranch;
	}
}

class Leaf extends Segment
{
	private boolean m_bIsLeftLeaf;

	Leaf(Branch baseBranch, boolean bIsLeftLeaf)
	{
		super(baseBranch);

		m_bIsLeftLeaf = bIsLeftLeaf;
		SetWidth(m_genotype.GetBaseWidth(baseBranch));
		SetLength(m_genotype.GetBaseLength(baseBranch));
		SetAbsoluteAngle(m_genotype.GetAbsoluteAngle(baseBranch, m_bIsLeftLeaf));
		SetColor(m_genotype.GetBaseColor(baseBranch));
	}

/* Use default, might be overridden in future versions
	void Draw()
	{
 		GetVector().Draw();
	}
*/

	boolean IsLeftLeaf()
	{
		return m_bIsLeftLeaf;
	}
}
