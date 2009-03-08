//Containers
Being [] beings;

final color zombie = color(0,255,0);
final color dead = color(0,128,0);
final color human = color(200,120,255);
final color panicHuman = color(255,0,0);
final color wall = color(0,0,0);
final color nothing = color(1,1,1);

//Controlling Vars
final int numZombies = 100;
final int numHumans = 3000;
final int decayAge = 200;
int totalBeings;

boolean bNoHumans, bNoZombies;

void setup() {
  size(200, 200);
//  noStroke();
  frameRate(20);

  totalBeings = numZombies + numHumans;

  beings = new Being[totalBeings];

  //Create Zombies then Humans
  for(int i = 0; i < totalBeings; i++) {
    beings[i] = new Being(i < numZombies); //True = isZombie
  }
}

void draw() {
  
  loadPixels();
  background(0);
  //println(frameRate);
  int humanNb = 0, zombieNb = 0, deadNb = 0, panicNb = 0;
  for(int i = 0; i < totalBeings; i++) {
    beings[i].exist();
    if (beings[i].isZombie) {
      if (beings[i].age > 0) zombieNb++; else deadNb++;
    } else {
      humanNb++;
      if (beings[i].panic > 0) panicNb++;
    }
  }
  if (frameCount % 100 == 0 && !bNoHumans && !bNoZombies) {
    println(humanNb + " (" + panicNb + ") " + " - " +
        zombieNb + " (" + deadNb + ") " + " => " + (humanNb + zombieNb));
  }
  if (humanNb == 0 && !bNoHumans) { println("No more humans!"); bNoHumans = true; }
  if (zombieNb == 0 && !bNoZombies) { println("No more zombies!"); bNoZombies = true; }
}

class Being {

  //State
  boolean isZombie;
  int age = decayAge;
  int x, y;
  int dir; //1 = up, 2 = right, 3 = down, 4 = left
  int panic = 0;

  //Controlling vars
  final int panicTurns = 5;
  final int mass = 5;
  final int distance = 10;


  Being(boolean isZombie) {
    this.isZombie = isZombie;

    x = (int)random(width)+1;
    y = (int)random(height)+1;
    dir = (int)random(4) + 1;
  }

  //The main loop for the zombie/human.
  void exist() {
    checkState();
    updatePosition();
    apply();
  }

  //This function updates the being's state vars depending on if the being is a zombie or a human
  void checkState() {
    if(isZombie) {
      if (age > 0) {
        fill(zombie);
        stroke(zombie);
      } else {
        fill(dead);
        stroke(dead);
      }
    } else if(panic > 0) {
      fill(panicHuman);
      stroke(panicHuman);
    } else {
      fill(human);
      stroke(human);
    }
  }

  void updatePosition() {
    if (age == 0) return;

    int r = (int)random(10);
    if((!isZombie && panic>0) || r < 3) {
      //update position
      if(look(x,y,dir,1)==nothing) {
        if(dir==1) y--;
        else if(dir==2) x++;
        else if(dir==3) y++;
        else if(dir==4) x--;
      }
      else {
        dir = (int)random(4)+1;
      }

      if(panic>0) panic--;
    }

    int target = look(x,y,dir,distance);

    if(isZombie) {

      //Look around!
      if (!isHuman(target)) { // If human, continue in this direction to reach him
        if (target != nothing || (int)random(5) == 1) {
          dir = (int)random(4)+1;
        }
      }

      int ix = x, iy = y;
      switch (dir) {
        case 1: iy--; break;
        case 2: ix++; break;
        case 3: iy++; break;
        case 4: ix--; break;
      }

      //Infect something?!
      if(isHuman(look(x,y,dir,1))) {
        for(int i=0; i<totalBeings; i++) {
          beings[i].infect(ix,iy);
        }
      }
      age--;

    } else { //Is I human?!

      //Oh Noes!  Look for zombies!
      if(target == zombie) {
        panic = panicTurns; //println("Argh!");
        //Run away!
        dir += 2;
        if(dir>4) dir -= 4;
      } else if(target == nothing) {
         if ((int)random(8) == 1) dir = (int)random(4)+1;
      } else dir = (int)random(4)+1;
    }
  }

  color look(int x, int y, int dir, int dist) {
    int xpos = x;
    int ypos = y;
    for(int i = 0; i < dist; i++) {
      switch (dir) {
        case 1: ypos--; break;
        case 2: xpos++; break;
        case 3: ypos++; break;
        case 4: xpos--; break;
      }

      if(xpos>width-1 || xpos<1 || ypos>height-1 || ypos<1) return wall;
      else
      {
        int target = pixels[xpos + ypos * width];
        if(target == human) return human;
        else if(target == panicHuman) return panicHuman;
        else if(target == zombie) return zombie;
      }
    }
    return nothing;
  }

  void infect(int ix, int iy) {
    if(x == ix && y == iy && !isZombie) {
      isZombie = true; //println("Infected!");
    }
  }

  boolean isHuman(int target) {
    return target == human || target == panicHuman;
  }

  void apply() {
    //ellipse(x,y,5,5);
    point(x,y);
  }
}
