// http://processing.org/discourse/yabb_beta/YaBB.cgi?board=Programs;action=display;num=1233427196

import traer.physics.*;

Particle mouse, b;
ParticleSystem physics;

float prevX, prevY;
PVector xAxis = new PVector(1, 0);

void setup()
{
  size( 400, 400 );
  frameRate( 24 );
  smooth();
  ellipseMode( CENTER );
  noStroke();
  noCursor();

  physics = new ParticleSystem( 0, 0.1 );
  mouse = physics.makeParticle();
  mouse.makeFixed();
  b = physics.makeParticle( 1.0, random( 0, width ), random( 0, height ), 0 );


  physics.makeAttraction( mouse, b, 10000, 10 );
}

void draw()
{
  mouse.moveTo( mouseX, mouseY, 0 );
  handleBoundaryCollisions( b );
  physics.tick();

  // background( 255 );

  fill( 255, 0, 0 );
  ellipse( mouse.position().x(), mouse.position().y(),  5,  5 );

  stroke(0);
  strokeWeight(1);
  float x = b.position().x();
  float y = b.position().y();
  drawVector(x, y, new PVector(x - prevX, y - prevY));
  prevX = x; prevY = y;
}

// really basic collision strategy:
void handleBoundaryCollisions( Particle p )
{
  if ( p.position().x() < 0 || p.position().x() > width )
    p.setVelocity( -0.9*p.velocity().x(), p.velocity().y(), 0 );
  if ( p.position().y() < 0 || p.position().y() > height )
    p.setVelocity( p.velocity().x(), -0.9*p.velocity().y(), 0 );
  p.moveTo( constrain( p.position().x(), 0, width ), constrain( p.position().y(), 0, height ), 0 );
}

void drawVector(float x, float y, PVector v)
{
  pushMatrix();
  float a = PVector.angleBetween(v, xAxis);
  if (v.y < 0)
  {
    a = TWO_PI - a;
  }
  translate(x, y);
  rotate(a);

  stroke(0);
  strokeWeight(1);
  line(0, 0, 20, 0);
  fill(244, 0, 0);
  ellipse(0, 0, 3, 3);
  ellipse(20, 0, 3, 3);
  popMatrix();
}
