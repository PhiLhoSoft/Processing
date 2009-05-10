class MessageDisplayer
{
  String m_sentence;
  Drawer m_drawer;
  int m_startFrame;
  int m_endFrame;

  MessageDisplayer(String sentence, Drawer drawer)
  {
    m_sentence = sentence;
    m_drawer = drawer;
    m_startFrame = frameCount;
    m_endFrame = m_startFrame + drawer.GetDuration();
  }
  void Draw()
  {
    m_drawer.Draw(m_sentence, 10, 10, frameCount - m_startFrame);
  }
  boolean HasEnded()
  {
    return m_startFrame >= m_endFrame;
  }
}
