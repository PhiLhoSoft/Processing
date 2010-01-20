// http://processing.org/discourse/yabb2/YaBB.pl?num=1263989874

// [url=http://www.javakb.com/Uwe/Forum.aspx/java-programmer/17592/Newbie-How-do-you-request-a-web-page-from-within-Java]Newbie - How do you request a web page from within Java?[/url]
String QUERY = "http://www.google.de/search?q=Processing";

void setup()
{
  String[] results = null;
  try
  {
    URL url= new URL(QUERY);
    URLConnection connection = url.openConnection();
    // Google rejects pure API requests, so we change the header of the request
    // to make it believe it is requested by a real browser... :)
    connection.setRequestProperty("User-Agent",
        "I am a real browser like Mozilla or MSIE" );
    results = loadStrings(connection.getInputStream());
  }
  catch (Exception e) // MalformedURL, IO
  {
    e.printStackTrace();
  }

  if (results != null)
  {
    println(results[2]);
  }
}
