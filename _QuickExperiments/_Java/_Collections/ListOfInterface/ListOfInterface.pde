C c;
R r;
// Define the elements of the list by their least common denominator...
List<Growable> items = new ArrayList<Growable>();

void setup() 
{
  size(500, 500);
  smooth();
  c = new C(20);
  r = new R(30);
  items.add(c);
  items.add(r);
}

void draw() 
{
  background(255);
  
  for (Growable g : items)
  {
    g.draw();
  }
}

void keyPressed()
{
  int gr = 0;
  if (key == 'g')
  {
    gr = 5;
  }
  else if (key == 's')
  {
    gr = -7;
  }
  for (Growable g : items)
  {
    g.grow(gr);
  }
}

interface Growable
{
  // Objects can grow
  void grow(int n);
  // And can be drawn (could be put in an interface named Drawable, for example)
  void draw();
  // You can define other methods
}

class C implements Growable
{
  int diam;
  
  C(int r)
  {
    diam = r;
  }
  
  //@Override
  void draw()
  {
    fill(#55AA88);
    ellipse(100, 100, diam, diam);
  }
  
  //@Override -- Not usable in 1.5, and 2.0 is still at Java 5 syntax, not usable on interface implementations! 
  void grow(int n)
  {
    diam += n;
  }
}

class R implements Growable
{
  int size;
  
  R(int s)
  {
    size = s;
  }
  
  //@Override
  void draw()
  {
    fill(#3388AA);
    rect(300, 300, size, size);
  }
  
  //@Override
  void grow(int n)
  {
    size += n;
  }
}

