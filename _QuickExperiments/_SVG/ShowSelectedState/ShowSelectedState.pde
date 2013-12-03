// Based on code at http://forum.processing.org/one/topic/need-help-with-mouse-over-text-box-display-on-us-map.html

PShape usa;
int stateCount;
PGraphics map; // Map clicks to states
int selectedState = -1;

final float SCALE_FACTOR = 0.8; 

void setup() 
{
  size(950, 600);
  smooth();
  
  // The file Blank_US_Map.svg can be found at Wikimedia Commons
  // ("http://upload.wikimedia.org/wikipedia/commons/3/32/Blank_US_Map.svg");
  usa = loadShape("Blank_US_Map.svg");
  stateCount = usa.getChildCount();
  
  makeHiddenMap();
}

void draw() 
{
  background(255);
  stroke(255);
  // Draw the full map
  pushMatrix();
  scale(SCALE_FACTOR);
  shape(usa, 0, 0);

  if (selectedState >= 0)
  {
    drawSelectedState();
    popMatrix();
  }
  else
  {
    // test: show hidden map
    popMatrix(); // Already scaled, unscale
    image(map, 0, 0);
  }
}

void makeHiddenMap()
{
  map = createGraphics(width, height);
  map.beginDraw();
  map.scale(SCALE_FACTOR);
  map.noStroke();
  map.background(255);
  for (int i = 0; i < stateCount; i++) 
  {
    PShape state = usa.getChild(i);
    // Disable the colors found in the SVG file
    state.disableStyle();
    // Set our own coloring
    map.fill(i, 0, 0);
    // Draw a single state  
    map.shape(state, 0, 0);
  }
  map.endDraw();
}

void drawSelectedState() 
{
  PShape state = usa.getChild(selectedState);
  // Disable the colors found in the SVG file
  state.disableStyle();
  // Set our own coloring
  fill(#5577FF);
  // noStroke();
  // Draw a single state
  shape(state, 0, 0);
}

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    String stateName = "<none>";
    color c = map.get(mouseX, mouseY);
    selectedState = int(red(c));
    if (selectedState >= stateCount) // White background or unmapped color (anti-aliasing!)
    {
      selectedState = -1;
    }
    else
    {
      PShape state = usa.getChild(selectedState);
      stateName = state.getName();
    }
    println("Selected: " + selectedState + " - " + stateName);
  }
  else
  {
    selectedState = -1;
  }
}

