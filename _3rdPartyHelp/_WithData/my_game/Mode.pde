//all modes are here(title, gameplay, game over)
class Mode{
  int killed=0;
  int quota=15;

  void run(){
  background(0);
  mouse();
  }
  
  void mouse(){
  }
   
  void reset(){
    if(score>highScore){
      highScore=score;
    }
      score=0;
      wave=1;
      power=0;
      lives=1;
      fader=new Fade(3, 10);
  } 
}

class Title extends Mode{
  PImage title;
  int xpos=640;
  Title(){
    BG=loadImage("BG.png");
    title=loadImage("title.png");
  }
  
//writes click to start above image  
void run(){
  super.run();
  pushMatrix();
  translate(width/2, height/2);
  image(BG, 0, 0);
  translate(0, 200);
  pushStyle();
  textFont(font);
  textSize(32);
  fill(255, 255);
  text("Click to Start", 0, 0);
  popMatrix();

//writes highest score
  pushMatrix();
  translate(xpos, 30);
  fill(200, 0, 255, 100);
  String hs="Highest Score: "+highScore;
  text(hs, 0, 0);
  stroke(200, 0, 255, 100);
  strokeWeight(3);
  popMatrix();
  line(0, 5, width, 5);
  line(0, 40, width, 40);
 
  xpos-=4;
  if(xpos<-textWidth(hs)){xpos=width;}
    popStyle();
  }
}
//writes the text 
  void run(){
   pushStyle();
   textSize(20);
   fill(200, 0, 200);
   text("Ship fires automatically, use arrow keys to move", 40, height-50);
   text("Destroy all UFO", 40, height-20);
   popStyle();
  }

class Main extends Mode{
  int measure=1; //quota increase multiplier
  float time=100-(8*wave);


//writes start and then goes away
  int numMade=0;
  String mtext="START!";
  Main(){
      bad = new Villain[maxEnemies]; 
      theChar.loc.set(width/2, height/2, 0);   
  }
  
  void run(){
  background(0);
  image(BG, width/2, height/2);
  mouse();
  textFont(font);
  textSize(tsize);
  if(tsize>2){
  String startText=mtext;
  text(startText, width/2-textWidth(startText)/2, height/2);
  tsize*=.98;
  }
  countShots();
  for(int i=0; i<maxEnemies; i++){
    if(bad[i]!=null){
       bad[i].drawVillan();
       bad[i].run();     
    }
  }
    for(int i=0; i<200; i++){
    if(Bullet[i]!=null){
      Bullet[i].drawBullet();
      Bullet[i].Shoot();
  }
    }
    //writes score at top and the points you get
  pushStyle();
  pushMatrix();
  translate(width/2, 12);
  fill(0);
  textSize(22);
  stroke(200, 0, 255);
  rect(0, 0, width, 24);
  noStroke(); fill(255);
  String scoreString="SCORE:"+score;
  translate(-width/2+20, 8);
  text(scoreString, 0, 0);
  stroke(200, 0, 200);
  line(175, -30, 175, 4);
  
  //writes P1 at top 
  translate(20, 0);
  line(0, -30, 0, 4);
  P1Font.load();
  translate(20, 0);
  text("P", 0, (P1Font.cSize-22)/2);
  translate(20, 0);
  for(int i=0; i<=power; i++){
  text("l", i*6, (P1Font.cSize-22)/2);
  }
  
  normalFont.load();
  stroke(200, 0, 200);
  translate(60, 0);
  line(0, -30, 0, 4);
  fill(0, 255, 0);
  
  translate(106, -8);
  for(int i=0; i<lives; i++){
    image(player, i*12, 0, 18, 18);
  }
  popMatrix();
  popStyle();
  }
  }
  
class Winner extends Mode{
  int checkDie=120;
  Winner(){
  BG=loadImage("winner.png");
}

void run(){
    super.run();
      pushMatrix();
  translate(width/2-1, height/2);
  image(BG, 0, 0, width, height);
  popMatrix();
  checkDie--;
  if(checkDie==0){
    fader=new Fade(0, 10);
  }
}
}
  
class gameOver extends Mode{
int dtime=120;
gameOver(){
      BG=loadImage("Gameover.png");
}

 void run(){
    super.run();
      pushMatrix();
  translate(width/2-1, height/2);
  image(BG, 0, 0, width, height);
  popMatrix();
  dtime--;
  if(dtime==0){
    fader=new Fade(0, 10);
  }
     }
}



