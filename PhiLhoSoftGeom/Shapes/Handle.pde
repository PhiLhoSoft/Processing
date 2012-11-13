/**
 * A circle that can be dragged with the mouse.
 */
class Handle
{
  ClosedShape m_shape;
  int m_lineWidth;
  color m_colorLine;
  color m_colorFill;
  color m_colorHover;
  color m_colorDrag;

  private boolean m_bIsHovered, m_bDragged;
  private PLSVector m_clickPosition = new PLSVector();

  /**
   * Simple constructor with hopefully sensible defaults.
   */
  Handle(float x, float y)
  {
    this(x, y, 5, 1, #000000, #FFFFFF, #FFFF00, #FF8800);
  }

  /**
   * Full constructor.
   */
  Handle(float x, float y, int size, int lineWidth,
      color colorLine, color colorFill, color colorHover, color colorDrag
  )
  {
    m_shape = new Circle(x, y, size / 2.0);
    m_lineWidth = lineWidth;
    m_colorLine = colorLine;
    m_colorFill = colorFill;
    m_colorHover = colorHover;
    m_colorDrag = colorDrag;
  }

  /**
   * Updates the state of the handle depending on the mouse position.
   *
   * @param bAlreadyDragging  if true, a dragging is already in effect
   */
  void update(boolean bAlreadyDragging)
  {
    // Check if mouse is over the handle
    m_bIsHovered = m_shape.contains(mouseX, mouseY);
    // If we are not already dragging and left mouse is pressed over the handle
    if (!bAlreadyDragging && mousePressed && mouseButton == LEFT && m_bIsHovered)
    {
      // We record the state
      m_bDragged = true;
      // And memorize the offset of the mouse position from the center of the handle
      m_clickPosition.add(mouseX, mouseY).add(-m_x, -m_y);
    }
    // If mouse isn't pressed
    if (!mousePressed)
    {
      // Any possible dragging is stopped
      m_bDragged = false;
    }
  }

  boolean isDragged()
  {
    return m_bDragged;
  }

   /**
    * If the handle is dragged, the new position is computed with mouse position,
    * taking in account the offset of mouse with center of handle.
    */
  void move()
  {
    if (m_bDragged)
    {
      m_shape.setPosition(mouseX - m_clickDX, mouseY - m_clickDY);
    }
  }

   /**
    * Just draw the handle at current posiiton, with color depending if it is dragged or not.
    */
  void display()
  {
    strokeWeight(m_lineWidth);
    stroke(m_colorLine);
    if (m_bDragged)
    {
      fill(m_colorDrag);
    }
    else if (m_bIsHovered)
    {
      fill(m_colorHover);
    }
    else
    {
      fill(m_colorFill);
    }

    ellipse(m_x, m_y, m_size, m_size);
  }
}
