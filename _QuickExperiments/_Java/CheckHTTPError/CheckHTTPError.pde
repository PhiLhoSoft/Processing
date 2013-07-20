// https://forum.processing.org/topic/how-can-i-get-html-error-description-from-server-when-loading-xml

import java.net.*;
import java.io.*;

String url1 = "http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?sigla=PL&numero=&ano=1960&datApresentacaoIni=&datApresentacaoFim=&parteNomeAutor=&siglaPartidoAutor=&siglaUFAutor=&generoAutor=&IdSituacaoProposicao=&IdOrgaoSituacaoProposicao=&&codEstado=&codOrgaoEstado=&emTramitacao=";
String url2 = "http://Processing.org";

// With information frm http://stackoverflow.com/questions/4596447/java-check-if-file-exists-on-remote-server-using-its-url

URL url = null;
try
{
  url = new URL(url1);
}
catch (MalformedURLException e)
{
  println("Error in URL " + e);
  exit();
}
 
HttpURLConnection connection = null;
try
{
  connection = (HttpURLConnection) url.openConnection();
  connection.setRequestMethod("GET"); // HEAD doesn't allow to get the error input stream
  int code = connection.getResponseCode();
  if (code != HttpURLConnection.HTTP_OK)
  {
    println("Answer: " + code + " - " + connection.getResponseMessage());
    InputStream error = connection.getErrorStream();
    if (error != null)
    {
      println("Error response:");
      String[] lines = loadStrings(error);
      println(lines);
      error.close();
    }
    println("Error header:");
    String field = null;
    int i = 0;
    do
    {
      field = connection.getHeaderField(i);
      String key = connection.getHeaderFieldKey(i);
      if (field != null)
      {
        println("Header " + i + ": " + (key == null ? "" : key + "=") + field);
      }
      i++;
    } while (field != null);
    println("End in error");
    exit();
  }
}
catch (IOException e)
{
  println("Error in I/O " + e);
  exit();
}

println("Correct data:");
InputStream input = null;
try
{
  connection = (HttpURLConnection) url.openConnection();
  connection.setRequestMethod("GET");
  input = connection.getInputStream();
  String[] lines = loadStrings(input);
  println(lines);
}
catch (IOException e)
{
  println("Error " + e);
}
finally
{
  if (input != null)
  {
    try { input.close(); } catch (IOException e) {}
  }
}

exit();

