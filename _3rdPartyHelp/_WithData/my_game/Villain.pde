//Draws the Ufo 
class Villain{
  PVector loc;
  float xv = width/2;
  float yv = height/2;
  float speed = 5;
  float xmove;
  float ymove;
  float angle;
  int id;
  float health=1;
  float maxHealth;

//randomly moves th Ufo
Villain(int idz){
 maxHealth=health;
 id=idz;
 angle = random(TWO_PI);
 xmove = cos(angle);
 ymove = sin(angle);
 loc=new PVector(xv, yv, 0);
}

//Villan UFO
void drawVillan(){
  pushMatrix();  
  translate(loc.x, loc.y);
  image(enemy, 0, 0);
  popMatrix();
}

//UFO moving 
void updateVillan(){ 
  xv += xmove * speed;
  yv += ymove * speed;

    speed *= 1;

  if(xv < 0 || xv > width){
    xmove = -xmove;
    xv = constrain(xv, 0, width);
}
  if(yv < 0 || yv > height){
    ymove = -ymove;
    yv = constrain(yv, 0, height);
}
}

void run(){
   for(int i=0; i<currentShots; i++){ //run through the current shot list, and check for collisions
      if(Bullet[i]!=null){
        if(abs(Bullet[i].x-loc.x)<20 && abs(Bullet[i].y-loc.y)<20){
          }
          health--;
          Bullet[i]=null;
          i=201;
          checkDie();
        }
    }
}

void checkDie(){ //check to make sure enemy is still alive
          if(health<=0){
          bad[id]=null;
          score+=100;
          mode.killed++;
         if(mode.killed>=mode.quota) {//check that all enemies in level are dead        
        }
    }
}
}


