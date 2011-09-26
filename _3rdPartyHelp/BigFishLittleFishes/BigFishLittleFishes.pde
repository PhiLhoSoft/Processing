PFont font;
int numFishes = 8;
ArrayList<EnemyFish> fishList = new ArrayList<EnemyFish>();
PlayerFish player;
boolean keyUp, keyDown, keyLeft, keyRight;
boolean bGameOver;

void setup() {
  size(800, 800);
  font = createFont("Arial", 100);

  player = new PlayerFish();
  noStroke();
  for (int i = 0; i < numFishes; i++) {
    fishList.add(new EnemyFish());
  }
  keyUp = keyDown = keyLeft = keyRight = false;
}

void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:    keyUp    = true; break;
      case DOWN:  keyDown  = true; break;
      case LEFT:  keyLeft  = true; break;
      case RIGHT: keyRight = true; break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:    keyUp    = false; break;
      case DOWN:  keyDown  = false; break;
      case LEFT:  keyLeft  = false; break;
      case RIGHT: keyRight = false; break;
    }
  }
}

void draw() {
  background(62, 188, 202);
  if (player.isAlive) {
    if (keyUp) player.update(0, -1);
    if (keyDown) player.update(0, 1);
    if (keyLeft) player.update(-1, 0);
    if (keyRight) player.update(1, 0);

    player.update();
    player.checkWalls();
    player.draw();
  } else {
    player.update();
    player.draw();
    if (bGameOver) {
      gameOver();
    }
  }

  for (int i = 0; i < fishList.size(); i++) {
    EnemyFish fishi = fishList.get(i);

    if (fishi.isAlive) {
      if (player.collision(fishi) && player.headOn(fishi)) {
        player.eat(fishi);
      }


      for (int j = i+1; j < fishList.size(); j++) {
        EnemyFish fishj = fishList.get(j);
        if (fishi.collision(fishj)) { //GeneralFish collision method
          fishi.bounce(fishj); //bounce the fish
        }
      }//for j

      fishi.update();
      fishi.checkWalls();
    } else {
      fishi.update();
    }
    fishi.draw();
  }//for i
}//for draw

