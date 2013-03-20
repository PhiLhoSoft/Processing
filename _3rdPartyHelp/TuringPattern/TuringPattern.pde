float[] aR= {
 50.0, 5.0,2.0
};
float[] iR= {
  100.0, 10.0,4.0
};
float[] small= {
  .4, .2,.1
};

PShader s;  
float i;
    
void setup() {
  size(640, 360,P2D);
  s = loadShader("turing.glsl");
  s.set("activatorRadii",aR);
  s.set("inhibitorRadii",iR);
  s.set("smallAmount",small);
  i=1;
  loadPixels();
  randomize();
}
void randomize(){
  for(int i=0;i<pixels.length;i++)
    pixels[i]=color(random(0,255));
  updatePixels();
}

void draw() {
  s.set("iterations",i);
  filter(s);
  i++;
}

