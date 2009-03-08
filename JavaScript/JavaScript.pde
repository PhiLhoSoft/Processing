//~ import netscape.javascript.*;
//~ import java.applet.*;
//~ import java.awt.*;

JSObject window = JSObject.getWindow(this);
JSObject document = (JSObject) win.getMember("document");

void setup()
{
  window = JSObject.getWindow(this);
  document = (JSObject) window.getMember("document");

  JSObject loc = (JSObject) document.getMember("location");

  String s = (String) loc.getMember("href");  // document.location.href
  win.call("f", null);		  	     // Call f() in HTML page
}
