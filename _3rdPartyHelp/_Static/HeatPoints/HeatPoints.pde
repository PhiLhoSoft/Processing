
int numHeatPoints = 5;
HeatPoint[] heatPoints = new HeatPoint[numHeatPoints];
 
void setup(){
  size(1280,800);
  smooth();
  for (int i=0;i<numHeatPoints;i++){
    heatPoints[i] = new HeatPoint(random(0,width),random(0,height));  
  }
  noStroke();
  rectMode(CENTER);
  imageMode(CENTER);
  noLoop();
}
 
void draw(){
  background(0);
  for (int i=0;i<numHeatPoints;i++){
    heatPoints[i].drawHeatPoint();
  }
}

 


class HeatPoint{
  final int RADIUS = 200;
  float x,y;
  float val;
  float[] rgba = new float[4];
  PGraphics img = createGraphics(RADIUS * 2, RADIUS * 2, JAVA2D);
   
  HeatPoint(float myX, float myY){
    x = myX;
    y = myY;
    updateHeatPointVal(random(1));
    draw();
  }
  
  void updateHeatPointVal(float v){
    val = v;
    rgba[0] = map(val,0,1,0,255);
    rgba[1] = map(val,0,1,255,0);
    rgba[2] = 0;
    rgba[3] = 255;
    println(val);
  }
  
  float getAlpha(int px, int py)
  {
    float d = dist(px, py, RADIUS, RADIUS);
    if (d < RADIUS) 
    {
      return map(d, 0, RADIUS, 175, 100);
    }
    return -1;
  }
  
  void draw()
  {
    img.beginDraw();
    for (int px = 0; px < img.width; px += 4)
    {
      for (int py = 0; py < img.width; py += 4)
      {
        float alpha = getAlpha(px, py);
        if (alpha >= 0)
        {
          img.fill(rgba[0], rgba[1], rgba[2], alpha);
          img.rect(x, y, 8, 8);
        }
      }
    }
    img.endDraw();
  }
  
  void drawHeatPoint(){
//    fill(rgba[0],rgba[1],rgba[2],rgba[3]);
//    ellipse(x,y,255,255);
    image(img, x, y);
  }
}

