// https://forum.processing.org/topic/multiple-instances-of-comparable-interface-compareto-in-a-class

class Foo implements Comparable<Foo> // Tells this class has a natural order
{
  int id;
  float size;
  int quantity;
  
  // Constructor
  Foo(int i, float s, int q)
  {
    id = i;
    size = s;
    quantity = q;
  }
  
  // To display nicely the objects
  public String toString() { return id + " " + nf(size, 2, 2) + " " + quantity; }
  
  // Natural order
  public int compareTo(Foo f)
  {
      // Beware of overflows with this kind of comparison!
      // Here, we know it is OK as we control the scope of the values
      return id - f.id;
  }
}
 
void setup()
{
  Foo[] foos = new Foo[10];
  for (int i = 0; i < foos.length; i++)
  {
    foos[i] = new Foo(i, random(1.0, 20.0), int(random(100)));
  }
  
  // Sort by quantity
  Arrays.sort(foos, new Comparator<Foo>()
  {
    public int compare(Foo f1, Foo f2)
    {
      if (f1.size > f2.size) return 1;
      if (f1.size < f2.size) return -1;
      return 0;
    }
  });
  println("By size");
  println(foos);
  
  // Resort by quantity, in descending order
  Arrays.sort(foos, new Comparator<Foo>()
  {
    public int compare(Foo f1, Foo f2)
    {
      return f2.quantity - f1.quantity;
    }
  });
  println("By quantity");
  println(foos);
   
  // Resort by id, in natural order
  Arrays.sort(foos); // No need for a Comparator here
  println("By id");
  println(foos);
  
  exit();
}

