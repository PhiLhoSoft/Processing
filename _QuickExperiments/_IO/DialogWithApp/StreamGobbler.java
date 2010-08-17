import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;


/**
 * Generic stream gobbler for running a process.
 * Ref.: <a href="http://www.javaworld.com/javaworld/jw-12-2000/jw-1229-traps.html">When Runtime.exec() won't</a>
 */
public class StreamGobbler extends Thread
{
  InputStream m_is;
  String m_type;
  String m_processName;

  public StreamGobbler()
  {
    m_type = m_processName = "";
  }
  public StreamGobbler(InputStream is, String processName)
  {
    m_is = is;
    m_type = "";
    m_processName = processName;
  }
  public StreamGobbler(InputStream is, String type, String processName)
  {
    m_is = is;
    m_type = type;
    m_processName = processName;
  }

  public void SetInputStream(InputStream is)
  {
    m_is = is;
  }
  public void SetType(String type)
  {
    m_type = type;
  }
  public void SetProcessName(String processName)
  {
    m_processName = processName;
  }

  @Override
  public void run()
  {
    if (m_is == null)
      throw new IllegalStateException("No input stream defined!");
    InputStreamReader isr = new InputStreamReader(m_is);
    BufferedReader br = new BufferedReader(isr);
    String line = null;
    try
    {
      while ((line = br.readLine()) != null)
      {
        HandleOutputLine(line);
      }
    }
    catch (IOException ioe)
    {
      ioe.printStackTrace();
    }
    finally
    {
      if (br != null)
      {
        try
        {
          br.close();
        }
        catch (IOException ioe)
        {
          ioe.printStackTrace();
        }
      }
    }
  }

  protected String HandleOutputLine(String line)
  {
    // Default implementation, to override
    String l = m_processName + " " + m_type + "> " + line;
    System.out.println(l);
    return l;
  }
}
