import java.util.ArrayList;

class SomeTestClass
{
  ArrayList<Integer> al = new ArrayList<Integer>(10);

  SomeTestClass()
  {
    for (int i = 0; i < 10; i++)
    {
      al.add(i * 10);
    }
  }
  void Print()
  {
    for (int i = 0; i < 10; i++)
    {
      System.out.println(al.get(i) / 5);
    }
  }
}
