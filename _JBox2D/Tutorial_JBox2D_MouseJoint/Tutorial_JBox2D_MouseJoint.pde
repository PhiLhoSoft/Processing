/*
 * A tutorial on JBox2D, using BoxWrap2D for Processing.
 * http://processing.org/discourse/yabb2/YaBB.pl?num=1247034244
 * Part x: implementing and using MouseJoint
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
// Reference to the world as we need it for more advanced stuff...
World world;
// Some elements we need
MouseJoint m_mouseJoint;
Body movedBody;
Body circle, ground;

void setup()
{
  // Medium sized scene
  size(640, 480);
  // Physics is computed 60 times per second, so let's draw at same rate
  frameRate(60);
  // Nicer graphisc
  smooth();

  PFont f = loadFont("Verdana-12.vlw");
  textFont(f);

  // Set up everything physics
  InitScene();
//~   physics.setCustomRenderingMethod(this, "CustomWorld");
  // And add object to the scene
  CreateObjects();
}

void draw()
{
  // Not much to do here, most drawing is handled by BoxWrap2D
  background(255);
  // Show position of latest moved body
  Vec2 posW;
  if (movedBody == null)
  {
    posW = circle.getPosition();
  }
  else
  {
    posW = movedBody.getPosition();
  }
  Vec2 posS = physics.worldToScreen(posW);
  String position = String.format("Pos: %.2f, %.2f", posS.x, posS.y);
  text(position, 10, 20);
}

void mousePressed()
{
  if (m_mouseJoint == null)
  {
    movedBody = GetBodyAtMouse();
    if (movedBody != null)
    {
      m_mouseJoint = createMouseJoint(movedBody, mouseX, mouseY);
    }
  }
}

void mouseReleased()
{
  if (m_mouseJoint != null)
  {
    world.destroyJoint(m_mouseJoint);
    m_mouseJoint = null;
  }
}

void mouseDragged()
{
  if (m_mouseJoint != null)
  {
    Vec2 v = physics.screenToWorld(mouseX, mouseY);
    m_mouseJoint.setTarget(v);
  }
}

void keyPressed()
{
//~   physics.unsetCustomRenderingMethod();

  // Can be used to reset the sketch, for example
  physics.destroy();
  physics = null;
  InitScene();
}

void InitScene()
{
  // Set up the engine with the sketch's dimensions
  physics = new Physics(this, width, height);
  world = physics.getWorld();
  ground = physics.createRect(
      20, height - 40,
      width - 20, height - 20
  );
  physics.setDensity(1.0);
}

void CreateObjects()
{
  // Middle of the world
  float hw = width / 2.0;
  float hh = height / 2.0;
  // A round object in the middle of the scene (center coordinates, radius)
  circle = physics.createCircle(hw, hh, 50.0);
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

MouseJoint createMouseJoint(Body body, float x, float y)
{
  Vec2 v = physics.screenToWorld(x, y);
  MouseJointDef mjd = new MouseJointDef();
  mjd.body1 = body; // Not used, avoid a NPE
  mjd.body2 = body;
  mjd.target = v;
  mjd.maxForce = 3000.0 * body.m_mass;
  return (MouseJoint) world.createJoint(mjd);
}

// Idea taken from source seen at The Stem > Box2D Joints #2 - Revolute Joints <http://blog.thestem.ca/archives/102>
Body GetBodyAtMouse()
{
  // Create a small box at mouse point
  Vec2 v = physics.screenToWorld(mouseX, mouseY);
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
