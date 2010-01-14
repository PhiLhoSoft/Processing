

/*
String[] s = loadStrings("http://localhost/Web/HTML.txt");
println(s[0]);
*/
void setup()
{
  String username = "plhoste";
  String password = "philippe";
  URL authurl = null;
  try
  {
    authurl = new URL("http://localhost/Web/HTML.txt");
  }
  catch (MalformedURLException e) {}
  Authenticator.setDefault(new MyAuthenticator(username, password));
  BufferedReader in = null;
  ArrayList readLines = new ArrayList();
  String inputLine;
  try
  {
    URLConnection ac = authurl.openConnection();
    in = new BufferedReader(
        new InputStreamReader(ac.getInputStream()));
    while ((inputLine = in.readLine()) != null)
    {
      readLines.add(inputLine);
    }
  }
  catch (IOException e) {}
  finally
  {
    if (in != null) try { in.close(); } catch (IOException e) {}
  }
  String[] s = new String[readLines.size()];
  readLines.toArray(s);
  println(s[0]);
}

protected static class MyAuthenticator extends Authenticator
{
  private String username, password;

  public MyAuthenticator(String user, String pwd)
  {
    username = user;
    password = pwd;
  }

  protected PasswordAuthentication getPasswordAuthentication()
  {
    return new PasswordAuthentication(username, password.toCharArray());
  }
}

