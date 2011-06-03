// http://amnonp5.wordpress.com/2011/04/23/working-with-toxiclibs/
// http://forum.processing.org/topic/making-a-shape-explode-on-mouse-pressed

import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.util.datatypes.*;
import toxi.processing.*;

ArrayList <BreakCircle> circles = new ArrayList <BreakCircle> ();
VerletPhysics2D physics;
ToxiclibsSupport gfx;
FloatRange radius;
Vec2D origin, mouse;

int maxCircles = 90; // maximum amount of circles on the screen
int numPoints = 50;  // number of voronoi points / segments
int minSpeed = 2;    // minimum speed of a voronoi segment
int maxSpeed = 14;   // maximum speed of a voronoi segment

void setup() {
  size(1280,720);
  smooth();
  noStroke();
  gfx = new ToxiclibsSupport(this);
  physics = new VerletPhysics2D();
  physics.setDrag(0.05f);
  physics.setWorldBounds(new Rect(0,0,width,height));
  radius = new BiasedFloatRange(30, 100, 30, 0.6f);
  origin = new Vec2D(width/2,height/2);
  reset();
}

void draw() {
  removeAddCircles();
  background(255,0,0);
  physics.update();

  mouse = new Vec2D(mouseX,mouseY);
  for (BreakCircle bc : circles) {
    bc.run();
  }
}

void removeAddCircles() {
  for (int i=circles.size()-1; i>=0; i--) {
    // if a circle is invisible, remove it...
    if (circles.get(i).transparency < 0) {
      circles.remove(i);
      // and add two new circles (if there are less than maxCircles)
      if (circles.size() < maxCircles) {
        circles.add(new BreakCircle(origin,radius.pickRandom()));
        circles.add(new BreakCircle(origin,radius.pickRandom()));
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') { reset(); }
}

void reset() {
  // remove all physics elements
  for (BreakCircle bc : circles) {
    physics.removeParticle(bc.vp);
    physics.removeBehavior(bc.abh);
  }
  // remove all circles
  circles.clear();
  // add one circle of radius 200 at the origin
  circles.add(new BreakCircle(origin,200));
}

