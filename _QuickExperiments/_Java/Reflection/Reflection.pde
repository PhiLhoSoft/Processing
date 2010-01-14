void setup()
{
  int p = 1;
  String className = this.getClass().getName() + "$Test" + p;
  Class cl = null;
  try
  {
    cl = Class.forName(className);
  }
  catch (ClassNotFoundException e)
  {
    println("Unknown class: " + className);
  }
  Object ocl = null;
  if (cl != null)
  {
    try
    {
      // Alas, this doesn't work for inner classes!
      // Will work if you put classes in separate .java files
      ocl = cl.newInstance();
    }
    catch (InstantiationException e)
    {
      println("Cannot create an instance of " + className);
    }
    catch (IllegalAccessException e)
    {
      println("Cannot access " + className + ": " + e.getMessage());
    }
    // Internet to the rescue!
    try
    {
      // Get the constructor(s)
      java.lang.reflect.Constructor[] ctors = cl.getDeclaredConstructors();
      // Create an instance with the parent object as parameter (needed for inner classes)
      ocl = ctors[0].newInstance(new Object[] { this });
    }
    catch (InstantiationException e)
    {
      println("Cannot create an instance of " + className);
    }
    catch (IllegalAccessException e)
    {
      println("Cannot access " + className + ": " + e.getMessage());
    }
    catch (Exception e) // Lot of stuff can go wrong...
    {
      e.printStackTrace();
    }
  }
}

public class Test1
{
  public Test1() { println("Constructor of " + this.getClass().getName() + " called"); }
}


