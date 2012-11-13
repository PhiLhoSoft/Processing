/**
 * The list of all handles in the sketch.
 */
class HandleList
{
  private ArrayList<Handle> m_handles = new ArrayList<Handle>();
  private boolean m_bDragging;

  HandleList()
  {
  }

  void add(Handle h)
  {
    m_handles.add(h);
  }

  void update()
  {
    // We suppose we are not dragging by default
    boolean bDragging = false;
    // Check each handle
    for (Handle h : m_handles)
    {
      // Check if the user tries to drag it
      h.update(m_bDragging);
      // Ah, this one is indeed dragged!
      if (h.isDragged())
      {
        // We will remember a dragging is being done
        bDragging = true;
        m_bDragging = true; // Notify immediately we are dragging something
        // And we move it to the mouse position
        h.move();
      }
      // In all cases, we redraw the handle
      h.display();
    }
    // If no dragging is found, we reset the state
    m_bDragging = bDragging;
  }
}
