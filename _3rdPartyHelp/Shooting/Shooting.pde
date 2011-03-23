Player ship;
Projectile[] bullets = new Projectile[20]; // Max nb of bullets at a time
int enemySize = 10;

int randx() {
  return int(random(30,770));
}

float[] enemyXlocation = { randx(), randx(), randx(), randx(), randx() };
float[] enemyYlocation = { 0, 0, 0, 0, 0 };

void setup() {
  size(800,600);
  ship = new Player(color(100,100,150));
}

boolean bShooting;
int frameCounter;

void draw() {
  background(127);
  fill(255);
  text(frameCount, 0, 10);
  ship.movement();
  ship.display();
  enemyHappen();
  if (bShooting) {
    frameCounter++;
    if (frameCounter % 10 == 0) { // Adjust interval here, should be a constant...
      // Spawn another bullet
      // Too simplistic...
//~       bullet[bulletNb++] = new Projectile(color(100, 150, 100));
      for (int i = 0; i < bullets.length; i++) {
        if (bullets[i] == null) {
          bullets[i] = new Projectile(color(100, 150, 100));
          break; // Found
        }
      }
    }
  }
  for (int i = 0; i < bullets.length; i++) {
    if (bullets[i] != null) {
      if (!bullets[i].shoot()) { // Gone out of screen
        bullets[i] = null;
      }
    }
  }
}

void mousePressed() {
  bShooting = true;
}

void mouseReleased() {
  bShooting = false;
  frameCounter = 0;
}

void enemyHappen() {
  stroke(0);
  fill(150, 100, 100);
  rectMode(CENTER);
  for (int i = 0; i < enemyXlocation.length; i++) {
    enemyXlocation[i] = enemyXlocation[i];
    enemyYlocation[i] = enemyYlocation[i]+1;
    rect(enemyXlocation[i], enemyYlocation[i], enemySize, enemySize);
    if (enemyYlocation[i] > height) {
      enemyYlocation[i] = 0;
    }
  }
}

class Player {
  color c;
  float xpos;
  float ypos;

  Player(color tempC) {
    c = tempC;
  }

  void display() {
    stroke(0);
    fill(c);
    rectMode(CENTER);
    rect(xpos,ypos, 30, 50);
  }

  void movement() {
    xpos = mouseX;
    ypos = mouseY;
    if (ypos <= ((height/3)*2)) {
      ypos = ((height/3)*2);
    }
  }
}

class Projectile {
  color c;
  float projSpeed = 3;
  float projX;
  float projY;

  Projectile(color tempC) {
    c = tempC;
    projX = mouseX;
    projY = mouseY+30;
  }

  boolean shoot() {
    projY = projY - projSpeed;
    stroke(0);
    fill(100,150,100);
    ellipse(projX, projY, 5, 5);
    return projY > 0;
  }
}

