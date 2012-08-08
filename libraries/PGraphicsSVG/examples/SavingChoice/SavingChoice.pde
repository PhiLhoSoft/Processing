import org.philhosoft.processing.svg.PGraphicsSVG;

/*
Allow the user to choose to save a particular frame of an animation.
*/

float level = 0.1;
PGraphicsSVG svg;

void setup()
{
  size(500, 500);
  smooth();
  frameRate(10);

  svg = (PGraphicsSVG) createGraphics(width, height,
      "org.philhosoft.processing.svg.PGraphicsSVG", "SineOnBezier.svg");
  beginRecord(svg);

  println("Use r to record the current frame.\nUse q to end and quit the sketch.");
}

void draw()
{
  // Call background() only for the visual part, not on the SVG renderer,
  // otherwise it will accumulate them
  g.background(255);
  
  svg.discard(); // Discard previous frame
  svg.beginDraw(); // And record this one

  noFill();
  stroke(0);
  int curveLength = 400;
  int curveHeight = 100;
  bezier(15, 120, 210, 90, 290, 420, 415, 380);

  stroke(#FF0000);
  int steps = 50;
  for (int i = 0; i < steps; i++)
  {
    float t = i / float(steps);
    float x = bezierPoint(15, 210, 290, 415, t);
    float y = bezierPoint(120, 90, 420, 380, t);

    float v = curveHeight * sin(t * TWO_PI * level);
    line(x, y, x, y + v);
  }
  
  fill(0);
  text("L: " + level, width - 100, 30);
  
  level += 0.1;
}

void keyPressed()
{
  if (key == 'r') // Record
  {
    svg.save();
    println("Recorded.");
  }
  else if (key == 'q')
  {
    svg.discard();
    exit();
  }
}

