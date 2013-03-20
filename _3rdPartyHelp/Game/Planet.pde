class Planet { //this is just a Planet object that we can initialize that holds variables that change from planet to planet.

//this class should be self-exPLANETory. Hee hee :3

  int Gravity;
  int maxYspeed;
  int jumpSpeed;
  
  Planet(int number){
    switch(number){
      case 1: //Earth
        Gravity = 1;
        maxYspeed = 12;
        jumpSpeed = 7;
        break;
    }
  }
  
  int jump(){
    return jumpSpeed;
  }
  
  int airResistance(){
    return maxYspeed;
  }
 
  int gravity(){
    return Gravity;
  }
  
}
