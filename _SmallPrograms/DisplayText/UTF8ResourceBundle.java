import java.util.ResourceBundle;
import java.util.PropertyResourceBundle;
import java.util.Locale;
import java.util.Enumeration;

// ResourceBundles are loaded in ISO-8859-1 codepage by Java.
// I found a trick in a blog article to load them in UTF-8 instead.
// Quick and Dirty Hack for UTF-8 Support in ResourceBundle
// <http://www.thoughtsabout.net/blog/archives/000044.html>
// Doesn't extend ResourceBundle because getBundle are final...
public abstract class UTF8ResourceBundle
{
  // I keep the public API compatible with ResourceBundle
  public static final ResourceBundle getBundle(String baseName)
  {
    ResourceBundle bundle = ResourceBundle.getBundle(baseName);
    return createUTF8ResourceBundle(bundle);
  }

  public static final ResourceBundle getBundle(String baseName, Locale locale)
  {
    ResourceBundle bundle = ResourceBundle.getBundle(baseName, locale);
    return createUTF8ResourceBundle(bundle);
  }

  public static final ResourceBundle getBundle(String baseName, Locale locale, ClassLoader loader)
  {
    ResourceBundle bundle = ResourceBundle.getBundle(baseName, locale, loader);
    return createUTF8ResourceBundle(bundle);
  }

  private static ResourceBundle createUTF8ResourceBundle(ResourceBundle bundle)
  {
    // Trick is used only for property resource bundles, not for class resource bundles!
    if (!(bundle instanceof PropertyResourceBundle))
      return bundle;

    return new UTF8PropertyResourceBundle((PropertyResourceBundle) bundle);
  }

  private static class UTF8PropertyResourceBundle extends ResourceBundle
  {
    PropertyResourceBundle m_bundle;

    private UTF8PropertyResourceBundle(PropertyResourceBundle bundle)
    {
      m_bundle = bundle;
    }

    @Override
    public Object handleGetObject(String key)
    {
      // Use getString (instead of handleGetObject) because:
      // 1) It is only a PropertyResourceBundle
      // 2) It allows fallback on parent bundle
      String value = (String) m_bundle.getString(key);
      if (value == null)
        return null;

      try
      {
        // The default resource bundle returns ISO-8859-1 strings. We get the bytes using this encoding,
        // then transform them to string using UTF-8 encoding, which is the real encoding of the files
        // (UTF-8 chars are valid ISO-8859-1 chars!)
        return new String(value.getBytes("ISO-8859-1"), "UTF-8");
      }
      catch (java.io.UnsupportedEncodingException e)
      {
        return null; // Shouldn't go there if encoding strings above are OK...
      }
    }

    @Override
    public Enumeration<String> getKeys()
    {
      return m_bundle.getKeys();
    }
  }
}
