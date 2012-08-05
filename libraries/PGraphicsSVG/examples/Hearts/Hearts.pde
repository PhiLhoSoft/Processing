import org.philhosoft.processing.svg.PGraphicsSVG;

Heart h1, h2, h3;

void setup()
{
  size(400, 400, "org.philhosoft.processing.svg.PGraphicsSVG", "Hearts.svg");
  smooth();
  noLoop();	// No animation
  background(#88AAFF);

  h1 = new Heart(70f, 150f, 50f, 2.0, 1.0, 1.0, 0.0, 2, #FF0000, #FFA0A0);
  h2 = new Heart(200f, 50f, 50f, 1.2, 0.8, 0.5, 60.0, 8, #550000, #882020);
  h3 = new Heart(250f, 220f, 100f, #800000, #AA5555);
}

void draw()
{
  h1.draw();
  h2.draw();
  h3.draw();
}
