//font style for words 
class FontStyle{
  PVector myColor;
  float tSize, cSize;
  int isLine;
  int isFill;
  float dtime;
  color cColor;
  
  FontStyle(int xx, int yy, int zz, int tS, int iL, int iF){
    myColor=new PVector(xx,  yy, zz);
    tSize=tS;
    isLine=iL;
    isFill=iF;
    dtime=0;
    cColor=color(255,255,255);
    cSize=tSize;
  }
  
  void load(){

if(dtime>0){
  dtime--;}
  cColor=color(myColor.x+dtime*6, myColor.y+dtime*6, myColor.z+dtime*6);
  cSize=tSize+dtime;
    if(isLine==1){
      stroke(cColor);
    }
    else{
      noStroke();
    }
    if(isFill==1){
      fill(cColor);
    }
    else {noFill();
    }
      textSize(cSize);
  }
}
