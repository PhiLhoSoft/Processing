// I use a (simplistic) logger, shown in
// [url=http://processing.org/discourse/yabb2/YaBB.pl?num=1196069582/8]Processing 1.0 - Processing to send e-mail or SMS?[/url])
// not because it is useful here, but because I needed some dumb/simple code to illustrate its usage...

void setup() // Must add it because I use a class
{

// Use:
//Logger logger = new Logger(sketchPath("Information.txt"));
// or:
Logger logger = new Logger(System.err);

String[] props =
{
  System.getProperty("java.version"),
  System.getProperty("java.home"),
  System.getProperty("java.vendor"),
  System.getProperty("java.vendor.url")
};
logger.log(props);
String cp = System.getProperty("java.class.path");
logger.log(cp);
String ed = System.getProperty("java.ext.dirs");
logger.log(ed);
logger.setDateFormat("yyyy-MM-dd HH:mm:ss");
logger.log(sketchPath);
try
{
  logger.log(java.net.URLEncoder.encode("http://stackoverflow.com/questions/292362/url ⌘⍺ decoding#293028", "UTF-8"));
}
catch (java.io.UnsupportedEncodingException e)
{
  logger.log("Bad encoding!", e);
}
try
{
  // Voluntary stupid encoding value... :)
  logger.log(java.net.URLEncoder.encode("http://stackoverflow.com", "UTF-128"));
}
catch (java.io.UnsupportedEncodingException e)
{
  logger.log("Bad encoding!", e);
}
exit();

}
