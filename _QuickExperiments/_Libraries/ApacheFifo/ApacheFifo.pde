import java.util.*;
import org.apache.commons.collections.buffer.*;

boolean bUseFifo = true;
boolean bDynamicArray = true;
final int SIZE = 2000;
CircularFifoBuffer buffer;
Ball[] balls;

void setup()
{
  size(800, 800);
  if (bUseFifo)
  {
    buffer = new CircularFifoBuffer(SIZE);
  }
  else
  {
    balls = new Ball[SIZE];
    for (int i = 0; i < SIZE; i++)
    {
      balls[i] = new Ball();
    }
  }
}

void draw()
{
  background(255);
  if (bUseFifo)
  {
    for (int i = 0; i < SIZE / 20; i++)
    {
      Ball b = new Ball();
      buffer.add(b);
    }
    for (Iterator it = buffer.iterator(); it.hasNext(); )
    {
      Ball b = (Ball) it.next();
      b.display();
    }
  }
  else
  {
    if (bDynamicArray)
    {
    for (int i = 0; i < SIZE / 20; i++)
    {
      Ball b = new Ball();
      balls[int(random(SIZE))] = b;
    }
    }
    for (int i = 0; i < SIZE; i++)
    {
      Ball b = balls[i];
      b.display();
    }
  }
  fill(0);
  text("FC: " + frameRate, 10, 20);
}

class Ball
{
  int x, y, s;
  color c;
  
  Ball()
  {
    x = int(random(width));
    y = int(random(height));
    s = int(random(5, 20));
    c = color(random(50, 100), random(255), random(255), random(128, 200));
  }
  
  void display()
  {
    noStroke();
    fill(c);
    ellipse(x, y, s, s);
  }
}

