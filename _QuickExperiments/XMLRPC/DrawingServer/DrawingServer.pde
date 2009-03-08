import xmlrpclib.*;

XmlrpcServer server;

int port = 8081;

int x = 100;
int y = 100;
int c = 0;

void setup()
{
  size(400, 400);
  background(72);
  noStroke();
  rectMode(CORNER);

  // Initialize the server
  server = new XmlrpcServer(port);

  // Add a handler and an Object.
  // By adding "this" you open all the public methods in this applet
  // You can also add any other Object
  // All the public methods of the Object will be available through XML-RPC
  server.add("testserver", this);

  // Note that /RPC2 is hard-coded to URI in the Apache Library.
  // For example, you can invoke this server at http://18.83.20.106:8081/RPC2
  println("Server started at " + server.ip()+":"+port+"/RPC2");
}

void draw()
{
  fill(c);
  rect(x, y, 10, 10);
}

// This method can be remotely called from another program
public Vector update(int x, int y)
{
  this.x += x;
  this.y += y;
  if (c < 255)
  {
    c += 10;
  }
  else
  {
    c = 10;
  }
  // Let the Client know that we are done
  // We must always respond to the Client
  Vector vv = new Vector();
  Vector v1 = new Vector();
  Vector v2 = new Vector();
  v1.add(x); v1.add(y);
  v2.add(this.x); v2.add(this.y);
  vv.add(v1); vv.add(v2);
  return vv;
}

