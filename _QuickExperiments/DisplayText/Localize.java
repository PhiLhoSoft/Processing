import java.util.ResourceBundle;
import java.util.PropertyResourceBundle;
import java.util.Locale;
import java.util.Enumeration;
import java.net.URL;

abstract class ProcessingResourceBundle
{
  public static final ResourceBundle getBundle(String baseName)
  {
    ResourceBundle bundle = ResourceBundle.getBundle(baseName);
    return createCustomResourceBundle(bundle);
  }

  public static final ResourceBundle getBundle(String baseName, Locale locale)
  {
    ResourceBundle bundle = ResourceBundle.getBundle(baseName, locale);
    return createCustomResourceBundle(bundle);
  }

  public static ResourceBundle getBundle(String baseName, Locale locale, ClassLoader loader)
  {
    ResourceBundle bundle = ResourceBundle.getBundle(baseName, locale, loader);
    return createCustomResourceBundle(bundle);
  }

  private static ResourceBundle createCustomResourceBundle(ResourceBundle bundle)
  {
    if (!(bundle instanceof PropertyResourceBundle))
      return bundle;

    return new CustomResourceBundle((PropertyResourceBundle) bundle);
  }

  private static class CustomResourceBundle extends ResourceBundle
  {
    PropertyResourceBundle bundle;

    private CustomResourceBundle(PropertyResourceBundle bundle)
    {
      this.bundle = bundle;
    }

    public Enumeration getKeys()
    {
      return bundle.getKeys();
    }

    protected Object handleGetObject(String key)
    {
      String value = (String) bundle.handleGetObject(key);
      if (value == null)
        return null;
      try
      {
        return new String(value.getBytes("ISO-8859-1"), "UTF-8");
      }
      catch (java.io.UnsupportedEncodingException e)
      {
        return null; // Shouldn't go there if strings above are OK...
      }
    }
  }
}

class ProcessingClassLoader extends ClassLoader
{
  String sketchPath;
  ProcessingClassLoader(String path)
  {
    System.out.println(path);
    sketchPath = "file:///" + path + java.io.File.separator;
  }
  public URL getResource(String name)
  {
    URL url = null;
    System.out.println("Get " + name);
    try
    {
      url = new URL(sketchPath + name);
    }
    catch (java.net.MalformedURLException e) {}
    return url;
  }

  public Class loadClass(String name, boolean resolve)
      throws ClassNotFoundException 
  {
    System.out.println("loadClass: " + name);
    return findSystemClass(name);
  }
}

/*
class ProcessingResourceBundle extends ResourceBundle
{
  private Map lookup;

  ProcessingResourceBundle(InputStream stream) throws IOException
  {
    Properties props = new Properties();
    props.load(stream);
    lookup = new HashMap(properties);
  }
  protected Object handleGetObject(String key)
  {
    if (key == null)
      throw new NullPointerException();
    return lookup.get(key);
  }
  public Enumeration getKeys()
  {
//~     retun props.propertyNames();
    ResourceBundle parent = this.parent;
    return new ResourceBundleEnumeration(lookup.keySet(),
        (parent != null) ? parent.getKeys() : null);
  }
}
*/
