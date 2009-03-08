/**
Draw ferns for the Ani-Jam 2008 project in deviantART.

http://news.deviantart.com/article/43484/
Sequences must be in MOV or AVI format
Animation to 24 FPS at 720x480 resolution
Animation must be no shorter than 10 seconds, and no longer than 1 minute

// by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
// File/Project history:
 1.02.000 -- 2008/05/18 (PL) -- Animation.
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

//import java.util.ArrayList;

import processing.video.*;
final boolean bExportVideo = false;

final int CANVAS_WIDTH  = 720;
final int CANVAS_HEIGHT = 480;
final int MAX_FRAME_NB  = 720;
final float MAX_AGE = 2.0;	// Maximum value of age

final int SLOT_NB = 9;
final float FERN_SPACING = (float)CANVAS_WIDTH / (float)(SLOT_NB + 1);

final color START_COLOR_TOP    = #335533;
final color START_COLOR_BOTTOM = #55AA55;
final color END_COLOR_TOP      = #333355;
final color END_COLOR_BOTTOM   = #5555AA;

final float ROOT_POS_Y = CANVAS_HEIGHT * 0.99;

ArrayList ferns;

MovieMaker mm;

class Fern
{
	private final static int LS_NOT_BORN = 0;
	private final static int LS_LIVING = 1;
	private final static int LS_DEAD = 2;

	private Point m_position;
	private Genotype m_genotype;
	private float m_startTime;
	private float m_endTime;
	private int m_lifeState = LS_NOT_BORN;

	Fern(Genotype genotype, float startTime, float endTime)
	{
		this(null, genotype, startTime, endTime);
	}

	Fern(Point position, Genotype genotype, float startTime, float endTime)
	{
		m_position = position;
		m_genotype = genotype;
		m_startTime = startTime * (float)MAX_FRAME_NB / MAX_AGE;
		m_endTime = endTime * (float)MAX_FRAME_NB / MAX_AGE;
	}

	//~ int i = 0;
	private Point GetFernPosition()
	{
	//~ 	return new Point(random(CANVAS_WIDTH * 0.05, CANVAS_WIDTH * 0.95), ROOT_POS_Y);
	//~ 	return new Point(++i * FERN_SPACING, ROOT_POS_Y);
	//~ 	return new Point(random(i * FERN_SPACING, ++i * FERN_SPACING), ROOT_POS_Y);
		int pos = int(random(1, SLOT_NB));
		float xPos = FERN_SPACING / 2 + random((pos - 1) * FERN_SPACING, pos * FERN_SPACING);
//~ 		println(xPos);
		return new Point(xPos, ROOT_POS_Y);
	}

	Point GetPosition() { return m_position; }
	Genotype GetGenotype() { return m_genotype; }

	void Update()
	{
		if (m_position != null)
		{
			m_position = m_position.Move(0.66, -90);
		}

		switch (m_lifeState)
		{
		case LS_NOT_BORN:
			if ((float)frameCount >= m_startTime)
			{
//~ 				println("Born: " + frameCount + " >= " + m_startTime);
				m_lifeState = LS_LIVING;
				m_position = GetFernPosition();	// Dynamic position within the screen
			}
			break;
		case LS_LIVING:
			if ((float)frameCount > m_endTime)
			{
				m_lifeState = LS_DEAD;
			}
			break;
		case LS_DEAD:
		default:
			break;
		}

//~ 		m_genotype.SetAge();
	}

	boolean IsLiving()
	{
		return m_lifeState == LS_LIVING;
	}
}

color InterpolateColor(color startC, color endC)
{
	return lerpColor(startC, endC, (float)frameCount / (float)MAX_FRAME_NB);
}


void DrawBackground()
{
	color topColor = InterpolateColor(START_COLOR_TOP, END_COLOR_TOP);
	color bottomColor = InterpolateColor(START_COLOR_BOTTOM, END_COLOR_BOTTOM);
	for (int l = 0; l < CANVAS_HEIGHT; l++)
	{
		color sc = lerpColor(topColor, bottomColor, (float)l / (float)CANVAS_HEIGHT);
		stroke(sc);
		line(0, l, CANVAS_WIDTH - 1, l);
	}
}

void setup()
{
	smooth();
	frameRate(24);
//~ 	noLoop();	// No animation
	size(CANVAS_WIDTH, CANVAS_HEIGHT);

	ferns = new ArrayList();

	ferns.add(new Fern(new Genotype01(), 0.30, 0.70));	// Big
	ferns.add(new Fern(new Genotype02(), 0.69, 1.10));	// Very big
	ferns.add(new Fern(new Genotype03(), 0.40, 0.75));	// Big
	ferns.add(new Fern(new Genotype04(), 0.00, 0.35));	// Young
	ferns.add(new Fern(new Genotype07(), 0.45, 0.67));	// Big
	ferns.add(new Fern(new Genotype08(), 0.10, 0.27));	// Young
	ferns.add(new Fern(new Genotype06(), 0.55, 0.80));	// Big
	ferns.add(new Fern(new Genotype09(), 0.15, 0.46));	// Small
	ferns.add(new Fern(new Genotype05(), 0.72, 0.90));	// Very big

	ferns.add(new Fern(new Genotype02(true, #00A030), 1.49, 1.76));	// Very big
	ferns.add(new Fern(new Genotype04(true, #308030), 1.40, 1.65));	// Young
	ferns.add(new Fern(new Genotype01(true, #208030), 1.30, 1.70));	// Big
	ferns.add(new Fern(new Genotype07(true, #30B030), 0.91, 1.47));	// Big
	ferns.add(new Fern(new Genotype05(true, #005010), 1.72, 1.99));	// Very big
	ferns.add(new Fern(new Genotype08(true, #208010), 0.98, 1.37));	// Young
	ferns.add(new Fern(new Genotype06(true, #207050), 1.35, 1.80));	// Big
	ferns.add(new Fern(new Genotype09(true, #007000), 1.25, 1.66));	// Small
	ferns.add(new Fern(new Genotype03(true, #206000), 1.40, 1.75));	// Big

	if (bExportVideo)
	{
		mm = new MovieMaker(this, width, height, "ferns_by_philho.mov", 24,
				MovieMaker.JPEG, MovieMaker.BEST);
	}
}

void draw()
{
	if (frameCount > MAX_FRAME_NB)
	{
		if (bExportVideo)
		{
			mm.finish();
			delay(1000);
		}
		exit();
	}
	DrawBackground();

	for (int i = 0; i < ferns.size(); i++)
	{
		Fern fern = (Fern)ferns.get(i);
		fern.Update();
		if (fern.IsLiving())
		{
			Plant p = new Plant(fern.GetPosition(), fern.GetGenotype());
			p.Draw();
		}
	}

	if (bExportVideo)
	{
		mm.addFrame();
	}
}
