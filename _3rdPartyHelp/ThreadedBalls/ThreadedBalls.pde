// http://forum.processing.org/topic/strange-comportment-of-threads

Balle[] balles = new Balle[100];
int fond=155;

void setup() {
  size(200,300);
  background(fond);
  ellipseMode(RADIUS);
  noStroke();
  noSmooth();

  for (Balle ball : balles) {
    ball = new Balle(0, 0, int(random(5, 20)), int(random(2, 20)),
        color(random(0, 255), random(0, 255), random(0, 255)));
    ball.start();
  } 
}

void draw(){

}



class Balle extends Thread{ 
  int X;
  int dx;
  int Y;
  int dy;
  int r;
  int v;
  color couleur;
 
Balle (int x,int y,int ra,int vi,color c){
  X=x;
  Y=y;
  dx=1;dy=1;
  r=ra;
  v=vi;
  couleur=c;
} 

void start(){
  super.start();
}

 
void run(){
  while (X<2000){
    Efface(X, Y);
    Deplace();
    Dessine(X, Y);
    try {
        sleep((long)(100/v));
      } catch (Exception e) {
      }
  }
} 

void Efface(int x, int y) {
  synchronized (g) {
    fill(fond);
    ellipse(x,y,r,r);
  }
} 

void Dessine(int x, int y) {
  synchronized (g) {
    fill(couleur);
    ellipse(x,y,r,r);
  }
} 
 
void Deplace(){
  X += dx;
  Y += dy;
  if (X+r>width)dx=-1;
  if (X<r)dx=1;
  if (Y+r>height)dy=-1;
  if (Y<r)dy=1;
}
 
}

