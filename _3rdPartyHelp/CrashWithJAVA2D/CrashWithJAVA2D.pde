// This sketch crashes the JVM, except in some cases!
// http://processing.org/discourse/yabb2/YaBB.pl?num=1264911247
// http://forum.processing.org/topic/null-pointer-exception-calling-image-on-pgraphics

PGraphics buffer;
float val=0;

void setup()
{
  size(800, 600);
  background(0);
  
  buffer = createGraphics(width, height, JAVA2D); 
}

float angle;
float cosine;

void draw()
{
  //Fade everything which is drawn
  noStroke();
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
  
  //Draw ellipses
  val+= 10;
  stroke(196, 5, 23);     //Stroke Color of the ellipse and rectangle/red
  noFill();               // No fill color for the ellipse

  pushMatrix();
  translate(mouseX, mouseY);
  ellipseMode(CENTER);
  rotate(val);
  ellipse(0, 0, 100, 200);
  popMatrix();

  //Draw rectangles in a buffer so they don't get faded
  if (second() % 2 == 0)
  {
    cosine = cos(val);
    
    buffer.beginDraw();
    buffer.stroke(196,5,23); 
    buffer.noFill();
    buffer.translate(mouseX, mouseY);
    buffer.rotate(cosine);  
    buffer.translate(width/2, height/2);
    //Translating the the width and height, distance the rect. spins away from ellipse. 
    buffer.rectMode(CENTER);
    buffer.rect(0, 0, 115, 115);
    buffer.endDraw();
  }

  image(buffer, 0, 0); // NPE on System.arraycopy here (P.v.1.5)
}

