//some useful constants (initialized in the setup)
int TANK_LEFT;
int TANK_RIGHT;
int TANK_TOP;
int TANK_BOTTOM;
int WATER_TOP;


Fish[] fishes; // For global variables, explicit longer names are better

class Fish { // Be consistent in your naming conventions!
  int x, y, w, h, dir, r, g, b;
  float speed, boost;
  Bubble[] bubbles = new Bubble[5];

  Fish() {
    //generate random values
    w = (int) random (20, 50);
    h = (int)random(w-20, w);
    dir = (int)(random(360));
    x = (int)random(TANK_LEFT+w, TANK_RIGHT-w);
    y = (int)random(WATER_TOP, TANK_BOTTOM-h/2);
    r = (int)random(0, 256);
    g = (int)random(0, 256);
    b = (int)random(0, 256);
    speed = random(3) + 3;
    // boost remains at 0

    for (int i = 0; i < bubbles.length; i++) {
      // posX and posY are relative to the fish's x and y
      int posX = int(random(-3, 3)); // Put a little randomness in the bubble positions
      int posY = -2 - int(5 * i * random(1, 2));
      bubbles[i] = new Bubble(posX, posY, 5, 5);
    }
  }

  /* Updates the location of a given fish based on
   the bouncing ball mechanics discussed in class
  */
  void move() { // Was moveFish()
    x += (int)((speed+boost)*cos(radians(dir)));
    y += (int)((speed+boost)*sin(radians(dir)));
    boost *= 0.96;

    if (x-w/2 <= TANK_LEFT) {
      dir = (180-dir) % 360;
      x = TANK_LEFT+w;
    }
    if (x+w/2 >= TANK_RIGHT) {
      dir = (180-dir) % 360;
      x = TANK_RIGHT - w;
    }
    if (y <= WATER_TOP) {
      dir = -dir;
      y = WATER_TOP;
    }
    if (y+h/2 >= TANK_BOTTOM) {
      dir = -dir;
      y = TANK_BOTTOM - h/2;
    }
  }

  void draw() { // Was drawFish()
    stroke(0);
    fill(r, g, b);
    ellipse(x, y, w, h);

    int tail;
    if (isFacingRight()) {
      tail = -w/2;

      fill(255);
      ellipse(x+w*0.25, y-h*0.25, 10, 10);
      fill(0);
      ellipse(x+w*0.25, y-h*0.25, 5, 5);
    }
    else {
      tail = w/2;
      fill(255);
      ellipse(x-w*0.25, y-h*0.25, 10, 10);
      fill(0);
      ellipse(x-w*0.25, y-h*0.25, 5, 5);
    }
    fill(r, g, b);
    triangle(x+tail, y, x+2*tail, y+h/2, x+2*tail, y-h/2);
    
    // Don't forget to draw the bubbles!
    for (Bubble bubble : bubbles) {
      bubble.draw();
    }
  }

  /* Turns the given fish away from the mouse, and gives it
   a boost to its speed.
   */
  void scare() {
    float tapDir = atan2(mouseY-y, mouseX-x);
    dir = (int)(degrees(tapDir) + 180) % 360;
    boost = speed;
  }
  
  boolean isFacingRight() {
    int adir = abs(dir);
    return adir <= 90 || adir >= 270;
  }

  // I put this class inside the Fish one since it isn't used elsewhere.
  // Thus, a bubble accesses the fish parameters without needing a reference to it.
  class Bubble {
    int bx, by, bw, bh; // But we need a means to distinguish the bubble's variables from the fish's one
    int disp; // displacement

    Bubble (int b1, int b2, int b3, int b4) {
      bx = b1;
      by = b2;
      bw = b3;
      bh = b4;
    }

    void draw() { // Was drawBubble()
      fill(0, 200, 220, 120); // Green-blue with transparency
      // Use x and y from Fish
      int posX;
      if (isFacingRight()) {
        posX = x + w/2 + 5;
      } else {
        posX = x - w/2 - 5;
      }
      
      ellipse(posX + bx, y + by + disp, bw, bh);
      disp -= 1;
      if (disp < -25) {
        disp = 0; // Like a new bubble
        // For a more realistic effect, shift the bubble positions in the array...
      }
    }
  }
}

void setup() {
  size(800, 600); //feel free to change this, all the code will change relative to it
  frameRate(200);
  setConstants(); //initialize the tank size
  fishes = new Fish[10];
  for (int i = 0; i < fishes.length; i++) {
    fishes[i] = new Fish();
  }
}


/*The setConstants() method sets the size of the tank
 relative to the size of the canvas. If the canvas is
 too small the program exits with a warning message*/
void setConstants() {
  if (height < 250 || width < 200) {
    println("Sorry, needs a bigger canvas");
    exit();
  }
  TANK_LEFT = int(width*.15);
  TANK_RIGHT = width-int(width*.15);
  TANK_BOTTOM = height-100;
  TANK_TOP = height - TANK_BOTTOM;
  WATER_TOP = TANK_TOP + int((TANK_BOTTOM-TANK_TOP)*.2);
}

/*The draw method is the simulation loop of our program. It
 simply moves the fish, and then redraws the scene*/
void draw() {
  drawBackground();
  // Shortcut for :
  // for (int i = 0; i < fishes.length; i++) { Fish fish = fishes[i];
  // Use whatever form you want
  for (Fish fish : fishes) {
    fish.move();
    fish.draw();
  }
  drawForeground();
}

/*mousePressed() is an event handler called by Processing whenever
 the user clicks the mouse. If the location of the mouse is within
 the bounds of the aquarium's front face, a simulation of tapping
 the glass takes place. A circle is drawn around the mouse, and
 the fish speed away from the mouse*/
