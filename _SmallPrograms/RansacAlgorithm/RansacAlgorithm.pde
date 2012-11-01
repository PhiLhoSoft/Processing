/**
https://forum.processing.org/topic/ransac-algorithm

RANSAC algorithm, see Wikipedia: http://en.wikipedia.org/wiki/RANSAC
This implementation was helped by the JavaScript implementation at
http://www.visual-experiments.com/demo/ransac.js/
Took ideas and formulae...

- Left click add a point to those already generated;
- Right click launches the algorithm;
- + increase the speed;
- - decreases it;
- * adds 5 iterations after the algorithm has ended (more tries);
- / enters the user mode: the user can click on two points to see if the lines between them has a better score. If so, the best score is updated. User can choose another pair for another try.
- c clears the current set of points and start over.

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.01.000 -- 2012/10/30 (PL) -- Final touch, with adding more iterations, user mode, etc.
 1.00.000 -- 2012/10/24 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2012 Philippe Lhoste / PhiLhoSoft
*/

final int LINE_HEIGHT = 15;
int textPos;
final int NB_OF_POINTS = 50;
int stepTime = 2000; // Nb of milliseconds per step
int lastTime;
float threshold = 15.0;

Ransac ransac;
Drawer drawer = new Drawer();
ArrayList<Point> points = new ArrayList<Point>();
List<Point> userSample;

void setup()
{
  size(800, 800);
  smooth();

  initPoints();
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
    if (ransac != null && !ransac.isFinished() ||
        userSample != null && userSample.size() == 2)
    {
      List<Point> sample = ransac.getSample();
      List<Point> inliers = ransac.getInliers();
      if (sample.contains(p))
      {
        ptColor = #FFAA88;
      }
      else if (inliers.contains(p))
      {
        ptColor = #EECCFF;
      }
    }
    if (userSample != null && userSample.contains(p))
    {
      ptColor = #FFCCEE;
    }
    drawer.drawPoint(p, ptColor);
  }

  if (ransac != null)
  {
    Line line = ransac.getBestModel();
    drawer.drawLine(line, #EE88CC);
    if (!ransac.isFinished() || userSample != null && userSample.size() == 2)
    {
      line = ransac.getCurrentModel();
      drawer.drawLine(line, #DDAADD);
    }
  }

  fill(#225577);
  textPos = 20;
  show("Point nb: " + points.size());
  if (ransac != null)
  {
    if (ransac.isFinished())
    {
      show("Step: End");
    }
    else
    {
      text("Speed: " + nf(1000.0 / stepTime, 1, 2), 150, textPos);
      show("Step: " + ransac.getCurrentIterationNb() + " / " + ransac.getIterationNb());
    }
    show("Score: " + nf(ransac.getCurrentScore(), 1, 2) + " / " + nf(ransac.getBestScore(), 1, 2));
    if (userSample != null)
    {
      show("User sample mode");
    }
  }
}

void show(String msg)
{
  text(msg, 10, textPos);
  textPos += LINE_HEIGHT;
}

void mousePressed()
{
  if (mouseButton == LEFT) // Add another point
  {
    if (userSample == null)
    {
      // Before running, just add a new point
      points.add(new Point(mouseX, mouseY));
    }
    else
    {
      if (userSample.size() == 2)
      {
        userSample.clear(); // New sample
      }
      // The user wants to test one line
      for (Point p : points)
      {
        if (p.dist(mouseX, mouseY) < threshold / 2)
        {
          userSample.add(p);
          println(p);
          break;
        }
      }
      if (userSample.size() == 2)
      {
        // Test the user sample
        ransac.checkSample(userSample);
      }
    }
  }
  else if (mouseButton == RIGHT) // Start the demo / computing
  {
    println(points.size());
    ransac = new Ransac(new SimpleFitting(), points, threshold);
    ransac.computeNextStep();
    lastTime = millis() + stepTime + 1;
  }
}

void keyPressed()
{
  if (key == 'c') // Clear
  {
    ransac = null;
    userSample = null;
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
  if (ransac != null && ransac.isFinished())
  {
    if (key == '/') // Test user sample
    {
      userSample = new ArrayList<Point>();
    }
    else if (key == '*') // Try more
    {
      userSample = null;
      ransac.tryMore(5);
    }
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

