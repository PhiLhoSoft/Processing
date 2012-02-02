//Shoots Bullets
class Bull{
  
  float x; 
  float y;
  int[] colorz={255, 255, 255};
  float angle = 0;
  float targetAngle=0;
  float speed=10;
  float dir = (angle - targetAngle) / TWO_PI;
  float xdir, ydir;
  int id;
  
  
  Bull(int idz, float angle){
    id=idz;
    x=theChar.loc.x;
    y=theChar.loc.y;
    targetAngle += dir;
    int i=int(random(3));
    colorz[i]=0;  
    xdir=cos(targetAngle)*speed;
    ydir=sin(targetAngle)*speed;  
  }

//shoots bullets from the hero  
  void Shoot(){
    x+=xdir;
    y+=ydir;
    if(x>width || x<0 || y>height || y<0){
      Bullet[id]=null;
    }
  }

//Draw Bullets
  void drawBullet(){
  pushMatrix();
  translate(x, y);
  rotate(targetAngle);
  tint(colorz[0], colorz[1], colorz[2]);
  image(shotImg, 0, 0, 20, 12);
  popMatrix();
  noTint();
  }
}


