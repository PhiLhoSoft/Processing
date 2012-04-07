public class Test
{
  public static void main(String[] args)
  {
    Test t = new Test();
  }

  Test()
  {
    System.out.println("Test");
    Class1 cl1 = new Class1();
  }

  class Class1
  {
    private boolean isVisible = true;

    Class1()
    {
      System.out.println("Class1");
      ClassA ca = new ClassA();
      System.out.println("Visible: " + isVisible);
    }

    class ClassA
    {
      ClassA()
      {
        System.out.println("Class A");
        ClassA1 ca1 = new ClassA1();
      }

      class ClassA1
      {
        ClassA1()
        {
          System.out.println("Class A1 (" + isVisible + ")");
          isVisible = false;
        }
      }
    }
  }
}