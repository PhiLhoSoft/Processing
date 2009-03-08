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

/** A segment of the plant: part of the trunk, of a branch or a leaf.
 */
abstract class Segment
{
	private Vector m_vector;	// Position, size, direction, color and width of the segment
	Genotype m_genotype;
	private Segment m_baseSegment;	// The segment to which this one is attached
	private float m_relativeAngle;	// Relative to base segment

	Segment(Point basePoint, Genotype genotype)
	{
		m_genotype = genotype;
		m_baseSegment = null;
		m_vector = new Vector(
				basePoint,
				#000000,
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
		m_vector = new Vector(baseSegment.GetVector());
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
	void SetColor(color segColor)
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
	color GetColor()
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


class Trunk extends Segment
{
	private Trunk m_nextTrunkSegment;	// The trunk part attached on this one (smaller)
	private Branch m_leftBranch;	// One branch attached to base of this trunk segment
	private Branch m_rightBranch;	// The other branch

	/** Default constructor, stump (first trunk segment)
	 */
	Trunk(Point startPosition, Genotype genotype)
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

	void Draw()
	{
 		GetVector().Draw();
	}

	boolean IsLeftLeaf()
	{
		return m_bIsLeftLeaf;
	}
}

// I would have used Segment, not Object, but apparently internal interfaces are static and cannot access
// non static classes... :( Ugly but it works.
interface Genotype
{
	float GetBaseLength(Object seg);
	float GetLength(Object seg);
	float GetBaseWidth(Object seg);
	float GetWidth(Object seg);
	float GetAbsoluteAngle(Object seg, boolean bIsLeft);
	float GetAngle(Object seg, boolean bIsLeft);
	color GetBaseColor(Object seg);
	color GetColor(Object seg);
	boolean ShouldAddSegment(Object seg);
}

class Plant
{
	private Trunk m_stump;

	Plant(Point position, Genotype genotype)
	{
		m_stump = new Trunk(position, genotype);
	}

	void Draw()
	{
		m_stump.Draw();
	}
}
