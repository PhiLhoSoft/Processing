String emptyString = "", longString="is that a bug? Because it's really annoying";
PFont font;
boolean switching;

void setup()
{
  size(560, 560);
  font = loadFont("AmericanTypewriter-24.vlw");
  textFont(font);
}

void draw()
{
  background(230);
  fill(0);

  if (!switching)
  {
    stroke(#FF0000);
    text(longString, 100, 100, 200, 100);
  }
  else
  {
    stroke(#0000FF);
    text(emptyString, 100, 100, 200, 100);
  }
  rect(100, 100, 200, 100);
}

void mouseReleased()
{
  switching = !switching;
}
