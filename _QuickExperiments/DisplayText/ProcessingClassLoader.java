import java.net.URL;

import processing.core.PApplet;

/**
 * Class loader used only to load resources in typical Processing setup.
 * Default class loaders look in class path, ie. Processing libs and where the class files are,
 * typically in a randomly named build folder in system's temp dir.
 * This class loader looks in the sketch's data folder instead, because that's where
 */
public class ProcessingClassLoader extends ClassLoader
{
  private PApplet m_pa;

  public ProcessingClassLoader(PApplet pa)
  {
    super();
    m_pa = pa;
  }

  @Override
  public URL getResource(String name)
  {
    String textURL = "file:///" + m_pa.dataPath(name);
    System.out.println("getResource " + textURL);
    URL url = null;
    try
    {
      url = new URL(textURL);
    }
    catch (java.net.MalformedURLException e)
    {
      System.out.println("ProcessingClassLoader - Incorrect URL: " + textURL);
    }
    return url;
  }

  // Not necessary, mostly there to see if it is used...
  @Override
  public Class loadClass(String name, boolean resolve)
      throws ClassNotFoundException
  {
    System.out.println("loadClass: " + name);
    return findSystemClass(name);
  }
}
