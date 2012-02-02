//This draws the hero character
class Charact {
  PVector loc;
  float x;
  float y;
  float speed = 6;
  float angle = 0;
  float targetAngle = 0;
  float easing = 0.05f;
  int alive=1;
  
  Charact(){
     loc=new PVector(width/2, height/2);  
  }
  
//Hero ship  
void drawHero(){
  //Rotates Character 
  angle = atan2( mouseY - y, mouseX - x);
  float dir = (angle - targetAngle) / TWO_PI;
  dir -= round(dir);
  dir *= TWO_PI;
  targetAngle += dir;
  
//Draw Character
  pushMatrix();  
  translate(loc.x, loc.y);
  rotate(targetAngle);
  image(player, 0, 0);
  popMatrix();
}

void run(){
   if(alive>1){
      alive--;
    }
    
    if(frameCount%3==0){
      for(int j=0; j<=power; j++){
     for(int i=1; i<200; i++){
       if(Bullet[i]==null){
         Bullet[i]=new Bull(i, targetAngle-(power*.05));
         i=201;
       }
     }
      }
    }
    
//  for(int i=0; i<maxEnemies; i++){
//    if(bad[i]!=null){
//      if(abs(bad[i].loc.x-loc.x)<bad[i].Size.x && abs(bad[i].loc.y-loc.y)<bad[i].Size.y){
//      lives--;
//      playerDie.trigger();
//      alive=100;
//      if(lives==-1){
//        mode.reset();
//      }
//      }
//    }
//  }
}
     
//Key Press 
void update(){
        if(keyPressed){
            if(key == CODED){
                switch(keyCode){
                case UP:
                    y -= speed;
                    break;        
                case DOWN:
                    y += speed;
                    break;        
                case LEFT:
                    x -= speed;
                    break;
                case RIGHT:
                    x += speed;
                    break;   
                }
            }
        }
}
}




