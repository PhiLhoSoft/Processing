// RANSAC algorithm, see Wikipedia: http://en.wikipedia.org/wiki/RANSAC
// This implementation was helped by the JavaScript implementation at
// http://www.visual-experiments.com/demo/ransac.js/
// Took ideas and formulae...

final int NB_OF_POINTS = 50;
int stepTime = 2000; // Nb of milliseconds per step
int lastTime;
int stepCounter;

Ransac ransac;
Drawer drawer = new Drawer();
ArrayList<Point> points = new ArrayList<Point>();

// Test
boolean bTestLines;
Line line01, line02;
Line line1;
Line line2;

void setup()
{
  size(800, 800);
  smooth();

  initPoints();

  // Test
  if (bTestLines)
  {
    Point p1 = new Point(10, height / 2);
    Point p2 = new Point(width - 10, height / 2);
    Point p3 = new Point(width / 2, 10);
    Point p4 = new Point(width / 2, height - 10);
    points.add(p1);
    points.add(p2);
    points.add(p3);
    points.add(p4);
    line01 = new Line(1, 0);
    line02 = new Line(-1, height);
    line1 = new Line(p1, p2);
    line2 = new Line(p3, p4);
  }
}

void draw()
{
  if (ransac != null) // Algorithm in progress
  {
    if (ransac.isFinished())
    {
      background(255);
//~       println("Done");
    }
    else
    {
      background(240);
      if (millis() - lastTime > stepTime)
      {
        ransac.computeNextStep();  
        stepCounter++;
//      println("Next step " + ransac);
//      println(ransac.getSample());
        lastTime = millis();
      }
    }
  }
  else
  {
    background(240);
  }

  for (Point p : points)
  {
    color ptColor = #88AAFF;
    if (ransac != null)
    {
      List<Point> sample = ransac.getSample();
      List<Point> inliers = ransac.getInliers();
//      println(inliers);
      if (sample.contains(p))
      {
        ptColor = #FFAA88;
      }
      else if (inliers.contains(p))
      {
        ptColor = #EECCFF;
      }
    }
    drawer.drawPoint(p, ptColor);
  }
  if (bTestLines)
  {
    drawer.drawLine(line01, #FFAA88);
    drawer.drawLine(line02, #FFAA88);
    drawer.drawLine(line1, #FFAA88);
    drawer.drawLine(line2, #FFAA88);
    noLoop();
  }

  if (ransac != null)
  {
    Line line = ransac.getBestModel();
    drawer.drawLine(line, #EE88CC);
    if (!ransac.isFinished())
    {
      line = ransac.getCurrentModel();
      drawer.drawLine(line, #DDAADD);
    }

    fill(#225577);
    text("Step: " + stepCounter + " / " + ransac.getIterationNb(), 10, 20);
    text("Score: " + nf(ransac.getCurrentScore(), 1, 2) + " / " + nf(ransac.getBestScore(), 1, 2), 10, 35);
  }
}

void mousePressed()
{
  if (mouseButton == LEFT)
  {
    points.add(new Point(mouseX, mouseY));
  }
  else if (mouseButton == RIGHT)
  {
    println(points.size());
    ransac = new Ransac(new SimpleFitting(), points, 15.0);
    ransac.computeNextStep();
    stepCounter++;
    lastTime = millis() + stepTime + 1;
  }
}

void keyPressed()
{
  if (key == 'c') // Clear
  {
    stepCounter = 0;
    ransac = null;
    points.clear();
    initPoints();
  }
  else if (key == '+') // Accelerate
  {
    stepTime /= 1.25;
  }
  else if (key == '-') // Slow down
  {
    stepTime *= 1.25;
  }
}

/** Creates a number of uniformously distributed points, as base / noise. */
void initPoints()
{
  for (int i = 0; i < NB_OF_POINTS; i++)
  {
    points.add(drawer.makePoint());
  }
}

