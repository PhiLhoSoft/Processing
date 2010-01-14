import netscape.javascript.*;

final static int MIN_RAD = 10;
final static int MAX_RAD = 300;
int radius = MIN_RAD;
int centerX, centerY;

void setup()
{
  size(400, 400);
  centerX = width/2;
  centerY = height/2;
}

void draw()
{
  background(#2288EE);
  radius = (radius - MIN_RAD + 1) % MAX_RAD + MIN_RAD;
  ellipse(centerX, centerY, radius * 2, radius * 2);
}

void mouseClicked()
{
  if (dist(mouseX, mouseY, centerX, centerY) < radius)
  {
    URL url = getDocumentBase();
    if (url == null) return;  // Not an applet
//    System.err.println(url);
    try {
      URL anchor = new URL(url, "#2.5");
      println(anchor);
      getAppletContext().showDocument(anchor);
    } catch (MalformedURLException e) {}
  }
  else
  {
    JSObject win = (JSObject) JSObject.getWindow(this);  
    String[] arguments = { "2.5" };  
    println(arguments[0]);
    win.call("JumpToAnchor", arguments);  
  }
}

