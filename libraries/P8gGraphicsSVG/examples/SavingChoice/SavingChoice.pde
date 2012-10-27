import org.philhosoft.processing.svg.PGraphicsSVG;

/*
Allows the user to choose to save a particular frame of an animation.
*/

float level = 0.1;
PGraphicsSVG svg;

void setup()
{
  size(500, 500);
  smooth();
  frameRate(10);

  svg = (PGraphicsSVG) createGraphics(width, height, PGraphicsSVG.SVG, "SineOnBezier.svg");
  beginRecord(svg);

  println("Use s to save the current frame,\nr to save the current frame in a numbered file.\nUse q to end the sketch.");
}

void draw()
{
  // Call background() only for the visual part, not on the SVG renderer,
  // otherwise it will accumulate them
  g.background(255);

  svg.clear(); // Discard previous frame
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
  if (key == 's') // Save the current image (and overwrite the previous one)
  {
    svg.save();
    println("Saved.");
  }
  else if (key == 'r') // Record the current image to a new numbered file
  {
    svg.saveFrame("SineOnBezier-###.svg");
    println("Saved #" + svg.savedFrameCount);
  }
  else if (key == 'q')
  {
    // Don't overwrite the last saved frame!
    svg.clear();
    exit();
  }
}
