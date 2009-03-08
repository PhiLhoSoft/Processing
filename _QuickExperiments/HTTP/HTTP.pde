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
    client = new Client(this, "www.processing.org", 80);
  }
  switch (step)
  {
  case 1:
    // 400 Bad Request (no Host)
    client.write("HEAD / HTTP/1.1\r\n\r\n");
    break;
  case 2:
    // 404 Not Found
    client.write("HEAD /index.html HTTP/1.1\r\n");
    client.write("Host: processing.org\r\n\r\n");
    break;
  case 3:
    // 200 OK
    client.write("HEAD / HTTP/1.1\r\n");
    client.write("Host: processing.org\r\n\r\n");
    break;
  case 4:
    // 200 OK (with content)
    client.write("HEAD /discourse/index.html HTTP/1.1\r\n");
    client.write("Host: processing.org\r\n\r\n");
    break;
  case 5:
    // 200 OK (PHP answer)
    client.write("HEAD /discourse/yabb_beta/YaBB.cgi HTTP/1.1\r\n");
    client.write("Host: processing.org\r\n\r\n");
    break;
  case 6:
    // 301 Moved
    client.write("HEAD /source/index.cgi HTTP/1.1\r\n");
    client.write("Host: dev.processing.org\r\n\r\n");
    break;
  case 7:
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

