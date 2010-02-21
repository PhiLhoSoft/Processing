/*
 * A tutorial on JBox2D, using BoxWrap2D for Processing.
 * http://processing.org/discourse/yabb2/YaBB.pl?num=1247034244
 * Part n: Contacts
 */
/* File history:
 *  1.00.000 -- 2010/10/19 (PL) -- Making it handling contacts...
 *  0.00.000 -- 2009/09/26 (PL) -- Creation
 */
/*
Author: Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr
Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2009 Philippe Lhoste / PhiLhoSoft
*/

import processing.opengl.*;

// Import everything exposed by JBox2D
import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;
// BoxWrap2D
import org.jbox2d.p5.*;

// A reference to the physics engine
Physics physics;
// Reference to the world as we need it for more advanced stuff...
World world;
// We observe a particular object
Body circle;
boolean bShown; long timeStart;

void setup()
{
  // Medium sized scene - using OpenGL because other modes are really too slow
  size(640, 480, OPENGL);
  // Physics is computed 60 times per second, so let's draw at same rate
  frameRate(60);
  // Nicer graphics
  smooth();

  PFont f = loadFont("Verdana-12.vlw");
  textFont(f);

  // Set up everything physics
  InitScene();
  // And add object to the scene
  CreateObjects();
}

void draw()
{
  // Not much to do here, most drawing is handled by BoxWrap2D
  background(255);
  if (circle.isSleeping() && !bShown)
  {
    println(millis() - timeStart + " " + frameCount);
    bShown = true;
  }
}

void mousePressed()
{
  // Do something interactive, like creating new objects
  float r = physics.getRestitution();
  physics.setRestitution(0.9); // Make them super-rebunding
  Body randomBody = physics.createCircle(mouseX, mouseY, random(5.0, 15.0));
  Vec2 vel = new Vec2(random(-30.0, 30.0), random(-30.0, 30.0));
  randomBody.setLinearVelocity(vel);
  physics.setRestitution(r); // Restore
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
  world = physics.getWorld();

  // Add fixed obstacles, of density 0.0
  physics.createCircle(width / 5, height / 5, 10.0);
  physics.createCircle(4 * width / 5, height / 5, 10.0);
  physics.createCircle(width / 5, 4 * height / 5, 10.0);
  physics.createCircle(4 * width / 5, 4 * height / 5, 10.0);
  // And set the density for the other objects
  physics.setDensity(1.0);

  // Add contact listener
  world.setContactListener(new HitHandler());
}

void CreateObjects()
{
  // Middle of the world
  float hw = width / 2.0;
  float hh = height / 2.0;

  // A round object in the middle of the scene (center coordinates, radius)
  circle = physics.createCircle(hw, hh, 50.0);
  // Make it rotating (value in radian/second)
//~   circle.setAngularVelocity(3.0);
//~   Vec2 vc = new Vec2(-30.0, 0.0); // To the left
//~   circle.setLinearVelocity(vc);
/*
  // And two rectangles not far (coordinates of top-left, and bottom-right corners)
  Body rect1 = physics.createRect(
      hw - 150, hh - 50,
      hw - 75, hh + 50
  );
  // Small vector: slow
  Vec2 v1 = new Vec2(-10.0, 0.0); // To the left
  rect1.setLinearVelocity(v1);

  Body rect2 = physics.createRect(
      hw + 75, hh - 40,
      hw + 175, hh + 40
  );
  // Bigger: fast
  Vec2 v2 = new Vec2(20.0, 50.0); // Toward top-right
  rect2.setLinearVelocity(v2);

  // A polygon, defined by a list of vertices
  Body triangle = physics.createPolygon(
      hw + 150, hh - 100,
      hw, hh - 150,
      hw - 150, hh - 100
  );
  Vec2 v3 = new Vec2(5.0, 30.0); // Go a little high
  triangle.setLinearVelocity(v3);
*/
  timeStart = millis(); bShown = false;
}

public class HitHandler implements ContactListener
{
  HitHandler()
  {
  }

  /**
   * Called when a contact point is added, ie. when colliding.
   * This includes the geometry and the forces.
   */
  public void add(ContactPoint cp)
  {
    println("Ouch!");
    DumpContactPoint(cp);
  }

  /**
   * Called when a contact point persists, ie. contact is maintained.
   * This includes the geometry and the forces.
   */
  public void persist(ContactPoint cp)
  {
    println("Sticky, eh?");
    DumpContactPoint(cp);
  }

  /**
   * Called when a contact point is removed, ie. contact is broken.
   * This includes the last computed geometry and forces.
   */
  public void remove(ContactPoint cp)
  {
    println("Good riddance!");
    DumpContactPoint(cp);
  }

  /**
   *
   */
  public void result(ContactResult cr)
  {
    DumpContactResult(cr);
  }
}

void DumpContactResult(ContactResult cr)
{
  println("ContactResult: " + cr + " (" + cr.id.features.incidentEdge + ")");
  println("- Shapes: " + cr.shape1 + ", " + cr.shape2);
  println("- Position: " + cr.position);
  println("- Normal: " + cr.normal + " -> " + cr.normalImpulse + " / " + cr.tangentImpulse);
}

void DumpContactPoint(ContactPoint cp)
{
  println("ContactPoint: " + cp + " (" + cp.id.features.incidentEdge + ")");
  println("- Shapes: " + cp.shape1 + ", " + cp.shape2);
  println("- Position: " + cp.position);
  println("- Velocity: " + cp.velocity);
  println("- Normal: " + cp.normal);
  println("- Separation: " + cp.separation);
  println("- Friction / Restitution: " + cp.friction + " / " + cp.restitution);
}

void ShowInformation()
{
  // Show position of circle
  Vec2 posW = circle.getPosition();
  Vec2 posS = physics.worldToScreen(posW);
  String position = String.format("Pos: %.2f, %.2f", posS.x, posS.y);
  fill(#208020);
  text(position, 10, 20);
}

