/*
 * A tutorial on JBox2D, using BoxWrap2D for Processing.
 * http://processing.org/discourse/yabb2/YaBB.pl?num=1247034244
 * Part 3: compound shapes and impulsions
 */
/* File history:
 *  1.00.000 -- 2009/07/09 (PL) -- Creation
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
// Latest touched object
Body movedBody;

// Code of interaction to apply
char interactionKind = 'T';
// Information on interaction
String information = "";

void setup()
{
  // Medium sized scene
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
  // Show position of latest touched object
  if (movedBody != null)
  {
    Vec2 posW = movedBody.getPosition();
    Vec2 posS = physics.worldToScreen(posW);
    String position = String.format("Pos: %.2f, %.2f - %s", posS.x, posS.y, information);
    text(position, 10, 20);
  }
  if (pressMouseX >= 0)
  {
    stroke(#FF8800);
    line(pressMouseX, pressMouseY, mouseX, mouseY);
  }
}

float pressMouseX = -1, pressMouseY = -1;
void mousePressed()
{
  pressMouseX = mouseX;
  pressMouseY = mouseY;
}

void mouseReleased()
{
  movedBody = GetBodyAtPoint(mouseX, mouseY);
  if (movedBody != null)
  {
    // We apply force or impulse where we click
    Vec2 point = new Vec2(mouseX, mouseY);
    float mass = movedBody.m_mass;
    float dX = mouseX - pressMouseX;
    float dY = mouseY - pressMouseY;
    switch (interactionKind)
    {
    case 'T':
      float torque = (dX * dX + dY * dY) * (dX < 0 ? 1 : -1);
      information = String.format("Torque: %.0f * %.1f", torque, mass);
      movedBody.applyTorque(torque * mass);
      break;
    case 'F':
      Vec2 force = new Vec2(dX / 10, dY / 10);
      information = String.format("Force: %s * %.1f", force, mass);
      movedBody.applyForce(force.mul(mass), point);
      break;
    case 'I':
      Vec2 impulse = new Vec2(dX / 100, dY / 100);
      information = String.format("Impulse: %s * %.1f", impulse, mass);
      movedBody.applyImpulse(impulse.mul(mass), point);
      break;
    }
  }
  pressMouseX = pressMouseY = -1;
}

void keyPressed()
{
  switch (key)
  {
  case 'r':
  case 'R':
    // Reset the sketch
    physics.destroy();
    physics = null;
    InitScene();
    CreateObjects();
    break;
  case 't':
  case 'T':
    interactionKind = 'T';
    break;
  case 'f':
  case 'F':
    interactionKind = 'F';
    break;
  case 'i':
  case 'I':
    interactionKind = 'I';
    break;
  default: // Ignore...
  }
}

void InitScene()
{
  // Set up the engine with the sketch's dimensions
  physics = new Physics(this, width, height);
  world = physics.getWorld();
  // Add some fixed obstacles, of density 0.0
  for (int ic = 0, margin = 50; ic < 10; ic++)
  {
    physics.createCircle(
        random(margin, width - margin),
        random(margin, height - margin), 10.0);
  }
  // And set the density for the other objects
  physics.setDensity(1.0);
}

void CreateObjects()
{
  // Middle of the world
  float hw = width / 2.0;
  float hh = height / 2.0;

  physics.createCircle(hw, hh, 50.0);
  physics.createRect(hw - 150, hh - 50, hw - 75, hh + 50);
  physics.createRect(hw + 75, hh - 40, hw + 175, hh + 40);
  physics.createPolygon(
      hw + 120, hh - 80,
      hw + 150, hh - 100,
      hw, hh - 150,
      hw - 150, hh - 100,
      hw - 120, hh - 80
  );
  // Some smaller, more rebunding objects
  physics.setRestitution(0.9);
  physics.createCircle(hw - 75, hh - 75, 20.0);
  physics.createRect(50, 50, 100, 100);
  physics.setRestitution(0.7);
  physics.createCircle(hw + 75, hh + 75, 20.0);
  physics.createRect(width - 50, 50, width - 100, 100);
}

// Idea taken from source seen at The Stem > Box2D Joints #2 - Revolute Joints <http://blog.thestem.ca/archives/102>
Body GetBodyAtPoint(float x, float y)
{
  // Create a small box at mouse point
  Vec2 v = physics.screenToWorld(x, y);
  AABB aabb = new AABB(new Vec2(v.x - 0.001, v.y - 0.001), new Vec2(v.x + 0.001, v.y + 0.001));
  // Look at the shapes intersecting this box (max.: 10)
  org.jbox2d.collision.Shape[] shapes = world.query(aabb, 10);
  if (shapes == null)
    return null;  // No body there...
  for (int is = 0; is < shapes.length; is++)
  {
    org.jbox2d.collision.Shape s = shapes[is];
    if (!s.m_body.isStatic())  // Don't pick static shapes
    {
      // Ensure it is really at this point
      if (s.testPoint(s.m_body.getXForm(), v))
        return s.m_body; // Return the first body found
    }
  }
  return null;
}
