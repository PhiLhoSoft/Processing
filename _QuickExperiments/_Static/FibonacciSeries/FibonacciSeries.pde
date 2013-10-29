import processing.pdf.*;

void setup() 
{
  size(1500, 500);
  
  beginRecord(PDF, "FibonacciSeries.pdf"); 
  
  background(255);
  smooth();
  noLoop();
  noStroke();
  
  PFont f = createFont("Verdana", 10);
  textFont(f);
  
  final int RECT_HEIGHT = 35;
  final int MARGIN = 10;
  int c = 1, p = 1;
  float posX = 0;
  float posY = 100;
  for (int i = 0; i < 11; i++)
  {
    float w = 25 * sqrt(c);
    println(c + "\t" + nf(w, 1, 1));
    
    fill(100 + w, 255 - w / 2, 100);
    rect(MARGIN + posX, MARGIN, w, w);
    rect(MARGIN, posY, 10 * c, RECT_HEIGHT);
    
    fill(0);
    textSize(15 + c / 2);
    text(c, MARGIN + posX + (w - textWidth(str(c))) / 2, MARGIN + (w + textAscent() - textDescent()) / 2);
    textSize(18);
    text(c, MARGIN + (10 * c - textWidth(str(c))) / 2, posY + (RECT_HEIGHT + textAscent() - textDescent()) / 2);
    
    posX += w;
    posY += RECT_HEIGHT;
    int t = c;
    c += p;
    p = t;
  }
  
  textSize(48);
  text("Fibonacci series", 500, 320);
  
  endRecord();
}

void draw() 
{
  
}