void gameOver() {
  textFont(font);
  if (player.isAlive) {
    fill(#2255FF);
  } else {
    fill(#882255);
  }
  textAlign(CENTER, CENTER);
  text("Game Over", width / 2, height / 2);
  textFont(font, 36);
  if (player.isAlive) {
    text("You win!", width / 2, 2 * height / 3);
  } else {
    text("You loose...", width / 2, 2 * height / 3);
  }
  noLoop();
}

abstract class Fish {
  float x, y, velX, velY, fishScale, fWidth;
  int bSize;
  color c;
  boolean isAlive;
  int traceTimer;
  int traceSpeed = 2;

  Fish() {
    x = random(width);
    y = random(height);
    traceTimer = int(y / traceSpeed);
    velX = random(-2, 2);
    velY = random(-2, 2);
    bSize = 150;
    fishScale = random(0.3, 0.9);
    isAlive = true;
  }

  void updateSize(float newScale) {
    fishScale = newScale;
    fWidth = bSize * fishScale;
  }

  //a method for collision
  boolean collision(Fish other) {
    return dist(x, y, other.x, other.y) < fWidth/2 + other.fWidth/2;
  }

  void update() {
    if (isAlive) {
      x += velX;
      y += velY;
    } else if (traceTimer > 0) {
      traceTimer--;
      y += traceSpeed;
    }
  }

  void dies()
  {
    isAlive = false;
  }
  abstract void checkWalls(); // To be defined
  abstract void draw(); // To be defined
}//class

class PlayerFish extends Fish {

  PlayerFish() {
    super();
    updateSize(random(0.4, 0.9));
  }

  void update() {
    velX *= 0.92;
    velY *= 0.92;
    super.update();
    if (traceTimer == 0) {
      bGameOver = true;
    }
  }

  void update(float xDir, float yDir) {
    velX += xDir;
    velY += yDir;
  }

  boolean headOn(Fish other) {
    return velX > 0 && other.velX < 0 || velX < 0 && other.velX > 0;
  }

  void eat(Fish other) {
    if (fWidth > other.fWidth && other.isAlive) {
      if (fishScale < 4) {
        updateSize(fishScale * 1.15);
      } else {
        // Game over?
        gameOver();
      }
      other.dies();
    } else {
      background(0);
      dies();
    }
  }

  void dies(){
    super.dies();
  }

  void checkWalls() {
    //right wall
    if (x > width - bSize/4) {
      x = width - bSize/4;
      velX *= -1;
    }
    //left wall
    if (x < bSize/4) {
      x = bSize/4;
      velX *= -1;
    }
    //bottom wall
    if (y > height - bSize/4) {
      y = height - bSize/4;
      velY *= -1;
    }
    //top wall
    if (y < bSize/4) {
      y = bSize/4;
      velY *= -1;
    }
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    scale(fishScale);

    if (velX  > 0) {
      scale(-1, 1);
    }

    noStroke();
    strokeWeight(1);
    fill(255, 115, 85);
    quad(-15, -20, 45, 0, -15, 30, -15, 30);
    stroke(2);
    fill(255, 115, 85);
    curve(-100, 26, -15, -20, 45, 0, 73, 61);
    curve(73, -50, 45, 0, -15, 30, 15, -25);
    curve(600, -100, -15, -20, -15, 30, 73, -50);
    triangle(45, 0, 55, 10, 65, -10);

    noStroke();
    fill(62, 188, 202);
    // triangle(-20,15,-36,25,-56,0);
    //eye
    strokeWeight(1);
    stroke(2);
    fill(255, 255, 255);
    ellipse(-25, 0, 15, 15);
    fill(0, 0, 0);
    ellipse(-25, 0, 8, 8);
    noStroke();
    fill(153, 204, 50);
    ellipse(3, 0, 10, 10);
    ellipse(5, -2, 10, 10);
    ellipse(10, 5, 8, 8);
    ellipse(25, 1, 10, 10);
    ellipse(0, 10, 10, 10);
    ellipse(32, -5, 5, 5);
    ellipse(10, - 8, 10, 10);
    ellipse(15, 10, 10, 10);
    ellipse(30, -2, 5, 5);
    ellipse(5, -8, 4, 4);
    ellipse(25, -5, 5, 5);
    popMatrix();
  }
}//end class

class EnemyFish extends Fish {
  float wave, waveSpeed, amp;
  int enemyBound;
  color c;

  EnemyFish() {
    super();
    wave = random(TWO_PI);
    waveSpeed = random(0.1, 0.5);
    amp = random(1, 4);
    enemyBound = 50;
    updateSize(random(0.3, 0.9));
    c = color(random(255), random(10), 150);
  }

  EnemyFish(float xpos, float ypos, float velXa, float velYa) {
    this();
    x = xpos;
    y = ypos;
    velX = velXa;
    velX = velYa;
  }

  void update() {
    wave += waveSpeed;
    y += amp * sin(wave);
    super.update();
    if (traceTimer == 0) {
      fishList.remove(this);
      spawnNewEnemyFish(fishList);
    }
  }

  void bounce(Fish other) {
    float angle = atan2(y - other.y, x - other.x);
    velX = 2 * cos(angle);
    velY = 2 * sin(angle);
    other.velX = 2 * cos(angle - PI);
    other.velY = 2 * sin(angle - PI);
  }

  void dies() {
    super.dies();
    c = color(100);
  }

  void spawnNewEnemyFish(ArrayList fishList) {
    if (random(0, 2) < 1) {
      fishList.add(new EnemyFish(-25, random(100, height-100), random(1, 4), random(-2, 2)));
    } else {
      fishList.add(new EnemyFish(width+25, random(100, height-100), random(-1, -4), random(-2, 2)));
    }
  }

  //change this method for enemyFish wall collision
  void checkWalls() {
    //right and left wall
    if (x > width + enemyBound || x < -enemyBound) {
      dies();
    }
    //bottom wall
    if (y > height - bSize/4) {
      y = height - bSize/4;
      velY *= -1;
    }
    //top wall
    if (y < bSize/4) {
      y = bSize/4;
      velY *= -1;
    }
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    scale(fishScale);
    if (velX<0) {
      scale(-1, 1);
    }


    //fish
    fill(c);
    arc(30, 0, 60, 30, -PI/2, PI/2);
    quad(30, -15, 30, 15, -50, 5, -50, -19);
    quad(-50, -10, -50, 5, -70, 10, -69, 8);
    stroke(3);
    noFill();
    curve(300, 100, 35, -15, -70, 35, 100, 270);
    curve(300, 100, 30, -10, -70, 35, 100, 270);
    curve(300, 100, 30, -5, -70, 35, 100, 270);
    curve(300, 100, 30, 0, -70, 35, 100, 270);
    curve(300, 100, 30, 5, -70, 35, 100, 270);
    curve(300, 100, 30, 10, -70, 35, 100, 270);
    curve(300, 100, 30, 15, -70, 35, 100, 270);
    fill(0, 0, 0);
    ellipse(40, -5, 6, 6);//eye
    fill(229, 190, 157);
    triangle(-66, 35, -40, 50, -40, 60);//tail
    triangle(-70, 33, -40, 70, -40, 90);//tail

    triangle(30-10, 30-16, 30-40, 30-20, 30-35, 30-10);//down fin

    curve(30-20, 50, 30-80, 30-40, -30, 30-48, 30+20, 30+20);
    curve(30*0, 0, 30-53, 30-48, 30-40, 30-48, 30, 30+10);
    popMatrix();
  }
}

