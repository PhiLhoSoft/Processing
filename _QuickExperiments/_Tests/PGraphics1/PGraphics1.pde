PGraphics pg;
PGraphics pg1;
 
int y1 = 0, y = 0;
 
void setup()
{
  size(800, 400);
  smooth();
   
  pg = createGraphics(200, 200, JAVA2D);
  pg1 = createGraphics(50, 50, JAVA2D);
  pg.smooth();
  pg1.smooth();
}

void draw()
{
  stroke(255);
  background(40);
  pushMatrix();
  __draw1();
  popMatrix();
  translate(400, 0);
  __draw2();
}

void __draw1()
{
  pg.beginDraw();
  pg.translate(0, y1/2);
  pg.background(90);
   
  pg1.beginDraw();
  pg1.background(160);
   
  for (int i = 0; i < 3; i++)
    pg.rect(30*(i+1), 100, 20, 15);
   
  pg1.fill(40, 20, 170);
  pg1.translate(0, y1/4);
  pg1.rect(15, 20, 20, 15);
   
  pg.endDraw();
  image( pg, 100, 100);
  pg1.endDraw();
  translate(0, y1/4);
  image( pg1, 230, 170);
   
  y1--;
} 

void __draw2()
{
  fill(#FF0000);
  ellipse(10, 100, 7, 7);

  pg1.beginDraw();
  pg1.background(160);
  pg1.fill(40, 20, 170);
  pg1.translate(0, y/4);
  pg1.rect(15, 20, 20, 15);
  pg1.fill(#FF0000);
  pg1.ellipse(15, 20, 5, 5);
  pg1.endDraw();
   
  pg.beginDraw();
  pg.background(90);
   
  pg.translate(0, y/2);
  for (int i = 1; i <= 3; i++)
    pg.rect(30*i, 100, 20, 15);
   
  pg.translate(0, -y/4);
  pg.image(pg1, 130, 70);
   
  pg.endDraw();
  image(pg, 100, 100);
   
  y--;
} 

