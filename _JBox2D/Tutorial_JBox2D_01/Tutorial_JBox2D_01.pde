/*
 * A tutorial on JBox2D, using BoxWrap2D for Processing.
 * http://processing.org/discourse/yabb2/YaBB.pl?num=1247034244
 * Part 1: simple objects
 */
/* File history:
 *  1.00.000 -- 2009/07/08 (PL) -- Creation
 */
/*
Author: Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr
Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2009 Philippe Lhoste / PhiLhoSoft
*/

//~ import org.jbox2d.testbed.tests.*;
//~ import org.jbox2d.testbed.*;
//~ import org.jbox2d.testbed.timingTests.*;
// Import everything exposed by JBox2D (except the testbed stuff)
import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;
// BoxWrap2D
import org.jbox2d.p5.*;

// A reference to the physics engine
Physics physics;

void setup()
{
  // Medium sized scene
  size(640, 480);
  // Physics is computed 60 times per second, so let's draw at same rate
  frameRate(60);
  // Nicer graphisc
  smooth();

  // Set up everything physics
  InitScene();
  // And add object to the scene
  CreateObjects();
}

void draw()
{
  // Not much to do here, most drawing is handled by BoxWrap2D
  background(255);
}

void keyPressed()
{
  // Can be used to reset the sketch, for example
  physics.destroy();
  physics = null;
  InitScene();
  CreateObjects();
}

void InitScene()
{
  // Set up the engine with the sketch's dimensions
  physics = new Physics(this, width, height);
  physics.setDensity(1.0);
}

void CreateObjects()
{
  // Middle of the world
  float hw = width / 2.0;
  float hh = height / 2.0;

  // A round object in the middle of the scene (center coordinates, radius)
  physics.createCircle(hw, hh, 50.0);
  // And two rectangles not far (coordinates of top-left, and bottom-right corners)
  physics.createRect(
      hw - 150, hh - 50,
      hw - 75, hh + 50
  );
  physics.createRect(
      hw + 75, hh - 40,
      hw + 175, hh + 40
  );
  // A polygon, defined by a list of vertices
  physics.createPolygon(
      hw + 150, hh - 100,
      hw, hh - 150,
      hw - 150, hh - 100
  );
}
