class Fade{
  int dtime;
  int stime;
  int newMode=0;
  int fadeSpeed;
  
  Fade(int nmode, int fs){
    newMode=nmode;
    fadeSpeed=fs;
    dtime=stime=255;
}
  
  void run(){

    dtime-=fadeSpeed;
    if(dtime<=0){
      changeMode(newMode);
      fadeSpeed=-fadeSpeed;
    }
     if(dtime>stime){
      fader=null;
    }
 }
 
 void display(){
    pushMatrix();
    translate(width/2, height/2);
    pushStyle();
    fill(0, 255-dtime);
    rect(0, 0, width, height);
    popStyle();
    popMatrix();
 }
}

class Wipe extends Fade{
   
  Wipe(int nmode, int fs){
  super(nmode, fs);
  }
    void display(){
    pushMatrix();
    translate(width/2, height/2-(dtime*2));
    pushStyle();
    fill(0);
    rect(0, 0, width, height+15);
    popStyle();
    popMatrix();
 }
}
  
//changes modes
void changeMode(int md){
  switch(md){
    case 0:
    mode=new Title();
    
    break;
    case 1:
    mode=new Main();
    
    break;
    case 2:
    mode=new Winner();

    break;
    case 3:
    mode=new gameOver();
    break;
    case 4:

    break;
  }
}


