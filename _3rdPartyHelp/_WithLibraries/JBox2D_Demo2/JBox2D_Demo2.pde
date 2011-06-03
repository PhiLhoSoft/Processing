// http://processing.org/discourse/yabb2/YaBB.pl?num=1230505307
// SpaceRibs

// === Start of SwingingDemo

import org.jbox2d.testbed.tests.*;
import org.jbox2d.testbed.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.p5.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.common.*;
import org.jbox2d.util.blob.*;
import org.jbox2d.collision.*;
import org.jbox2d.testbed.timingTests.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.Shape;

// Number of links in chain
int numLinks = 10;

// Physics things we must store
Physics physics;
Body body1, body2;

void setup() {
  size(640, 480);
  frameRate(60);
  smooth();
  initScene();
  physics.setCustomRenderingMethod(this, "CustomWorld");
}

void draw() {
  if (mousePressed) {
    //Create a body
    float x0 = mouseX;
    float y0 = mouseY;
    Body randomBod = physics.createCircle(x0, y0, random(5.0f,15f));
    Vec2 vel = new Vec2(random(-30.0f,30.0f),random(-30.0f,30.0f));
    randomBod.setLinearVelocity(vel);
  }

  if (keyPressed) {
    // Apparently these are the same
//    physics.setCustomRenderingMethod(physics, "defaultDraw");
    physics.unsetCustomRenderingMethod();

    //Reset everything
    physics.destroy();
    physics = null;
    body1 = body2 = null;
    initScene();
  }
}

void initScene() {
  physics = new Physics(this, width, height);
  physics.setDensity(1.0f);
  Body b1 = null;
  Body b2 = null;

  // Make a chain of bodies
  for (int i=0; i<numLinks; ++i) {
    body1 = body2; //bookkeeping, for neighbor connection

    body2 = physics.createRect(100+25*i, 10, 120+25*i, 30);

    // Add a hanging thingy to each body, connect it
    // with a prismatic joint (like a piston)
    Body body3 = physics.createCircle(110+25*i,35,5.0f);
    PrismaticJoint pj = physics.createPrismaticJoint(body2, body3, 0.0f, 1.0f);
    pj.m_enableLimit = true;
    pj.setLimits(-1.0f, 1.0f);

    if (i==0) b1 = body2; // for pulley joint later
    if (i==numLinks-1) b2 = body2;

    if (body1 == null) {
      // No previous body, so continue without adding joint
      body1 = body2;
      continue;
    }
    // Connect the neighbors
    physics.createRevoluteJoint(body1, body2, 100+25*i, 20);
  }

  // Make a pulley joint
  float groundAnchorAx = 100;
  float groundAnchorAy = 150;
  float groundAnchorBx = 540;
  float groundAnchorBy = 150;
  float anchorAx = 100;
  float anchorAy = 20;
  float anchorBx = 120+(numLinks-1)*25;
  float anchorBy = 20;
  float ratio = 1.0f;

  physics.createPulleyJoint(b1, b2,
    groundAnchorAx, groundAnchorAy,
    groundAnchorBx, groundAnchorBy,
    anchorAx, anchorAy,
    anchorBx, anchorBy,
    ratio);
}

// === End of SwingingDemo

void CustomWorld(World w)
{
//  if (frameCount % 10 > 0) return;
  background(#66BABE);

  // Walk the body list in the physics world
  for (Body body = physics.getWorld().getBodyList(); body != null; body = body.getNext()) 
  {
    // For each shape of the body
    for (Shape shape = body.getShapeList(); shape != null; shape = shape.getNext()) 
    {
      // Draw the shape based on its type
      if (shape.getType() == ShapeType.POLYGON_SHAPE) 
      {
        // Polygon appearance parameters
        fill(#0055AA);
        stroke(#AACC00);
        strokeWeight(4);

        // Draw the polygon
        DrawPolygon(body, shape);
      }
      else if (shape.getType() == ShapeType.CIRCLE_SHAPE) 
      {
        // Circle appearance parameters
        fill(#CCAA00);
        stroke(#0055AA);
        strokeWeight(4);

        //Draw the circle
        DrawCircle(body, shape);
      }
      else println(shape.getType());
    }
  }
}

void DrawPolygon(Body body, Shape shape) 
{
  beginShape();

  PolygonShape polygon = (PolygonShape) shape;

  // Get the number of vertex points that make up the shape
  int count = polygon.getVertexCount();

  // Convert the polygon into points
  Vec2[] verts = polygon.getVertices();

  // Make a vertex for each point of the polygon and convert for pixel coordinates
  for (int i = 0; i < count; i++) 
  {
    // Get the position of the vertex of the shape within the body in the world (whew!!)
    Vec2 vert = physics.worldToScreen(body.getWorldPoint(verts[i]));
    vertex(vert.x, vert.y);
  }

  // Connect the last point with the first point and stop
  Vec2 firstVert = physics.worldToScreen(body.getWorldPoint(verts[0]));
  vertex(firstVert.x, firstVert.y);
  endShape();
}

void DrawCircle(Body body, Shape shape) 
{
  // Convert the shape to a circleshape
  CircleShape circle = (CircleShape) shape;

  // Get position of circle within body
  Vec2 center = circle.getLocalPosition();

  // Get position of body within world and convert to pixel coordinates
  Vec2 wPoint = physics.worldToScreen(body.getWorldPoint(center));

  // Get the diameter of the circle shape in pixel format
  float diameter = physics.worldToScreen(circle.getRadius()) * 2;

  // Draw the circle with radius converted to diameter
  ellipse(wPoint.x, wPoint.y, diameter, diameter);
}

