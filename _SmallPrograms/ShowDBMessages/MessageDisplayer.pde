public interface Drawer
{
  public void Draw(int frame);
  public float GetDuration();
}

public class MessageDisplayer
{
  private Drawer m_drawer;
  private int m_startFrame;
  private long m_startTime;
  private long m_endTime;

  public MessageDisplayer(Drawer drawer)
  {
    m_drawer = drawer;
    m_startFrame = frameCount;
    m_startTime = millis();
    m_endTime = m_startTime + int(drawer.GetDuration() * 1000);
  }
  public void Draw()
  {
    m_drawer.Draw(frameCount - m_startFrame);
  }
  public boolean HasEnded()
  {
    return millis() >= m_endTime;
  }
}


