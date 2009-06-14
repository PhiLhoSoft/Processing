//~ import org.jbox2d.testbed.tests.*;
//~ import org.jbox2d.testbed.*;
//~ import org.jbox2d.testbed.timingTests.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.util.blob.*;
import org.jbox2d.collision.*;
import org.jbox2d.p5.*;

// Number of links in chain
int numLinks = 10;

// Physics things we must store
Physics physics;
Body body1, body2;

void setup()
{
  size(640, 480);
  frameRate(60);
  smooth();
  InitScene();
//~   physics.setCustomRenderingMethod(this, "CustomWorld");
}

void draw()
{
  background(255);
}

void mousePressed()
{
    //Create a body
    float x0 = mouseX;
    float y0 = mouseY;
    Body randomBody = physics.createCircle(x0, y0, random(5.0f,15f));
    Vec2 vel = new Vec2(random(-30.0f,30.0f),random(-30.0f,30.0f));
    randomBody.setLinearVelocity(vel);
}

void keyPressed()
{
//~     physics.unsetCustomRenderingMethod();

    //Reset everything
    physics.destroy();
    physics = null;
    body1 = body2 = null;
    InitScene();
}

void InitScene()
{
  physics = new Physics(this, width, height);
  physics.setDensity(1.0f);
/*
  Body b1 = null;
  Body b2 = null;
  // Make a chain of bodies
  for (int i=0; i<numLinks; ++i)
  {
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

    if (body1 == null)
    {
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
*/
}
