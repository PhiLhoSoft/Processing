import java.io.File;
import java.io.OutputStream;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;


/**
 * Launcher of an external application.
 */
public class RunApp
{
  private Process m_process;
  private AppDesc m_appDesc;
  private String m_installDir;
  private String m_configDir;
  private String[] m_vmArgs;
  private String[] m_programArgs;

  private StreamGobbler m_errorGobbler;
  private StreamGobbler m_outputGobbler;

// set JAVA=$_(RELOC)\j2re\bin\java -ms64m -mx196m -Djava.ext.dirs=$_(RELOC)\lib;$_(RELOC)\jar\lib;$_(RELOC)\jar
  private static final String[] s_javaArgs =
  {
    "?i/j2re/bin/java",
    "-ms64m",
    "-mx64m",
    "-Djava.ext.dirs=?i/lib;?i/jar/lib;?i/jar"
  };

  public RunApp(AppDesc ad, String installDir, String configDir)
  {
    m_appDesc = ad;
    m_installDir = installDir;
    m_configDir = configDir;
  }

  public void SetErrorGobbler(StreamGobbler eg)
  {
    m_errorGobbler = eg;
  }
  public void SetOutputGobbler(StreamGobbler og)
  {
    m_outputGobbler = og;
  }
  public void SetVMArgs(String[] vmArgs)
  {
    m_vmArgs = vmArgs;
  }
  public void SetProgramArgs(String[] programArgs)
  {
    m_programArgs = programArgs;
  }

  public OutputStream GetOutputStream()
  {
    return m_process.getOutputStream();
  }

  public void Run()
  {
    try
    {
      RunApplication();
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
    catch (InterruptedException e)
    {
      e.printStackTrace();
    }
  }

  protected int RunApplication()
      throws IOException, InterruptedException
  {
    List<String> params = new ArrayList<String>();
    // The program to run
    if (m_appDesc.IsJava())
    {
      // Java exe and parameters
      params.addAll(ExpandStrings(s_javaArgs));
      // Specific VM arguments
      params.addAll(ExpandStrings(m_appDesc.GetVMArgs()));
      if (m_vmArgs != null)
      {
        params.addAll(ExpandStrings(m_vmArgs));
      }
      params.add(m_appDesc.GetClassPath());
    }
    else
    {
      File f = new File(m_appDesc.GetPath(), m_appDesc.GetName());
      if (m_vmArgs != null)
      {
        params.addAll(ExpandStrings(m_vmArgs));
      }
      params.add(f.getAbsolutePath());
    }
    // Its arguments
    params.addAll(ExpandStrings(m_appDesc.GetProgramArgs()));
    if (m_programArgs != null)
    {
      params.addAll(ExpandStrings(m_programArgs));
    }

    ProcessBuilder processBuilder = new ProcessBuilder(params);
//~		 Map<String, String> env = processBuilder.environment();
//~		 // Manipulate system properties
//~		 System.setProperty(sName, sVal);
//~		 processBuilder.directory(new File(m_strConfigDir));

    m_process = processBuilder.start();
    return CaptureProcessOutput();
  }

  public void Stop()
  {
    m_process.destroy();
  }

  /**
   * Launches stream gobblers for stderr and stdout of the given process
   * in separate threads to avoid buffer overflowing.
   *
   * @return error code returned by the process when it ends
   * @throws IOException
   * @throws InterruptedException
   */
  protected int CaptureProcessOutput()
      throws IOException, InterruptedException
  {
    // Capture error messages
    StreamGobbler errorGobbler = m_errorGobbler;
    if (errorGobbler == null)
    {
      errorGobbler = new
          StreamGobbler(m_process.getErrorStream(), "E", m_appDesc.GetThreadName());
    }
    else
    {
      errorGobbler.SetInputStream(m_process.getErrorStream());
      errorGobbler.SetType("E");
      errorGobbler.SetProcessName(m_appDesc.GetThreadName());
    }

    // Capture output
    StreamGobbler outputGobbler = m_outputGobbler;
    if (outputGobbler == null)
    {
      outputGobbler = new
          StreamGobbler(m_process.getInputStream(), "O", m_appDesc.GetThreadName());
    }
    else
    {
      outputGobbler.SetInputStream(m_process.getInputStream());
      outputGobbler.SetType("O");
      outputGobbler.SetProcessName(m_appDesc.GetThreadName());
    }

    // Start output gobbler threads
    errorGobbler.start();
    outputGobbler.start();

    // Get exit value
    return m_process.waitFor();
//    return 0;
  }

  protected ArrayList<String> ExpandStrings(String[] stra)
  {
    ArrayList<String> alResult = new ArrayList<String>();
    if (stra == null)
      return alResult;
    for (int i = 0; i < stra.length; i++)
    {
      // Super flexible, eh? Ad hoc for the current task, at least...
      alResult.add(stra[i]
          .replaceAll("\\?i", m_installDir)
          .replaceAll("\\?c", m_configDir)
      );
    }
    return alResult;
  }
}
