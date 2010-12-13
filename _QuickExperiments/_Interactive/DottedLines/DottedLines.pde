// http://forum.processing.org/topic/does-any-one-no-how-to-draw-a-dotted-line-with-from-particular-orgin-to-cureent-location-of-mousex-and-mousey
float STEP_SIZE = 5;

void setup()
{
  size(600, 600);
  smooth();
}

void draw()
{
  background(255);

  {  
    float y = height;
    float x = width / 2;
    float d = dist(x, y, mouseX, mouseY);
    int stepNb = int(d / STEP_SIZE / 4);
    float dx = (x - mouseX) / stepNb;
    float dy = (y - mouseY) / stepNb;
    
    stroke(#005500);
    line(x, y, mouseX, mouseY);
  
    fill(255); noStroke();
    for (int i = 0; i < stepNb; i++)
    {
      ellipse(x, y, STEP_SIZE * 2, STEP_SIZE * 2);
      x -= dx; y -= dy;
    }
  }

  stroke(#0000AA);
  {
    float y = 0;
    float x = width / 2;
    float d = dist(x, y, mouseX, mouseY);
    int stepNb = int(d / STEP_SIZE / 2);
    
    float a = PI - atan2(y - mouseY, x - mouseX);
    float dx = STEP_SIZE * cos(a);
    float dy = STEP_SIZE * sin(a);
    
    for (int i = 0; i < stepNb; i++)
    {     
      line(x, y, x += dx, y -= dy);
      x += dx; y -= dy;
    }
  }
}

