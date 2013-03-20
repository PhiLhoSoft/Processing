class Person {
  
  final int walkingFrames = 6;
  int x,y;
  float ySpeed;
  int personFrame;
  final int SpriteHeight = 35;
  final int SpriteWidth = 20;
  Planet p;
  bolt g;
  gun[] guns;
  boolean[] inventory;
  
  //all these are WITHOUT gun
  Animation StandingR = new Animation("Mainstandempty_", 1, true);
  Animation StandingL = new Animation("Mainstandempty_", 1, false);
  Animation WalkingR = new Animation("Mainwalkempty_", 6, true); //neutral right
  Animation WalkingL = new Animation("Mainwalkempty_", 6, false); //neutral left
  Animation JumpingR = new Animation("Mainjumpempty_", 1, true); //neutral jumping right
  Animation JumpingL = new Animation("Mainjumpempty_", 1, false); //neutral jumping left
  
  //all these are WITH gun
  Animation StandingRG = new Animation("Mainstandgun_", 1, true);
  Animation StandingLG = new Animation("Mainstandgun_", 1, false);
  Animation StandingRUG = new Animation("Mainstandup_", 1, true);
  Animation StandingLUG = new Animation("Mainstandup_", 1, false);
  Animation WalkingRG = new Animation("Mainwalkgun_", 6, true);
  Animation WalkingLG = new Animation("Mainwalkgun_", 6, false);
  Animation WalkingRUG = new Animation("Mainwalkup_", 6, true); //shooting up
  Animation WalkingLUG = new Animation("Mainwalkup_", 6, false); //shooting up
  Animation JumpingRG = new Animation("Mainjumpgun_", 1, true);
  Animation JumpingLG = new Animation("Mainjumpgun_", 1, false);
  Animation JumpingRDG = new Animation("Mainjumpdown_", 1, true); //shooting down
  Animation JumpingLDG = new Animation("Mainjumpdown_", 1, false); //shooting down
  Animation JumpingRUG = new Animation("Mainjumpup_", 1, true); //shooting up
  Animation JumpingLUG = new Animation("Mainjumpup_", 1, false); //shooting up
  
  Person(){
    x = 50;
    y = 10;
    ySpeed = 0;
    personFrame = 0;
    p = new Planet(1);
    g = new bolt(this);
    
  }
  
  Person(int _x, int _y ) {
    x = _x;
    y = _y;
    ySpeed = 0;
    personFrame = 0;
  }
  
  int collision(){
    if(x>0 && x+SpriteWidth < lcol.width && y > 0 && y+SpriteHeight < lcol.height){
      for(int j = y; j < y+SpriteHeight; j++){
        for(int i = x; i < x+SpriteWidth; i++){
          if(lcol.pixels[i + j * lcol.width] == color(0)){
            return y + SpriteHeight - j;
          }
        }
      }
      return 0;
    }
    if(x>0 && x+SpriteWidth < lcol.width && y+SpriteHeight < lcol.height){
      return 0;
    }
    return 2;
  }
  
  void update() {
    //lol physics
    
    //This chunk tells the person when to fall. If he is falling and there is ground beneath him, say he's grounded, and stop his movement.
    //After that, he's either grounded, jumping, or falling through empty air, so make him do whatever, and worry about collissions later.
    if(x > 0 && x < lcol.width && y > 0 && y+SpriteHeight < lcol.height){
      if((lcol.pixels[x + (y+SpriteHeight) * lcol.width] == color(0) && ySpeed <= 0)){
        Ground = true;
        ySpeed = 0;
      }else{
        Ground = false;
        ySpeed -= p.gravity();
        y -= ySpeed;
      }
    }else{ //This is in case he's off the screen, just make him fall.
      ySpeed -= p.gravity();
      y -= ySpeed;
    }
    
    //This chunk says that when he's inside an object, just make him rise until he's not.
    if(x > 0 && x < lcol.width && y > 0 && y+SpriteHeight < lcol.height){
      if(lcol.pixels[x + (y+SpriteHeight-1) * lcol.width] == color(0) && Ground){
        while(lcol.pixels[x + (y+SpriteHeight-1) * lcol.width] == color(0) && Ground){
          y--;
        }
        ySpeed = 0;
      }
//      if(collision() <= 3 && collision() != 0){
//        y--;
//        ySpeed = 0;
//      }
    }
    
    //Makes sure he can jump.
    if(Jumping && Ground){
      ySpeed = p.jump();
    }
    if(-ySpeed > p.airResistance()){ySpeed = -p.airResistance();} //Makes sure he doesn't surpass the planet's terminal velocity
    
    //Moving right is constant, so there does not need to be velocities.
    if(MovingRight){
      x+=3;
      if(collision() > 7){
        x -= 3;
      }
    }
    if(MovingLeft){
      x-=3;
      if(collision() > 7){
        x += 3;
      }
    }
    
    personFrame = (personFrame + 1) % walkingFrames; //This keeps track of what frame of walking he's in, and accounts for different amounts of frames in animations.
    // NOTE: The largest animtion length should be divisible by all smaller animation lengths.
    show(); //Show the person.
    g.show();
  }
  
  void show() {
    if(xMoving || Ground == false){
      if(HasGun == false){
        if(Ground == true && LookingLeft == true){WalkingL.display(x, y, personFrame);}
        if(Ground == true && LookingRight == true){WalkingR.display(x, y, personFrame);}
        if(Ground == false && LookingLeft == true){JumpingL.display(x, y, personFrame);}
        if(Ground == false && LookingRight == true){JumpingR.display(x, y, personFrame);}
      }else{ //Has a gun
        if(Ground == true){
          if(LookingRight == true){
            if(LookingUp == false){WalkingRG.display(x, y, personFrame);}
            else{WalkingRUG.display(x, y, personFrame);}
          }else{
            if(LookingUp == false){WalkingLG.display(x, y, personFrame);}
            else{WalkingLUG.display(x, y, personFrame);}
          }
        }else{
          if(LookingLeft == true){
            if(LookingDown == false && LookingUp == false){JumpingLG.display(x, y, personFrame);}
            if(LookingDown == true){JumpingLDG.display(x, y, personFrame);}
            if(LookingUp == true){JumpingLUG.display(x, y, personFrame);}
          }
          if(LookingRight == true){
            if(LookingDown == false && LookingUp == false){JumpingRG.display(x, y, personFrame);}
            if(LookingDown == true){JumpingRDG.display(x, y, personFrame);}
            if(LookingUp == true){JumpingRUG.display(x, y, personFrame);}
          }
        }
      }
    }else{
      if(HasGun == true){
        if(LookingUp == true){
          if(LookingRight == true){StandingRUG.display(x, y, personFrame);}
          else{StandingLUG.display(x, y, personFrame);}
        }else{
          if(LookingRight == true){StandingRG.display(x, y, personFrame);}
          else{StandingLG.display(x, y, personFrame);}
        }
      }else{
        if(LookingRight == true){StandingR.display(x, y, personFrame);}
        else{StandingL.display(x, y, personFrame);}
      }
    }
  }
}
