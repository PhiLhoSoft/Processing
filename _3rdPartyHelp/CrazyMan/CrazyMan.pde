import org.jbox2d.util.nonconvex.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.testbed.*;
import org.jbox2d.collision.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.p5.*;
import org.jbox2d.dynamics.*;

Physics physics;
Man someguy;
char creatorMode;
Circles circles;
Joints joints;
World world;

void setup(){
  size(300, 200);
  frameRate(60);
  smooth();
  InitScene();
  someguy = new Man(width/10.0, height/10.0, width/2.0, height/2.0, physics);
  circles = new Circles(physics);
  joints = new Joints(physics);
}

void draw(){
  background(255);
}

void InitScene()
{
  // Set up the engine with the sketch's dimensions
  physics = new Physics(this, width, height);
  world = physics.getWorld();
}

void keyPressed()
{
  switch(key) {
    case 'a':
      someguy.moveLeft();
      return;
    
    case 'd':
      someguy.moveRight();
      return;
    
    case 'w':
      someguy.moveUp();
      return;
    case 'c':
      creatorMode = 'c';
      return;
    case 'x':
      creatorMode = 'x';
      return;
    case 'v':
      creatorMode = 'j';
      return;    
  }
  // Can be used to reset the sketch, for example
  physics.destroy();
  physics = null;
  InitScene();
  //createObjects();
}

void mouseReleased(){
  if(creatorMode == 'c'){
    circles.createNew(mouseX, mouseY, 10.0);
  }
  else if(creatorMode == 'x'){
    circles.createNewDynamic(mouseX, mouseY, 10.0);
  }
  else if(creatorMode == 'j'){
    joints.createNew(getBodyAtPoint(mouseX, mouseY));
  }
}

Body getBodyAtPoint(float x, float y)
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
// Ensure it is really at this point
if (s.testPoint(s.m_body.getXForm(), v))
 return s.m_body; // Return the first body found
    }
  return null;
}



class Man{
  BodyDef manDef;
  PolygonDef manShapeDef;
  Body crazyMan;
  ForceUtils futil = new ForceUtils();
  Vec2 pointLeft;
  Vec2 pointRight;
  Vec2 pointDown;
  Vec2 pointUp;
  Boolean isJumping;

  
  Man(float mWidth, float mHeight, float x, float y, Physics physics){
    physics.setDensity(1.0);
    physics.setFriction(0.5);
    manDef = new BodyDef();
    manDef.fixedRotation = true;
    crazyMan = physics.getWorld().createBody(manDef);
    PolygonDef pDef = new PolygonDef();
    pDef.setAsBox(mWidth, mHeight, new Vec2(x,y), 0.0);
    crazyMan.createShape(pDef); 
    //crazyMan = physics.createRect(x1, y1, x2, y2);
    pointLeft = new Vec2(-width,0);
    pointRight = new Vec2(width,0);
    pointUp = new Vec2(0, height);
    pointDown = new Vec2(0,-height);
  }
  
  float getMass(){
    return crazyMan.m_mass;
  }
  
  void moveLeft(){
    futil.push(crazyMan, pointLeft, 3000.0);  
  }

  void moveRight(){
    futil.push(crazyMan, pointRight, 3000.0);  
  }

  void moveDown(){
    futil.push(crazyMan, pointDown, 3000.0);  
  }

  void moveUp(){
    futil.push(crazyMan, pointUp, 3000.0);  
  }
}


class Joints{
  private LinkedList<Joint> jointList;
  Boolean hasFirstEnd;
  Body firstEnd;
  Physics physics;
  
  
  Joints(Physics p){
    physics = p;
    hasFirstEnd = false;
    jointList = new LinkedList<Joint>();
  }
  
  void createNew(Body attachment){
    if(attachment == null) return;
    if(hasFirstEnd){
      physics.setRestitution(1.0);
      jointList.add(JointUtils.createDistanceJoint(attachment, firstEnd));
      hasFirstEnd = false;
    } else {
      hasFirstEnd = true;
      firstEnd = attachment;
    }
  }
}


class Circles{
  
  private LinkedList<Body> circleList;
  Physics physics;
  
  Circles(Physics p){
    circleList = new LinkedList<Body>();
    this.physics = p;
  } 
  
  void createNew(int x, int y, float r){
    physics.setDensity(0.0);
    circleList.add(physics.createCircle((float) x,(float) y,r));
  }
    void createNewDynamic(int x, int y, float r){
    physics.setDensity(1.0);
    circleList.add(physics.createCircle((float) x,(float) y,r));
  }
}

