// by blindfish
// http://processing.org/discourse/yabb2/YaBB.pl?num=1243835922/0#3
boolean left, right, up, down;

int x,y;
void setup()
{
 size(400,400);
 x=width/2;
 y=height/2;
}

void draw()
{
 background(255);
 if (up) {
   y -=5;  
 }
 else if (down) {
   y +=5;  
 }
 if (left) {
   x -= 5;  
 }
 else if (right) {
   x +=5;  
 }
 ellipse(x,y,20,20);
}

void keyPressed() {
 if (key == CODED)
 {
   if (keyCode == UP) {
     up = true;
   }
   else if (keyCode == DOWN) {
     down = true;
   }
   else if (keyCode == LEFT) {
     left = true;
   }
   else if (keyCode == RIGHT) {
     right= true;
   }
 }
}

void keyReleased() {
 if (key == CODED)
 {
   if (keyCode == UP) {
     up = false;
   }
   else if (keyCode == DOWN) {
     down = false;
   }
   else if (keyCode == LEFT) {
     left = false;
   }
   else if (keyCode == RIGHT) {
     right= false;
   }
 }
} 

