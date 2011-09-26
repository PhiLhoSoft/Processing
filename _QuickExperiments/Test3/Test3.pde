void setup() {
  size(800, 200);
  hint(ENABLE_NATIVE_FONTS);
  PFont f = createFont("Times New Roman", 48);
  background(255);
    
  stroke(#FF0000);
  line(0, 100, width, 100);

  textFont(f, 48);
  fill(0);
  text("Sample Text", 20, 100);
  
  PGraphics pg = createGraphics(400, 200, JAVA2D);
  pg.beginDraw();
  pg.textFont(f, 48);
  pg.fill(0);
  pg.text("Sample Text", 20, 100);
  pg.endDraw();
  image(pg, 400, 0);
}

void draw() {
  noLoop();
}


