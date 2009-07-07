//~ import org.jbox2d.testbed.tests.*;
//~ import org.jbox2d.testbed.*;
//~ import org.jbox2d.testbed.timingTests.*;
// Import everything exposed by JBox2D (except the testbed stuff)
import org.jbox2d.common.*;
import org.jbox2d.collision.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.dynamics.contacts.*;
//import org.jbox2d.util.blob.*;
// BoxWrap2D
import org.jbox2d.p5.*;

// A reference to the physics engine
Physics physics;
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
  // And add object to the scene
  CreateObjects();
}

void draw()
{
  // Not much to do here, most drawing is handled by BoxWrap2D
  background(255);
  // Show position of circle
  Vec2 posW = circle.getPosition();
  Vec2 posS = physics.worldToScreen(posW);
  String position = String.format("Pos: %.2f, %.2f", posS.x, posS.y);
  text(position, 10, 20);
}

void mousePressed()
{
  // Do something interactive, like creating new objects
  Body randomBody = physics.createCircle(mouseX, mouseY, random(5.0f,15f));
  Vec2 vel = new Vec2(random(-30.0f,30.0f),random(-30.0f,30.0f));
  randomBody.setLinearVelocity(vel);
}

void keyPressed()
{
  // Can be used to reset the sketch, for example
  physics.destroy();
  physics = null;
  InitScene();
}

void InitScene()
{
  // Set up the engine with the sketch's dimensions
  physics = new Physics(this, width, height);
  // Add a ground above default ground
  // It is fixed because it is defined before the density setting
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
