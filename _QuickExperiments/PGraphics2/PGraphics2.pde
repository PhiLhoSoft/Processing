PGraphics pg;
 
void setup()
{
  size(400, 400);
//  smooth();
   
  pg = createGraphics(100, 100, JAVA2D);
//  pg.smooth();
}

void draw()
{
  stroke(255);
  background(40);

  pg.beginDraw();
  pg.background(200);
  pg.fill(#FF0000);
  pg.ellipse(10, 56, 12, 12);

  pg.fill(#AA00FF);
  pg.ellipse(15, 20, 5, 5);
  for (int i = 1; i <= 3; i++)
    pg.ellipse(24*i, 48, 8, 16);

  pg.endDraw();
  image(pg, 0, 0, 400, 400);
} 

