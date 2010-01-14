PGraphics pg;
 
void setup()
{
  size(400, 400);
//  smooth();
   
  pg = createGraphics(width, height, JAVA2D);
//  pg.smooth();
  noLoop();
}

void draw()
{
  pg.beginDraw();
  // Kind of reference shape...
  stroke(25);
  pg.fill(#FF8844);
  pg.ellipse(width / 2, height / 2, width - 100, height - 100);

  pg.noStroke();
  for (int i = 0; i < 10; i++)
  {
    pg.fill(0xAA, 0xAA, 0xFF, i * 20 + 50);
    pg.rect(i * width / 10, 0, width / 10, height);
  }

  pg.endDraw();
  pg.save(savePath("PGraphics3.png"));

  background(140);
  image(pg, 0, 0, width, height);
} 

