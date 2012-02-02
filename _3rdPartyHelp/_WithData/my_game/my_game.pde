

FontStyle P1Font;  //style class allows you to highlight interface sections quickly
FontStyle normalFont;

PImage shotImg;
PImage BG;
PImage player;
PImage enemy;

Fade fader;//allows you to use screen wipes that auto-cue the next game mode
Charact theChar;
Mode mode; //mode class runs all functions of the game
Villain[] bad;
Bull[] Bullet;

int maxEnemies=5;
int maxShots=200;

PFont font;

int wave;
int lives=1;
int score=0;
int power=0;
float tsize=200;

PVector mouse;

int highScore=50000;
int currentShots=0;

void setup() {
  size(800, 600);
  println("Start of setup");
  P1Font=new FontStyle(0, 255, 0, 22, 0, 1);
  normalFont=new FontStyle(255, 255, 255, 22, 0, 1);
  bad = new Villain[maxEnemies];
  Bullet = new Bull[maxShots];
  mouse=new PVector(0, 0, 0);

  strokeWeight(5);
  smooth();
  cursor(CROSS);
  font=loadFont("Proxy_7-56.vlw");
  //bullet image
  shotImg = loadImage("shot1.png");
  //enemy char
  for (int i=1; i<12; i++) {
    enemy=loadImage("enemy.png");
  }
  //hero char
  player=loadImage("player.png");
  imageMode(CENTER);
  rectMode(CENTER);
  theChar = new Charact();
  BG=loadImage("BG.png");
  mode=new Title();

  println("End of setup");
}

void draw() {

  mode.run(); //run current game mode

  if (fader!=null) {
    fader.display();
    fader.run();
  }
}

