int numSketches = 3; // we have three sketches: 0,1,2
float fadeSpeed = 0.01; // fading speed from one sketch to the next
PGraphics[] pgs = new PGraphics[numSketches];
int currentSketch;
boolean fading;
float fade, fc;
 
void setup() {
  size(600,600);
  // create offscreen graphics for all sketches
  for (int i=0; i<pgs.length; i++) {
    pgs[i] = createGraphics(width,height,JAVA2D);
  }
}
 
void draw() {
  fc = frameCount * 0.01;
 
  // run the current and, while fading, the next sketch
  for (int i=0; i<pgs.length; i++) {
    if (i == currentSketch % pgs.length) {
      sketches(i,pgs[i]);
    } else if (fading && i == (currentSketch + 1) % pgs.length) {
      sketches(i,pgs[i]);
    }
  }
 
  // fade from the current sketch to the next
  if (fading) {
    tint(255,(1-fade)*255);
    image(pgs[currentSketch % pgs.length],0,0);
    tint(255,fade*255);
    image(pgs[(currentSketch+1) % pgs.length],0,0);
    fade += fadeSpeed;
    // once the fading is complete...
    if (fade > 1) {
      fading = false;
      fade = 0;
      currentSketch++;
    }
  // if we are not fading, just display the current sketch
  } else {
    image(pgs[currentSketch % pgs.length],0,0);
  }
}
 
void keyPressed() {
  // start fading on a keyPress
  fading = true;
}
 
void sketches(int num, PGraphics pg) {
  if (num == 0) {
    // sketch ONE
    pg.beginDraw();
    pg.background(255);
    pg.smooth();
    pg.fill(0);
    pg.ellipse(noise(frameCount*0.01)*pg.width,noise(3+frameCount*0.005)*pg.height,100,100);
    pg.endDraw();
  } else if (num == 1) {
    // sketch TWO
    pg.beginDraw();
    pg.background(255,0,0);
    pg.noStroke();
    pg.rectMode(CENTER);
    pg.rect(pg.width/2,pg.height/2,noise(5+frameCount*0.01)*pg.width,noise(7+frameCount*0.01)*pg.height);
    pg.endDraw();
  } else if (num == 2) {
    // sketch THREE
    pg.beginDraw();
    pg.background(100,0,255);
    pg.smooth();
    pg.noStroke();
    pg.fill(255,0,0);
     pg.triangle(noise(4+fc)*pg.width,noise(6+fc)*pg.height,
     noise(5+fc)*pg.width,noise(7+fc)*pg.height,
     noise(9+fc)*pg.width,noise(1+fc)*pg.height);
    pg.endDraw();
  } else if (num == 3) {
    // sketch ETC.
    pg.beginDraw();
    // place your sketch between beginDraw and endDraw
    // put a pg in front of all relevant functions
    pg.endDraw();
  }
}

