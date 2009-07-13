/*
 * A tutorial on JBox2D, using BoxWrap2D for Processing.
 * http://processing.org/discourse/yabb2/YaBB.pl?num=1247034244
 * Part 4: using joints
 */
/* File history:
 *  1.00.000 -- 2009/07/12 (PL) -- Creation
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

// Information on interaction
String information = "";
float HW;
float HH;

void setup()
{
  // Medium sized scene
  size(640, 480);
  // Middle of the world
  HW = width / 2.0;
  HH = height / 2.0;

  // Physics is computed 60 times per second, so let's draw at same rate
  frameRate(60);
  // Nicer graphics
  smooth();

  PFont f = loadFont("Verdana-12.vlw");
  textFont(f);

  // Set up everything physics
  InitScene();
  // And add object to the scene
  CreateDistanceObjects();
}

void draw()
{
  background(255);
  // Show position of latest touched object
  if (movedBody != null)
  {
    Vec2 posW = movedBody.getPosition();
    Vec2 posS = physics.worldToScreen(posW);
    String position = String.format("Pos: %.2f, %.2f - %s", posS.x, posS.y, information);
    text(position, 10, 20);
  }
  // We visualize the drag scope
  if (pressMouseX >= 0)
  {
    stroke(#FF8800);
    line(pressMouseX, pressMouseY, mouseX, mouseY);
  }
}

// Get the position where the mouse is pressed
float pressMouseX = -1, pressMouseY = -1;
void mousePressed()
{
  pressMouseX = mouseX;
  pressMouseY = mouseY;
}

// When released, we see if it is on a non-static body
// and if so, we apply the currently chosen action
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
    Vec2 impulse = new Vec2(dX / 100, dY / 100);
    information = String.format("Impulse: %s * %.1f", impulse, mass);
    movedBody.applyImpulse(impulse.mul(mass), point);
  }
  pressMouseX = pressMouseY = -1;
}

void keyPressed()
{
  // Reset the sketch
  physics.destroy();
  physics = null;
  InitScene();
  println(key);
  switch (key)
  {
  case 'd':
  case 'D': // Distance
    CreateDistanceObjects();
    break;
  case 'r':
  case 'R': // Revolution
    CreateRevoluteObjects();
    break;
  case 'p':
  case 'P': // Prismatic
    CreatePrismaticObjects();
    break;
  case 'g':
  case 'G': // Gear
    CreateGearObjects();
    break;
  case 'y':
  case 'Y': // Pulley
    CreatePulleyObjects();
    break;
  default: // Ignore...
  }
}

void InitScene()
{
  // Set up the engine with the sketch's dimensions
  physics = new Physics(this, width, height);
  world = physics.getWorld();
  // And set the density for the other objects
  physics.setDensity(1.0);
}

int BODY_NB = 7;
Body[] anchors, swinging, upper, lower;

/// A distance joint constrains two points on two bodies
/// to remain at a fixed distance from each other. You can view
/// this as a massless, rigid rod.
void CreateDistanceObjects()
{
  physics.setDensity(0.0);
  anchors = CreateBodies(70.0, 50.0, 10.0);
  physics.setDensity(1.0);
  swinging = CreateBodies(50.0, 120.0, 20.0);
  upper = CreateBodies(70.0, 200.0, 30.0);
  lower = CreateBodies(50.0, 270.0, 20.0);

  // The "manual way", If you need to attach somewhere else than at the centers
  //  Create a distance (stick) joint between two bodies that holds the specified points at a constant distance
  // body1, body2, xa, ya, xb, yb
//~   Body b1 = anchors[0], b2 = swinging[0];
//~   Vec2 b1p = physics.worldToScreen(b1.getPosition());
//~   Vec2 b2p = physics.worldToScreen(b2.getPosition());
//~   DistanceJoint distance = physics.createDistanceJoint(b1, b2,
//~        b1p.x, b1p.y, b2p.x, b2p.y);
  // The BoxWrap2D way
  // By default, it is stiff: frequency and damping ratio are zero
  DistanceJoint distance1 = JointUtils.createDistanceJoint(anchors[0], swinging[0]);
  DistanceJoint distance2 = JointUtils.createDistanceJoint(upper[0], lower[0]);

  DistanceJoint distance3 = JointUtils.createDistanceJoint(anchors[1], swinging[1]);
  // No visible change?
  distance3.setFrequency(10.0);
  distance3.setDampingRatio(0.9);
  DistanceJoint distance4 = JointUtils.createDistanceJoint(upper[1], lower[1]);
  // Here the distance between the bodies can be smaller
  distance4.setFrequency(2.0);
  distance4.setDampingRatio(0.5);
}

void CreatePrismaticObjects()
{
  physics.setDensity(0.0);
  anchors = CreateBodies(70.0, 50.0, 10.0);
  physics.setDensity(1.0);
  swinging = CreateBodies(50.0, 120.0, 20.0);
  upper = CreateBodies(70.0, 200.0, 30.0);
  lower = CreateBodies(50.0, 270.0, 20.0);

  // Create a prismatic (piston) joint between two bodies that allows movement in the given direction
//~   PrismaticJoint prismatic = physics.createPrismaticJoint(body2, body3, dirX, dirY);
//~   pj.m_enableLimit = true;
//~   pj.setLimits(-1.0f, 1.0f);
}

void CreateRevoluteObjects()
{
  physics.setDensity(0.0);
  anchors = CreateBodies(70.0, 50.0, 10.0);
  physics.setDensity(1.0);
  swinging = CreateBodies(50.0, 120.0, 20.0);
  upper = CreateBodies(70.0, 200.0, 30.0);
  lower = CreateBodies(50.0, 270.0, 20.0);

  // Create a revolute (pin) joint between the two bodies at the given position
//~   RevoluteJoint revolute = physics.createRevoluteJoint(body1, body2, x, y);
}

void CreateGearObjects()
{
  physics.setDensity(0.0);
  anchors = CreateBodies(70.0, 50.0, 10.0);
  physics.setDensity(1.0);
  swinging = CreateBodies(50.0, 120.0, 20.0);
  upper = CreateBodies(70.0, 200.0, 30.0);
  lower = CreateBodies(50.0, 270.0, 20.0);

  // Create a gear joint, which binds together two existing revolute or prismatic joints (any combination will work)
//~   GearJoint gear = physics.createGearJoint(body1, body2, xa, ya, xb, yb);
}

void CreatePulleyObjects()
{
  physics.setDensity(0.0);
  anchors = CreateBodies(70.0, 50.0, 10.0);
  physics.setDensity(1.0);
  swinging = CreateBodies(50.0, 120.0, 20.0);
  upper = CreateBodies(70.0, 200.0, 30.0);
  lower = CreateBodies(50.0, 270.0, 20.0);

  // Make a pulley joint
  float groundAnchorAx = 100;
  float groundAnchorAy = 150;
  float groundAnchorBx = 540;
  float groundAnchorBy = 150;
  float anchorAx = 100;
  float anchorAy = 20;
//  float anchorBx = 120+(numLinks-1)*25;
  float anchorBy = 20;
  float ratio = 1.0f;

//~   PulleyJoint pulley = physics.createPulleyJoint(b1, b2,
//~       groundAnchorAx, groundAnchorAy,
//~       groundAnchorBx, groundAnchorBy,
//~       anchorAx, anchorAy,
//~       anchorBx, anchorBy,
//~       ratio);
}

Body[] CreateBodies(float xPos, float yPos, float halfSize)
{
  Body[] bodies = new Body[BODY_NB];
  float interval = width / (BODY_NB + 0.75);
  for (int i = 0; i < BODY_NB; i++)
  {
    bodies[i] = physics.createRect(xPos + interval * i - halfSize, yPos - halfSize,
        xPos + interval * i + halfSize, yPos + halfSize);
  }
  return bodies;
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
