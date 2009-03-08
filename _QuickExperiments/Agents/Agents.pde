int numAgente= 42;
 
Agente[] arreglo = new Agente[numAgente];
 
void setup(){
  size(800,700);
  smooth();
  noStroke();
  background(238, 282, 299);
  for (int i=0; i<numAgente; i++){
    arreglo[i] = new Agente(i);
  }
}
 
void draw(){
  background(238, 282, 299);
  for (int k=0; k<numAgente; k++){
    arreglo[k].mueve();
  }
  for (int k=0; k<numAgente; k++){
    arreglo[k].check();
  }
  for (int k=0; k<numAgente; k++){
    arreglo[k].dibuja();
  }
}
 
class Agente{
float x= random(800);
float y= random(700);
float moviemiento =  random(20) - 10;
float moviemientodos =  random(20) - 10;
color coloryo;
int rank;

Agente(int i) { rank = i; }
   
void mueve(){
  // x = x + movimiento;
  x = x + random(20) - 10;
  y = y +  random(20) - 10 ;
}

void check(){
  int collisionCount = 0;  
  for (int i=0; i<numAgente; i++){
    if ( i != rank){
      float dista = dist(arreglo[i].x, arreglo[i].y, x, y);
      if (dista < 60){
        collisionCount++;  
      }
    }
  }
  if (collisionCount >= 2) {
    coloryo = color(222, 40, 0);
  } else if (collisionCount == 1) {
    coloryo = color(222, 240, 0);
  } else {
    coloryo = color(2, 40, 0);
  }
}
   
void dibuja(){
  fill(24, 88,99, 54);
  ellipse(x, y , 60, 60);
  fill(coloryo);
  ellipse(x , y ,15,15);
}
} 

