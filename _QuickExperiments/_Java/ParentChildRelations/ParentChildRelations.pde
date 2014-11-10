class Parent
{
  int var;
  public String toString()
  {
    return "Parent{var=" + var + "}";
  }
}
class Child extends Parent
{
  String name;
  public String toString()
  {
    return "Child{var=" + var + ", name=" + name + "}";
  }
}

class Main
{
  Parent p; 
  Main()
  {
    p = new Parent();
    p.var = 42;
  }
  Parent getObject()
  {
    return p;
  }
  public String toString()
  {
    return "Main{" + p + "}";
  }
}
class SubMain extends Main
{
  SubMain()
  {
    p = new Child();
    p.var = 12;
    ((Child) p).name = "Baby";
  }
  @ Override
  Child getObject()
  {
    return (Child) p;
  }
}

void setup()
{
  SubMain sm = new SubMain();
  println(sm);
  println(sm.getObject());
  exit();
}

