class Creatures {
  
  final int walkingFrames = 6;
  int x,y;
  float ySpeed;
  float maxYspd;
  int personFrame;
  final int SpriteHeight = 35;
  Planet p;

  Creatures(int _x, int _y) {
    x = _x;
    y = _y;
    ySpeed = 0;
    maxYspd = 12;
    personFrame = 0;
    p = new Planet(1);
  }
  
  void update() {
    //lol physics
    
    //This chunk tells the person when to fall. If he is falling and there is ground beneath him, say he's grounded, and stop his movement.
    //After that, he's either grounded, jumping, or falling through empty air, so make him do whatever, and worry about collissions later.
    if(x > 0 && x < lcol.width && y > 0 && y+SpriteHeight < lcol.height){
      if(lcol.pixels[x + (y+SpriteHeight) * lcol.width] == color(0) && ySpeed <= 0){
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
    }
    
    //Makes sure he can jump.
    if(Jumping && Ground){
      ySpeed = 7;
    }
    if(-ySpeed > maxYspd){ySpeed = -maxYspd;} //Makes sure he doesn't surpass the planet's terminal velocity
    
    //Moving right is constant, so there does not need to be velocities.
    if(MovingRight){x+=3;}
    if(MovingLeft){x-=3;}
    personFrame = (personFrame+1) % walkingFrames; //This keeps track of what frame of walking he's in, and accounts for different amounts of frames in animations.
    // NOTE: The largest animtion length should be divisible by all smaller animation lengths.
    show(); //Show the person.
  }
  
  void show() {
    
  }
}
