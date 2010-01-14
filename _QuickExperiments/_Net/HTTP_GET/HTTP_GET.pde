import processing.net.*;

Client client;
int step = 0;

void setup()
{
  size(200, 200);
  frameRate(1);
  step = 1;
}

void draw()
{
  if (step > 0)
  {
    println("------ " + step);
    client = new Client(this, "www.geoplugin.net", 80);
  }
  switch (step)
  {
  case 1:
    client.write("GET /xml.gp?ip=12.215.42.19 HTTP/1.1\r\n");
    client.write("Host: www.geoplugin.net\r\n");
    client.write("User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.7) Gecko/2009021906 Firefox/3.0.7\r\n");
    client.write("Accept: text/html,application/xhtml+xml,application/xml\r\n");
    client.write("Accept-Language: en-us,en;q=0.5\r\n");
    client.write("Accept-Encoding: gzip,deflate\r\n");
    client.write("Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7\r\n");
    client.write("Keep-Alive: 300\r\n");
    client.write("Connection: keep-alive\r\n\r\n");
    break;
  case 2:
    exit();
  }
  if (step > 0)
  {
    step = -++step;
  }
  if (client.available() > 0)
  {
    String dataIn = client.readString();
    println(dataIn);
    step = -step;
  }
}

