color a = color(5,40,255);
color b = color(64,90,252);
color c = color(133,149,252);
float d = (1);
float e = (5);
float f = (10);
float g = (100);
float h = (0.0175);
 

void setup()
{
size(500, 500);
smooth();
background(0);
 
};



void draw()
{
 
 
  strokeWeight(h);
  frameRate(g);
 
  if(mousePressed && (mouseButton == LEFT)){
   
 a = color(252,0,63);
 b = color(227,94,127);
 c = color(255,211,222);
  } else if(mousePressed && (mouseButton == RIGHT))
  { 
 a = color(176, 227, 169);
 b = color(100,193,88);
 c = color(28,255,0);
  } else {
 a = color(5,40,255);
 b = color(64,90,252);
 c = color(133,149,252);
  }
 
  if (frameCount % 0.5 == 0)
  {
  
  pushMatrix();
  translate(250, 250);
  rotate(radians(frameCount/d % 360));
  line(0, 0, 0, 100);
  stroke(a);
  popMatrix();
 
  pushMatrix();
  translate(250, 250);
  rotate(radians(frameCount/e % 360));
  line(0,0,75,0);
  stroke(b);
  popMatrix();
 
  pushMatrix();
  translate(250, 250);
  rotate(radians(frameCount/f % 360));
  line(0,50, 0, 0);
  stroke(c);
  popMatrix();

pushMatrix();
  translate(250, 250);
  rotate(radians(frameCount/e % 360));
 
  pushMatrix();
  translate(75, 0);
  rotate(radians(frameCount/d % 360));
  line(0, 0, 0, 100);
  stroke(a);
  popMatrix();
 
  pushMatrix();
  translate(75, 0);
  rotate(radians(frameCount/e % 360));
  line(0,0,75,0);
  stroke(b);
  popMatrix();
 
  pushMatrix();
  translate(75,0);
  rotate(radians(frameCount/f % 360));
  line(0,50, 0, 0);
  stroke(c);
  popMatrix();
popMatrix();
 
pushMatrix();
  translate(250, 250);
  rotate(radians(frameCount/f % 360));
 
    pushMatrix();
  translate(0, 50);
  rotate(radians(frameCount/d % 360));
  line(0, 0, 0, 100);
  stroke(a);
  popMatrix();
 
  pushMatrix();
  translate(0, 50);
  rotate(radians(frameCount/e % 360));
  line(0,0,75,0);
  stroke(b);
  popMatrix();
 
  pushMatrix();
  translate(0,50);
  rotate(radians(frameCount/f % 360));
  line(0,50, 0, 0);
  stroke(c);
  popMatrix();
popMatrix(); 
  pushMatrix();
   
    translate(250, 250);
    rotate(radians(frameCount/d % 360));
   
    pushMatrix();
    translate(0, 100);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
 
 pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/d % 360));
  
   pushMatrix();
   
    translate(0, 100);
    rotate(radians(frameCount/d % 360));
   
    pushMatrix();
    translate(0, 100);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();
 
   pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/e % 360));
  
   pushMatrix();
   
    translate(75,0);
    rotate(radians(frameCount/e % 360));
   
    pushMatrix();
    translate(75,0);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(75,0);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(75,0);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();
   

 
   pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/f % 360));
  
   pushMatrix();
   
    translate(0,50);
    rotate(radians(frameCount/f % 360));
   
    pushMatrix();
    translate(0,50);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(0,50);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(0,50);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();

   pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/d % 360));
  
   pushMatrix();
   
    translate(0,100);
    rotate(radians(frameCount/e % 360));
   
    pushMatrix();
    translate(75,0);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(75,0);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(75,0);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();

pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/d % 360));
  
   pushMatrix();
   
    translate(0,100);
    rotate(radians(frameCount/f % 360));
   
    pushMatrix();
    translate(0,50);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(0,50);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(0,50);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();
 
pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/e % 360));
  
   pushMatrix();
   
    translate(75,0);
    rotate(radians(frameCount/f % 360));
   
    pushMatrix();
    translate(0,50);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(0,50);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(0,50);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();

pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/e % 360));
  
   pushMatrix();
   
    translate(75,0);
    rotate(radians(frameCount/d % 360));
   
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();

pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/e % 360));
  
   pushMatrix();
   
    translate(75,0);
    rotate(radians(frameCount/d % 360));
   
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();

pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/f % 360));
  
   pushMatrix();
   
    translate(0,50);
    rotate(radians(frameCount/d % 360));
   
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(0,100);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();



pushMatrix();
   translate(250,250);
   rotate(radians(frameCount/f % 360));
  
   pushMatrix();
   
    translate(0, 50);
    rotate(radians(frameCount/e % 360));
   
    pushMatrix();
    translate(75,0);
    rotate(radians(frameCount/d % 360));
    line(0, 0, 0, 100);
    stroke(a);
    popMatrix();
 
    pushMatrix();
    translate(75,0);
    rotate(radians(frameCount/e % 360));
    line(0,0,75,0);
    stroke(b);
    popMatrix();
 
    pushMatrix();
    translate(75,0);
    rotate(radians(frameCount/f % 360));
    line(0,50, 0, 0);
    stroke(c);
    popMatrix();
  popMatrix();
popMatrix();
}
};
