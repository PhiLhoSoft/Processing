import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Map;

/**
 * Description of an external application.
 */
public class AppDesc
{
  /** Name of the application (class name or name of native runnable file). */
  private String m_name;
  /** To give a human readable name to the generated thread. */
  private String m_threadName;
  /** Classpath of the class, eg. com.foo.bar.SomeClass. */
  private String m_classPath;
  /** Path to the exe, if native. */
  private String m_path;
  // These are useful if you call your application with always the same set of arguments
  private String[] m_vmArgs;
  private String[] m_programArgs;

  // Java application
  AppDesc(String name, String threadName, String classPath,
      String[] vmArgs, String[] programArgs)
  {
    m_name = name;
    m_threadName = threadName;
    m_classPath = classPath;
    m_vmArgs = vmArgs;
    m_programArgs = programArgs;
  }

  // Native application
  AppDesc(String name, String threadName, String path,
      String[] programArgs)
  {
    m_name = name;
    m_threadName = threadName;
    m_path = path;
    m_programArgs = programArgs;
  }

  AppDesc(String name, String threadName, boolean bIsJava, String path)
  {
    m_name = name;
    m_threadName = threadName;
    if (bIsJava)
    {
      m_classPath = path;
    }
    else
    {
      m_path = path;
    }
  }

  public String GetName()
  {
    return m_name;
  }

  public String GetThreadName()
  {
    return m_threadName;
  }

  public String GetClassPath()
  {
    return m_classPath;
  }

  public String GetPath()
  {
    return m_path;
  }

  public boolean IsJava()
  {
    return m_classPath != null;
  }
  public String[] GetVMArgs()
  {
    return m_vmArgs;
  }
  public String[] GetProgramArgs()
  {
    return m_programArgs;
  }
}