void mousePressed() {
  if (mouseX < TANK_RIGHT && mouseX > TANK_LEFT &&
    mouseY > WATER_TOP && mouseY < TANK_BOTTOM) {
    noFill();
    stroke(255);
    ellipse(mouseX, mouseY, 25, 25);

    for (Fish fish : fishes)
      fish.scare();
  }
}

/*drawBackground() organizes any background drawing that must
 be done*/
void drawBackground() {
  //wall
  background(128, 50, 50);
  //floor
  stroke(0);
  fill(100, 56, 0);
  rect(0, int(height*.7), width, int(height*.3));

  drawTable();
  drawAquariumBack();
}

/*The drawTable method draws a 3d table beneath where the
 fish tank will go*/
void drawTable() {
  //table legs
  stroke(0);
  fill(160, 116, 60); //shade
  //back left leg
  rect(TANK_LEFT, TANK_BOTTOM+50, 25, 15);
  triangle(TANK_LEFT+25, TANK_BOTTOM+50, TANK_LEFT+35, TANK_BOTTOM+50, TANK_LEFT+25, TANK_BOTTOM+65);
  //back right leg
  rect(TANK_RIGHT+40, TANK_BOTTOM-50, 25, 115);
  fill(200, 156, 100);  //unshaded
  quad(TANK_RIGHT+65, TANK_BOTTOM+65, TANK_RIGHT+75, TANK_BOTTOM+40, TANK_RIGHT+75, TANK_BOTTOM-100, TANK_RIGHT+65, TANK_BOTTOM-100);
  //front left leg
  rect(TANK_LEFT-50, TANK_BOTTOM+50, 25, 50);
  fill(160, 116, 60);
  quad(TANK_LEFT-25, TANK_BOTTOM+50, TANK_LEFT-15, TANK_BOTTOM+50, TANK_LEFT-15, TANK_BOTTOM+100, TANK_LEFT-25, TANK_BOTTOM+100);
  //front right leg
  fill(200, 156, 100);
  rect(TANK_RIGHT, TANK_BOTTOM+50, 25, 50);
  quad(TANK_RIGHT+25, TANK_BOTTOM, TANK_RIGHT+35, TANK_BOTTOM, TANK_RIGHT+35, TANK_BOTTOM+100, TANK_RIGHT+25, TANK_BOTTOM+100);

  //table top
  quad(TANK_LEFT-50, TANK_BOTTOM+25, TANK_LEFT+30, TANK_BOTTOM-100, TANK_RIGHT+75, TANK_BOTTOM-100, TANK_RIGHT+25, TANK_BOTTOM+25); //top
  rect(TANK_LEFT-50, TANK_BOTTOM+25, (TANK_RIGHT+25)-(TANK_LEFT-50), 25); //front
  quad(TANK_RIGHT+25, TANK_BOTTOM+25, TANK_RIGHT+75, TANK_BOTTOM-100, TANK_RIGHT+75, TANK_BOTTOM-75, TANK_RIGHT+25, TANK_BOTTOM+50); //side
}

/*drawAquariumBack draws the bottom, back, and left panes of
 the fish tank.*/
void drawAquariumBack() {
  //aquarium
  stroke(255);
  fill(255, 255, 255, 20); //faint white tint
  rect(TANK_LEFT+40, TANK_TOP-60, (TANK_RIGHT+25)-(TANK_LEFT+40), (TANK_BOTTOM-60)-(TANK_TOP-60));  //back
  quad(TANK_LEFT, TANK_BOTTOM, TANK_LEFT+40, TANK_BOTTOM-60, TANK_RIGHT+25, TANK_BOTTOM-60, TANK_RIGHT, TANK_BOTTOM); //bottom
  quad(TANK_LEFT, TANK_BOTTOM, TANK_LEFT+40, TANK_BOTTOM-60, TANK_LEFT+40, TANK_TOP-60, TANK_LEFT, TANK_TOP);//back-left
}

/*drawForeground organizes all the items that need to be drawn
 after the fish*/
void drawForeground() {
  drawWater();
  drawAquariumFront();
}

/*drawWater draws 3 panes of water on top of the fish to imitate
 a rectangular prism. Water is tinted translucent blue.*/
void drawWater() {
  noStroke();
  fill(50, 100, 255, 100); //translucent blue
  rect(TANK_LEFT, WATER_TOP, TANK_RIGHT-TANK_LEFT, TANK_BOTTOM-WATER_TOP); //front face
  quad(TANK_RIGHT, WATER_TOP, TANK_RIGHT+25, WATER_TOP-60, TANK_RIGHT+25, TANK_BOTTOM-60, TANK_RIGHT, TANK_BOTTOM); //right face
  stroke(0, 0, 56); //dark blue surface line
  quad(TANK_LEFT, WATER_TOP, TANK_LEFT+40, WATER_TOP-60, TANK_RIGHT+25, WATER_TOP-60, TANK_RIGHT, WATER_TOP);//top face
}

/*drawAquariumFront() draws the front and right panes of the aquarium*/
void drawAquariumFront() {
  //aquarium
  stroke(255);
  fill(255, 255, 255, 20);
  rect(TANK_LEFT, TANK_TOP, TANK_RIGHT-TANK_LEFT, TANK_BOTTOM - TANK_TOP);  //front
  quad(TANK_RIGHT, TANK_TOP, TANK_RIGHT+25, TANK_TOP-60, TANK_RIGHT+25, TANK_BOTTOM-60, TANK_RIGHT, TANK_BOTTOM);//front-right
  noFill();
  quad(TANK_LEFT, TANK_TOP, TANK_LEFT+40, TANK_TOP-60, TANK_RIGHT+25, TANK_TOP - 60, TANK_RIGHT, TANK_TOP); //top
}

