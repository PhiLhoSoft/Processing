int numFishes = 7;
ArrayList<EnemyFish> fishList = new ArrayList<EnemyFish>();
PlayerFish player;
boolean keyUp, keyDown, keyLeft, keyRight;

void setup() {
  size(600, 600);
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
  fill(62, 188, 202, 60);

  if (keyUp) player.update(0, -1);
  if (keyDown) player.update(0, 1);
  if (keyLeft) player.update(-1, 0);
  if (keyRight) player.update(1, 0);

  player.update();
  player.walls();
  player.drawPlayer();

  for (int i = 0; i < fishList.size(); i++) {
    EnemyFish fishi = fishList.get(i);

    if (fishi.alive) {
      if (player.collision(fishi) && player.headOn(fishi)) {
        player.eat(fishi);
      }


      for (int j = i+1; j < fishList.size(); j++) {
        EnemyFish fishj = fishList.get(j);
        if ( fishi.collision( fishj )) { //GeneralFish collision method
          fishi.bounce( fishj ); //bounce the fish
        }
      }//for j

      fishi.update();
      fishi.walls();
    } else {
      fishi.dead();
    }
    fishi.drawMe();


  }//for i
}//for draw


abstract class Fish {
  float x, y, velX, velY, fishScale, fWidth;
  int bSize;
  color c;

  Fish() {
    x = random(width);
    y = random(height);
    velX = random(-2, 2);
    velY = random(-2, 2);
    bSize = 150;
    fishScale = random(0.3, 0.9);
    fWidth = bSize * fishScale;
  }

  //a method for collision
  boolean collision(Fish other) {
    return dist(x, y, other.x, other.y) < fWidth/2 + other.fWidth/2;
  }

  void update() {
    x += velX;
    y += velY;
  }

  abstract void dead(); // To be defined
}//class

class PlayerFish extends Fish {

  PlayerFish() {
    super();
    c = color(0, 0, 255);
  }

  void update() {
    velX *= 0.92;
    velY *= 0.92;
    super.update();
  }

  void update(float xDir, float yDir) {
    velX += xDir;
    velY += yDir;
  }

  boolean headOn(Fish other) {
    return velX > 0 && other.velX < 0 || velX < 0 && other.velX > 0;
  }

  void eat(Fish other) {
    if (fWidth > other.fWidth) {
      fWidth = bSize * 1.1;
      other.dead();
    } else {
      player.dead();
    }
  }

  void dead(){
    y+=4;
  }

  void walls() {
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

  void drawPlayer() {
    pushMatrix();
    translate(x, y);

    if (velX  > 0) {
      scale(-1, 1);
    }

    noStroke();
    strokeWeight(1);
    fill(255, 115, 85);
    quad(0, -20, 60, 0, 0, 30, 0, 30);
    stroke(2);
    fill(255, 115, 85);
    curve(bSize-250, 26, 0, -20, 60, 0, 73, 61);
    curve(73, -50, 60, 0, 0, 30, 15, -25);
    curve(600, -100, 0, -20, 0, 30, 73, -50);
    triangle(60, 0, 70, 10, 80, -10);

    popMatrix();
  }
}//end class

class EnemyFish extends Fish {
  float wave, waveSpeed, amp;
  boolean alive;
  int traceTimer;
  int enemyBound;

  EnemyFish() {
    super();
    alive= true;
    wave = random(TWO_PI);
    waveSpeed = random(0.1, 0.4);
    amp = random(1, 4);
    enemyBound=50;
  }

  EnemyFish(float xpos, float ypos, float velXa, float velYa) {
    super();
    x=xpos;
    y=ypos;
    velX=velXa;
    velX=velYa;
    alive= true;
    wave = random(TWO_PI);
    waveSpeed = random(0.1, 0.5);
    amp = random(1, 4);
    fishScale=random(0.3, 0.9);
    enemyBound=50;
  }

  void update() {
    wave += waveSpeed;
    y += amp*sin(wave);
    super.update();
  }

  void bounce(Fish other) {
    float angle = atan2(y - other.y, x - other.x);
    velX = 2 * cos(angle);
    velY = 2 * sin(angle);
    other.velX = 2 * cos(angle - PI);
    other.velY = 2 * sin(angle - PI);
  }

  void dead() {
    if (traceTimer > 0) {
      traceTimer--;
      y +=2;
    } else {
      fishList.remove(this);
      spawnNewEnemyFish(fishList);
    }
  }

  void spawnNewEnemyFish(ArrayList fishList) {
    if (random(0, 2) < 1) {
      fishList.add(new EnemyFish(-25, random(100, height-100), random(1, 4), random(-2, 2)));
    } else {
      fishList.add(new EnemyFish(width+25, random(100, height-100), random(-1, -4), random(-2, 2)));
    }
  }

  //change this method for enemyFish wall collision
  void walls() {
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

  void drawMe() {
    pushMatrix();
    translate(x, y);

        if (velX<0) {
      scale(-1, 1);
    }

    scale(fishScale);
    //fish
    fill(0,255,255);
    arc(30, 0, 60, 30, -PI/2, PI/2);
    quad(30, -15, 30, 15, -50, 5, -50, -19);
    quad(-50, -10, -50, 5, -70, 10, -69, 8);
    noFill();
    stroke(2);
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

