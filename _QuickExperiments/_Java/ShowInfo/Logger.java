import java.io.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class Logger
{
  private String m_fileName;
  private PrintWriter m_pw;
  private OutputStream m_os;
  private DateFormat m_dateFormat;

  public Logger(String fileName)
  {
    m_fileName = fileName;
  }
  public Logger(OutputStream os)
  {
    m_os = os;
  }

  public void setDateFormat(String dateFormat)
  {
    m_dateFormat = new SimpleDateFormat(dateFormat);
  }

  public void log(String line)
  {
    createPrintWriter();
    printLN(line);
    destroyPrintWriter();
  }

  public void log(String[] lines)
  {
    createPrintWriter();
    if (m_pw != null && lines != null)
    {
      for (int i = 0; i < lines.length; i++)
      {
        printLN(lines[i]);
      }
    }
    destroyPrintWriter();
  }

  public void log(String errorMessage, Exception ex)
  {
    createPrintWriter();
    if (m_pw == null)
      return;
    if (ex == null)
    {
      printLN(errorMessage);
      return;
    }
    StackTraceElement[] ste = ex.getStackTrace();
    StringBuilder sb = new StringBuilder();
    sb.append(errorMessage).append("\nException: ").append(ex.toString()).append("\n");
    for (int i = 0; i < ste.length; i++)
    {
      sb.append("\tat ").append(ste[i].getClassName()).append(".")
          .append(ste[i].getMethodName()).append("(")
          .append(ste[i].getFileName()).append(":").append(ste[i].getLineNumber()).append(")\n");
    }
    printLN(sb.toString());
    destroyPrintWriter();
  }

  private void createPrintWriter()
  {
    if (m_fileName != null)
    {
      // Create a file writer in append mode
      try
      {
        m_pw = new PrintWriter(new FileWriter(m_fileName, true));
      }
      catch (IOException e)
      {
        e.printStackTrace(); // Dumb and primitive exception handling...
        m_pw = null;
      }
    }
    else if (m_os != null)
    {
      // Use autoflush, since we don't close the PrintWriter
      m_pw = new PrintWriter(m_os, true);
    }
    else
    {
      System.err.println("Invalid logger: no file name nor output stream");
    }
  }

  private void destroyPrintWriter()
  {
    // Don't close if using an OutputStream
    // as it would close the stream, which has the responsibility
    // of the logger user (and thus we avoid closing System.out, for example!).
    if (m_pw != null && m_fileName != null)
    {
      m_pw.close();
    }
    m_pw = null;
  }

  private void printLN(String line)
  {
    if (m_pw == null)
      return;

    if (m_dateFormat != null)
    {
      line = m_dateFormat.format(new Date()) + " - " + line;
    }
    m_pw.println(line);
  }
}
