// Parse a Gzipped XML response from a GET request
// https://forum.processing.org/topic/xml-retrieval

import processing.net.*;
 
Client client;
// To handle a dialog (several chained requests) with a server.
// Not really used here, except to better handle responses.
int step = 0;
 
void setup()
{
  size(200, 200);
  frameRate(5);
  step = 1;
}
 
void draw()
{
  if (step > 0)
  {
    println("------ " + step);
  }
  switch (step)
  {
  case 1:
    client = new Client(this, "www.teamliquid.net", 80);
    client.write("GET /video/streams/?xml=1&filter=live HTTP/1.1\r\n");
    client.write("Host: www.teamliquid.net\r\n");
//    client.write("User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.7) Gecko/2009021906 Firefox/3.0.7\r\n");
    client.write("Accept: text/html,application/xhtml+xml,application/xml\r\n");
    client.write("Accept-Language: en-us,en;q=0.5\r\n");
    client.write("Accept-Encoding: gzip\r\n");
    client.write("Accept-Charset: utf-8;q=0.7,*;q=0.7\r\n");
//    client.write("Keep-Alive: 300\r\n");
//    client.write("Connection: keep-alive\r\n\r\n");
    client.write("\r\n");
    break;
  case 2:
    exit();
  }
  
  if (step > 0)
  {
    step = -++step; // Next step, and negative to stop treatment until an answer is received
  }
  
  if (step < 0 && client.available() > 0)
  {
    byte[] dataIn = client.readBytes();
    String textData = new String(dataIn);
    if (textData.contains("text/plain"))
    {
      println(textData); // Likely to be an error message (eg. if omitting to accept gzip data)
    }
    else
    {
      byte[] gzipData = null;
      // Scan the response
      for (int i = 0; i < dataIn.length - 3; i++)
      {
 //       print(hex(dataIn[i]) + " ");
        // Search for a double end-of-line (CRLF) sequence: end of header, start of data
        if (dataIn[i] == 0x0D && dataIn[i + 1] == 0x0A && 
            dataIn[i + 2] == 0x0D && dataIn[i + 3] == 0x0A)
        {
          i += 4; // No check on bounds, don't do that in production code! :-)
          println("Found start of data at " + i);
          int len = 0;
          // Data starts with the size of the Gzipped XML blob in a single line (hence the 0D test) in hexa format
          while (dataIn[i] != 0x0D)
          {
//            println(i + " " + hex(dataIn[i]));
            // Compute the length
            len = len * 16 + (dataIn[i] > 57 ? dataIn[i] - 87 : dataIn[i] - 48);
//            println("-> " + hex(len));
            i++;
          }
          println("Length: " + len + " (" + hex(len) + ")");
          i += 2;
          // Copy the binary data
          gzipData = new byte[len];
          arrayCopy(dataIn, i, gzipData, 0, len);
          break;
        }
      } 
      //*
      if (gzipData != null)
      {
        try
        {
          // Unzip the data and parse it
          XML xml = new XML(new java.util.zip.GZIPInputStream(new java.io.ByteArrayInputStream(gzipData)));
          println(xml);
        }
        catch (Exception e)
        {
          e.printStackTrace();
        }
      }
      else
      {
        println("Gzip data not found!");
        println(textData);
      }
      //*/
    }
//  println(dataIn);
    step = -step;
  }
}

