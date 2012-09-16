int circleNb = 1;
 
void setup() 
{
  size(250, 250);
  smooth();
  textSize(20);
}
 
void draw() 
{
  if (frameCount % 10 == 0)
  {
    circleNb++;
  }
  int circlesPerLine = int(sqrt(circleNb) + 0.999);
//  println(circleNb + ", " + circlesPerLine);
  
  background(128); 
  float w = (float) width / circlesPerLine; 
  int count = 0;
  int j = -1;
  while (count < circleNb)
  {
    int i = count % circlesPerLine;
    if (i == 0) j++;
    float x = w/2 + i*w;
    float y = w/2 + j*w;
    fill(255);
    ellipse(x, y, w, w);
    count++;
  }
  fill(#FF5588);
  text(circleNb + ", " + circlesPerLine, 10, 30);
}


