class gun{ //only guns that use bullets (or lasers that act like bullets)

  PImage sprite;
  PImage spriteU;
  PImage spriteD;
  Animation animR;
  Animation anumL;
  Animation animUR;
  Animation anumUL;
  Animation animDR;
  Animation animDL;

  //all guns are 10 pixels lower than the person, by left corner

  int rechargeFrames; //how many frames it takes for the gun to recharge
  int framesLeft; //holds the recharge time remaining after a shot. i.e. framesLeft = 0 means you can shoot, otherwise it's still recharging.
  Person p;
  int x; int y; //these are the coordinates of the barrel of the gun in relation to the top left corner of the Person sprite.

  //bullets[floor(level.width / rechargeFrames + 1)]; //holds all the bullets the gun has shot.

  //ArrayList bullets;

  gun(Person _p){ //TODO
    //bullets = new ArrayList();
    p = _p;

  }

  void show(){
    if(LookingRight){
      if(LookingDown && !Ground){image(spriteD, p.x, p.y+6);}
      else{
        if(LookingUp){image(spriteU, p.x+3, p.y-13);}
        else{image(sprite, p.x, p.y+10);}}}
    else{
      scale(-1, 1);
        if(LookingDown && !Ground){image(spriteD, p.x, p.y+5);}
        else{
          if(LookingUp){image(spriteU, p.x+2, p.y-13);}
          else{image(sprite, p.x, p.y+10);}}
    }
  }

}

class laser extends gun{

  laser(Person p){
    super(p);
    sprite = loadImage("Laser.png");
    spriteU = loadImage("Laserup.png");
    spriteD = loadImage("Laserdown.png");
  }
}

class purple extends gun{

  purple(Person p){
    super(p);
    sprite = loadImage("Purple.png");
    spriteU = loadImage("Purpleup.png");
    spriteD = loadImage("Purpledown.png");
  }

}

class shuriken extends gun{

  shuriken(Person p){
    super(p);
    sprite = loadImage("Shuriken.png");
    spriteU = loadImage("Shurikenup.png");
    spriteD = loadImage("Shurikendown.png");
  }

}

class lightning extends gun{

  lightning(Person p){
    super(p);
    sprite = loadImage("Lightning.png");
    spriteU = loadImage("Lightningup.png");
    spriteD = loadImage("Lightningdown.png");
  }

}

class machine extends gun{

  machine(Person p){
    super(p);
    sprite = loadImage("Machine.png");
    spriteU = loadImage("Machineup.png");
    spriteD = loadImage("Machinedown.png");
  }

}

class plasma extends gun{

  plasma(Person p){
    super(p);
    sprite = loadImage("Plasma.png");
    spriteU = loadImage("Plasmaup.png");
    spriteD = loadImage("Plasmadown.png");
  }

}

class sniper extends gun{

  sniper(Person p){
    super(p);
    sprite = loadImage("Sniper.png");
    spriteU = loadImage("Sniperup.png");
    spriteD = loadImage("Sniperdown.png");
  }

}

class grenade extends gun{

  grenade(Person p){
    super(p);
    sprite = loadImage("Grenade.png");
    spriteU = loadImage("Grenadeup.png");
    spriteD = loadImage("Grenadedown.png");
  }

}

class BFL extends gun{

  BFL(Person p){
    super(p);
    sprite = loadImage("BFL.png");
    spriteU = loadImage("BFLup.png");
    spriteD = loadImage("BFLdown.png");
  }

}

class bolt extends gun{

  bolt(Person p){
    super(p);
    sprite = loadImage("Bolt.png");
    spriteU = loadImage("Boltup.png");
    spriteD = loadImage("Boltdown.png");
  }
}

//class bullet{ //for the guns that use bullets
//
////TODO
//
//  int x, y;
//  PImage sprite;
//  int speed;
//
//  bullet(Person p, int gunType){ //TODO
//    switch(gunType){
//
//    }
//  }
//
//  drawBullet(){
//     image(sprite, x, y-sprite.height/2);
//  }
//
//  boolean hit(){
//    //TODO
//  }
//
//}
