final boolean bShowBug = true;

void setup()
{
  size(500, 500, P2D);
  PImage pi = loadImage("toucan.png");
  if (bShowBug)
  {
    PGraphics pg = createGraphics(width, height, P2D);
    pg.beginDraw();
    pg.fill(#FF0000);
    pg.ellipse(0, 0, width, height);
    pg.fill(#FFFF00);
    pg.ellipse(width, height, width * 1.5, height * 1.5);
    
    pg.textureMode(NORMALIZED);
    pg.noStroke();
    pg.noFill();
    
    pg.beginShape();
    pg.texture(pi);
    pg.vertex(50,   50,   0,   0);
    pg.vertex(400,  50, 162,   0);
    pg.vertex(400, 400, 162, 150);
    pg.vertex(50,  400,   0, 150);
    pg.endShape();
    
    pg.endDraw();
    pg.save("test.png");
    exit();
  }
  else
  {
    fill(#FF0000);
    ellipse(0, 0, width, height);
    fill(#FFFF00);
    ellipse(width, height, width * 1.5, height * 1.5);
    textureMode(NORMALIZED);
    noStroke();
    noFill();
    
    beginShape();
    texture(pi);
    vertex(50,   50,   0,   0);
    vertex(400,  50, 162,   0);
    vertex(400, 400, 162, 150);
    vertex(50,  400,   0, 150);
    endShape();
  }
}


