import java.io.*;
 
String fileName = "H:/Temp/SomeFile.dat";
 
void setup()
{
  OutputStream os = createOutput(fileName);
  DataOutputStream dos = new DataOutputStream(os);
  try
  {
    dos.writeInt(42);
    dos.writeFloat(3.14159);
    dos.writeBoolean(true);
  }
  catch (IOException e) { println("Error: " + e); } // A real program would do a real exception handling... (log, recovery, rethrow, etc.)
  finally // Close the stream even if an exception happened
  {
    if (dos != null)
    {
      try { dos.close(); } // The joys of Java I/O... With Java 7, auto-close is nicer!
      catch (IOException e) { println("Error when closing: " + e); }
    }
  }
  
  println("Done");
  
  InputStream is = createInput(fileName);
  DataInputStream dis = new DataInputStream(is);
  try
  {
    println(dis.readInt());
    println(dis.readFloat());
    println(dis.readBoolean());
  }
  catch (IOException e) { println("Error: " + e); }
  finally
  {
    if (dis != null)
    {
      try { dis.close(); }
      catch (IOException e) { println("Error when closing: " + e); }
    }
  }
  
  exit();
}

