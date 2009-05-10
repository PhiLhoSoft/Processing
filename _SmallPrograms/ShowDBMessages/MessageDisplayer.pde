public interface Drawer
{
  public void Draw(int frame);
  public float GetDuration();
}

public class MessageDisplayer
{
  private Drawer m_drawer;
  private int m_startFrame;
  private int m_endFrame;

  public MessageDisplayer(Drawer drawer)
  {
    m_drawer = drawer;
    m_startFrame = frameCount;
    m_endFrame = m_startFrame + int(drawer.GetDuration() * frameRate);
  }
  public void Draw()
  {
    m_drawer.Draw(frameCount - m_startFrame);
  }
  public boolean HasEnded()
  {
    return m_startFrame + frameCount >= m_endFrame;
  }
}
