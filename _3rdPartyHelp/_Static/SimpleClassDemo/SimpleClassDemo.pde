ArrayList<Thing> stuff = new ArrayList<Thing>();
  
static class Thing // static -> not an inner class
{
  static int rank;
  int id;
  String thingy;

  Thing(int a) 
  { 
    id = a; 
    thingy = "Thing #" + ++rank; 
  }
  static Thing get(int a, ArrayList<Thing> list) 
  {
    for (Thing t : list) 
    {
      if (t.id == a) 
        return t;
    }
    return null;
  }
  
  // Overrides
  public String toString() { return id + " - " + thingy; }
  public boolean equals(Object o) 
  {
    if (!(o instanceof Thing)) 
      return false;
    return ((Thing) o).id == id;
  }
  public int hashCode() { return id; }
}

void setup() 
{
  for (int i = 11; i >= 0; i--) stuff.add(new Thing(i));
  Thing thingThatImLookingFor = Thing.get(5, stuff);
  println(thingThatImLookingFor);
  for (Thing t : stuff) 
  {
    if (t.id == 5) thingThatImLookingFor = t;
    break;
  }
  println(thingThatImLookingFor);
}

