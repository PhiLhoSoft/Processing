import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioSample alert;
int duration;

final int SIZE = 16;
boolean halt, stopping;
int c;

void setup() 
{
  size(240, 400);
  noStroke();
 
  minim = new Minim(this);
  alert = minim.loadSample("G:/Documents divers/Sounds/Huge Metal Door Slam.mp3");
  duration = alert.length();
}

void draw() 
{
  if (halt) 
  {
    alert.trigger();
    halt = false;
    stopping = true;
    duration += millis();
  }
  if (stopping && millis() > duration) 
  {
    exit();
  }
  if (!stopping)
  {
    fill(random(255), random(255), random(255));
    rect(SIZE * (c % (width / SIZE)), SIZE * (c / (width / SIZE)), SIZE, SIZE);
    halt = ++c > width * height / SIZE / SIZE;
  }
}

