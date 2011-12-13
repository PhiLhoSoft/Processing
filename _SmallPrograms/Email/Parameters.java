import java.io.*;
import java.util.Properties;

/**
 * Simple properties reader.
 * @author Philippe Lhoste
 */
class Parameters extends Properties
{
  private Properties parameters;

  public Parameters(String propertyFilePath)
  {
    File propertiesFile = new File(propertyFilePath);
    FileInputStream fis = null;
    try
    {
      fis = new FileInputStream(propertiesFile);
      parameters = new Properties();
      parameters.load(fis);
    }
    catch (Exception e)
    {
      System.err.println("Failed to read from " + propertiesFile.getAbsolutePath() + ": " + e.getMessage());
    }
    finally
    {
      try
      {
        if (fis != null)
        {
          fis.close();
        }
      }
      catch (Exception e)
      {
        System.err.println("Failed to close " + propertiesFile.getAbsolutePath() + ": " + e.getMessage());
      }
    }
  }

  public String getProperty(String propertyName)
  {
    return parameters.getProperty(propertyName);
  }
}

