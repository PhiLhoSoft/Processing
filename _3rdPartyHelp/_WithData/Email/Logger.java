import java.io.*;

/**
 * Simple logger.
 * @author Philippe Lhoste
 */
class Logger
{
  String m_fileName;

  Logger(String fileName)
  {
    m_fileName = fileName;
  }

  void log(String line)
  {
    PrintWriter pw = null;
    try
    {
      pw = GetWriter();
      pw.println(line);
    }
    catch (IOException e)
    {
      e.printStackTrace(); // Dumb and primitive exception handling...
    }
    finally
    {
      if (pw != null)
      {
        pw.close();
      }
    }
  }

  void log(String[] lines)
  {
    PrintWriter pw = null;
    try
    {
      pw = GetWriter();
      for (int i = 0; i < lines.length; i++)
      {
        pw.println(lines[i]);
      }
    }
    catch (IOException e)
    {
      e.printStackTrace(); // Dumb and primitive exception handling...
    }
    finally
    {
      if (pw != null)
      {
        pw.close();
      }
    }
  }

  void log(String errorMessage, StackTraceElement[] ste)
  {
    PrintWriter pw = null;
    try
    {
      pw = GetWriter();
      pw.println(errorMessage);
      for (int i = 0; i < ste.length; i++)
      {
        pw.println("\tat " + ste[i].getClassName() + "." + ste[i].getMethodName() +
            "(" + ste[i].getFileName() + ":" + ste[i].getLineNumber() + ")"
        );
      }
    }
    catch (IOException e)
    {
      e.printStackTrace(); // Dumb and primitive exception handling...
    }
    finally
    {
      if (pw != null)
      {
        pw.close();
      }
    }
  }

  private PrintWriter GetWriter() throws IOException
  {
    // FileWriter with append, BufferedWriter for performance
    // (although we close each time, not so efficient...), PrintWriter for convenience
    return new PrintWriter(new BufferedWriter(new FileWriter(m_fileName, true)));
  }
}

