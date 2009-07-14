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
  size(800, 500);
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

Body[] CreateBodies(int bodyNb, float xPos, float yPos, float halfSize)
{
  Body[] bodies = new Body[bodyNb];
  float interval = width / (bodyNb + 0.75);
  for (int i = 0; i < bodyNb; i++)
  {
    bodies[i] = physics.createRect(xPos + interval * i - halfSize, yPos - halfSize,
        xPos + interval * i + halfSize, yPos + halfSize);
  }
  return bodies;
}

/// A distance joint constrains two points on two bodies
/// to remain at a fixed distance from each other. You can view
/// this as a massless, rigid rod.
void CreateDistanceObjects()
{
  // Set some fixed objects (handles)
  physics.setDensity(0.0);
  Body hl = physics.createCircle(70.0, 50.0, 10.0);
  Body hr = physics.createCircle(width - 70.0, 50.0, 10.0);

  int C_NB = 7;
  Body[] hc = new Body[C_NB];
  for (int i = 0; i < C_NB; i++)
  {
    hc[i] = physics.createCircle(170 + 75.0 * i, 50.0, 10.0);
  }

  // And some moving ones
  physics.setDensity(1.0);
  Body hangingL = physics.createRect(90.0, 150.0, 110.0, 200.0);
  Body hangingR = physics.createRect(width - 50.0, 150.0, width - 30.0, 200.0);

  Body[] hangC = new Body[C_NB];
  for (int i = 0; i < C_NB; i++)
  {
    hangC[i] = physics.createRect(190 + 75.0 * i, 150.0, 210 + 75.0 * i, 200.0);
  }

  // The "manual way", If you need to attach somewhere else than at the centers
  //  Create a distance (stick) joint between two bodies that holds the specified points at a constant distance
  // body1, body2, xa, ya, xb, yb
  Vec2 hlp = physics.worldToScreen(hl.getPosition());
  Vec2 hangingLp = physics.worldToScreen(hangingL.getPosition());
  physics.createDistanceJoint(hl, hangingL,
       hlp.x, hlp.y, hangingLp.x - 5.0, hangingLp.y - 20.0);

  // A simpler way, joining the centers of mass of the bodies
  // By default, it is stiff: frequency and damping ratio are zero
  JointUtils.createDistanceJoint(hr, hangingR);

  // Trying to do something more elastic
  DistanceJoint[] dj = new DistanceJoint[C_NB];
  for (int i = 0; i < C_NB; i++)
  {
    dj[i] = JointUtils.createDistanceJoint(hc[i], hangC[i]);
  }
  // A high frequence makes the hanging object to stabilize faster
  dj[0].setFrequency(0.2);
  // A low damping ration makes the amplitude of the movement bigger
  dj[0].setDampingRatio(0.1);
  
  // (No accessor) Gives some margin to extend
  dj[1].m_length *= 2.0; 
  // Same parameters, for comparison
  dj[1].setFrequency(0.2);
  dj[1].setDampingRatio(0.1);
  
  // High frequency
  dj[2].m_length *= 2.0; 
  dj[2].setFrequency(1.0);
  dj[2].setDampingRatio(0.1);
  
  // Stiffer
  dj[3].m_length *= 2.0; 
  dj[3].setFrequency(0.2);
  dj[3].setDampingRatio(0.5);
  
  // Very high frequency with low damping:
  // It moves a lot but stops occillating quickly
  dj[4].m_length *= 2.0; 
  dj[4].setFrequency(10.0);
  dj[4].setDampingRatio(0.01);

  // Smaller extent
  dj[5].m_length *= 0.7; 
  // Same parameters, for comparison
  dj[5].setFrequency(0.2);
  dj[5].setDampingRatio(0.1);

  // With a very low frequency, it doesn't even have time to go up!
  dj[6].setFrequency(0.08);
  dj[6].setDampingRatio(0.1);

  // Tight joints. With no room to extend, I supposed it would make
  // a rigid body but the engine makes the shapes to overlap...
  Body tb1, tb2, tb3;
  tb1 = physics.createRect(20.0, 220.0, 100.0, 240.0);
  tb2 = physics.createRect(50.0, 240.0, 70.0, 320.0);
  tb3 = physics.createRect(70.0, 260.0, 150.0, 300.0);
  JointUtils.createDistanceJoint(tb1, tb2);
  JointUtils.createDistanceJoint(tb2, tb3);
  
  // Looser joints
  Body lb1, lb2;
  lb1 = physics.createRect(200.0, 300.0, 250.0, 350.0);
  lb2 = physics.createCircle(300.0, 350.0, 30.0);
  JointUtils.createDistanceJoint(lb1, lb2);
  
  // Even looser joints!
  Body elb1, elb2;
  elb1 = physics.createRect(width - 70.0, 300.0, width - 20.0, 350.0);
  elb2 = physics.createCircle(width - 120.0, 250.0, 30.0);
  DistanceJoint ldj = JointUtils.createDistanceJoint(elb1, elb2);
  ldj.setFrequency(0.2);
  ldj.setDampingRatio(0.1);
}

void CreatePrismaticObjects()
{
  // Create a prismatic (piston) joint between two bodies that allows movement in the given direction
//~   PrismaticJoint prismatic = physics.createPrismaticJoint(body2, body3, dirX, dirY);
//~   pj.m_enableLimit = true;
//~   pj.setLimits(-1.0f, 1.0f);
}

void CreateRevoluteObjects()
{
  // Create a revolute (pin) joint between the two bodies at the given position
//~   RevoluteJoint revolute = physics.createRevoluteJoint(body1, body2, x, y);
}

void CreateGearObjects()
{
  // Create a gear joint, which binds together two existing revolute or prismatic joints (any combination will work)
//~   GearJoint gear = physics.createGearJoint(body1, body2, xa, ya, xb, yb);
}

void CreatePulleyObjects()
{
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
