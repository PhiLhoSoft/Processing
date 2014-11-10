import processing.net.*;
import javax.xml.bind.DatatypeConverter;

String encodedAuth = DatatypeConverter.printBase64Binary("ruben_vleuten@hotmail.com:RghFLhdU_ot9g8tcVvlnjJa_zcToVTM0H1iHB-XchgprrgrZk3SJhA".getBytes());
Client client;
int step = 0;

void setup()
{
  size(200, 200);
  frameRate(1);
  step = 1;
  println(encodedAuth);
}

void draw()
{
  if (step > 0)
  {
    println("------ " + step);
    client = new Client(this, "webservices.ns.nl", 80);
  }
  switch (step)
  {
  case 1:
    client.write("GET /ns-api-treinplanner?fromStation=Utrecht+Centraal&toStation=Wierden&departure=true HTTP/1.1\r\n");
    client.write("Host: webservices.ns.nl\r\n");
    client.write("Authorization: Basic " + encodedAuth);
    client.write("Accept: application/xml\r\n");
    client.write("Accept-Charset: utf-8;q=0.7,*;q=0.7\r\n");
    client.write("\r\n");
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

