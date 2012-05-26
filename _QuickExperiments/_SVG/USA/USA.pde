PGraphics buffer;
PShape usa;

void setup() 
{
  size(1000, 650);
  buffer = createGraphics(width, height, JAVA2D);
  usa = loadShape("H:/PhiLhoSoft/Processing/ImprovingSVG/data/usa-wikipedia.svg");
  
  buffer.beginDraw();
  buffer.smooth();
  buffer.background(255);
  buffer.shape(usa, -250, -150);
  int count = 0;
  for (PShape state : usa.getChildren())
  {
    state.disableStyle();
    buffer.fill(count * 5, count * 5, 150);
    buffer.shape(state, -250, -150);
    count++;
  }
  buffer.endDraw();
  
  image(buffer, 0, 0);
}

