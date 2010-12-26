import java.lang.reflect.*;

public Vehicle someVehicle;

void setup()
{
  someVehicle = new Vehicle("Plane", 300);
  
  String varToGet = "someVehicle";
  try 
  {
    Class c = getClass();
//    Field[] fields = c.getFields();
//    for (Field fld : fields) println(fld);
    // Get the field (here, "global variable" of the sketch
    // Must be public
    Field f = c.getField(varToGet);
    // Get the object behind this field, in the current instance
    Object o = f.get(this);
    Vehicle v = (Vehicle) o;
    v.drive();
  }
  catch (Exception e) 
  {
    println(e);
  }
}

class Vehicle
{
  String type;
  int maxSpeed;
  
  public Vehicle(String t, int ms)
  {
    type = t;
    maxSpeed = ms;
  }
  
  public void drive()
  {
    println("Driving with " + this);
  }
  
  public String toString()
  {
    return "Vehicle '" + type + "' can go up to " + maxSpeed;
  }
}

