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

	/**
	 * Updates the state of the handle.
	 * @param bAlreadyDragging   if true, a dragging is already in effect
	 */
	void Update(boolean bAlreadyDragging)
	{
      // Check if mouse is over the handle
		m_bIsHovered = dist(mouseX, mouseY, m_x, m_y) <= m_size / 2;
      // If we are not already dragging and left mouse is pressed over the handle
		if (!bAlreadyDragging && mousePressed && mouseButton == LEFT && m_bIsHovered)
		{
         // We record the state
			m_bDragged = true;
         // And memorize the offset of the mouse position from the center of the handle
			m_clickDX = mouseX - m_x;
			m_clickDY = mouseY - m_y;
		}
      // If mouse isn't pressed
		if (!mousePressed)
		{
         // Any possible dragging is stopped
			m_bDragged = false;
		}
	}

	boolean IsDragged()
	{
		return m_bDragged;
	}

   /**
    * If the handle is dragged, the new position is computed with mouse position,
    * taking in account the offset of mouse with center of handle.
    */
	void Move()
	{
		if (m_bDragged)
		{
			m_x = mouseX - m_clickDX;
			m_y = mouseY - m_clickDY;
		}
	}

   /**
    * Just draw the handle at current posiiton, with color depending if it is dragged or not.
    */
	void Draw()
	{
		strokeWeight(m_lineWidth);
		stroke(m_colorLine);
		fill(m_bIsHovered ? m_colorHover : m_colorFill);

		ellipse(m_x, m_y, m_size, m_size);
	}
}
