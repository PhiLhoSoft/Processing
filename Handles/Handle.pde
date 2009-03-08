/**
Handle class: draw a circle than can be dragged with the mouse.
http://processing.org/

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2008/04/29 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/

class Handle
{
	// Lazy (Processing) class: leave direct access to parameters... Avoids having lot of setters.
	float m_x, m_y;	// Position of handle
	int m_size;	// Diameter of handle
	int m_lineWidth;
	color m_colorLine;
	color m_colorFill;
	color m_colorHover;

	private boolean m_bIsHovered, m_bDragged;
	private float m_clickDX, m_clickDY;

	/**
	 * Simple constructor with hopefully sensible defaults.
	 */
	Handle(float x, float y)
	{
		this(x, y, 5, 1, #000000, #FFFFFF, #FFFF00);
	}

	/**
	 * Full constructor.
	 */
	Handle(float x, float y, int size,
			int lineWidth, color colorLine, color colorFill, color colorHover
	)
	{
		m_x = x; m_y = y;
		m_size = size;
		m_lineWidth = lineWidth;
		m_colorLine = colorLine;
		m_colorFill = colorFill;
		m_colorHover = colorHover;
	}

	boolean IsDragged()
	{
		return m_bDragged;
	}

	void Update(boolean bAlreadyDragging)
	{
		m_bIsHovered = dist(mouseX, mouseY, m_x, m_y) <= m_size / 2;
		if (!bAlreadyDragging && mousePressed && mouseButton == LEFT && m_bIsHovered)
		{
			m_bDragged = true;
			m_clickDX = mouseX - m_x;
			m_clickDY = mouseY - m_y;
		}
		if (!mousePressed)
		{
			m_bDragged = false;
		}
	}

	void Move()
	{
		if (m_bDragged)
		{
			m_x = mouseX - m_clickDX;
			m_y = mouseY - m_clickDY;
		}
	}

	void Draw()
	{
		strokeWeight(m_lineWidth);
		stroke(m_colorLine);
		fill(m_bIsHovered ? m_colorHover : m_colorFill);

		ellipse(m_x, m_y, m_size, m_size);
	}
}
