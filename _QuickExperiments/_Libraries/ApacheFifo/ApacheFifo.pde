import org.apache.commons.collections.keyvalue.*;
import org.apache.commons.collections.comparators.*;
import org.apache.commons.collections.set.*;
import org.apache.commons.collections.iterators.*;
import org.apache.commons.collections.buffer.*;
import org.apache.commons.collections.map.*;
import org.apache.commons.collections.bag.*;
import org.apache.commons.collections.list.*;
import org.apache.commons.collections.bidimap.*;
import org.apache.commons.collections.collection.*;
import org.apache.commons.collections.*;
import org.apache.commons.collections.functors.*;

int SIZE = 2000;
CircularFifoBuffer buffer = new CircularFifoBuffer(SIZE);
Ball[] balls = new Ball[SIZE];

void setup()
{
  size(800, 800);
  for (int i = 0; i < SIZE; i++)
  {
    Ball b = new Ball();
    balls[i] = b;
  }
}

void draw()
{
  background(255);
  for (int i = 0; i < SIZE; i++)
  {
    Ball b = balls[i];
    b.display();
  }
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

