/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/91513*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */



Person p;
String levelname = "Testterrainfull_0000.gif";
String levelc = "Testterrainfullcolission_0000.gif";
PImage level;
PImage lcol;

boolean MovingRight = false;
boolean MovingLeft = false;
boolean LookingLeft = false;
boolean LookingRight = true;

boolean Jumping = false;
boolean LookingUp = false;
boolean LookingDown = false;

boolean Ground = false;
boolean xMoving = false;

boolean HasGun = true;

void setup() {
  level = loadImage(levelname);
  lcol = loadImage(levelc);
  size(level.width * 2, level.height * 2);
  p = new Person();
  background(255);
  frameRate(15);
}

void draw() {
  scale(2);
  background(255);
  image(level, 0, 0);
  p.update();
  if(MovingLeft == MovingRight){
    xMoving = false;
  }else{xMoving = true;}
  System.out.println(p.collision());
}
  

void keyPressed() {
  switch(keyCode){
    case 'a': case 'A': case LEFT:
      MovingLeft = true;
      LookingLeft = true;
      LookingRight = false;
      break;
    case 'd': case 'D': case RIGHT:
      MovingRight = true;
      LookingRight = true;
      LookingLeft = false;
      break;
    case 'w': case 'W': case UP:
      LookingUp = true;
      break;
    case 's': case 'S': case DOWN:
      LookingDown = true;
      break;
    case ' ':
      Jumping = true;
      break;
  }
}

void keyReleased() {
  switch(keyCode){
    case 'a': case 'A': case LEFT:
      MovingLeft = false;
      break;
    case 'd': case 'D': case RIGHT:
      MovingRight = false;
      break;
    case 'w': case 'W': case UP:
      LookingUp = false;
      break;
    case 's': case 'S': case DOWN:
      LookingDown = false;
      break;
    case ' ':
      Jumping = false;
      break;
  }
}
