import org.philhosoft.processing.svg.PGraphicsSVG;

/*
Simple test, exercing Bézier curves and simple geometry
(fill, stroke...).
*/

Heart h1, h2, h3;

void setup()
{
  // Renders only on the SVG surface, no display
  size(400, 400, PGraphicsSVG.SVG, "Hearts.svg");
  smooth();
  background(#88AAFF);

  h1 = new Heart(70f, 150f, 50f, 2.0, 1.0, 1.0, 0.0, 2, #FF0000, #FFA0A0);
  h2 = new Heart(200f, 50f, 50f, 1.2, 0.8, 0.5, 60.0, 8, #550000, #882020);
  h3 = new Heart(250f, 220f, 100f, #800000, #AA5555);
}

void draw()
{
  fill(#EEEEAA);
  stroke(#FFFFCC);
  strokeWeight(20);
  ellipse(width / 2, height / 2, width * 0.75, height * 0.75);

  h1.draw();
  h2.draw();
  h3.draw();

  println("Done");
  // Mandatory, so that proper cleanup is called, saving the file
  exit();
}
