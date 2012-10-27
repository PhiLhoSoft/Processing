// http://wiki.processing.org/index.php?title=What_is_an_exception%3F

void writeToFile(String path, String data)
{
  // The writer must be external to the try clause,
  // to be able to close it properly.
  // The assignment to null is necessary, otherwise Java complains that the variable
  // might be not initialized.
  Writer writer = null; 
  try
  {
    // The 'true' parameter allows to append at the end of the file
    writer = new FileWriter(path, true); // Can throw IOException
    writer.append(data).append("\n"); // Can also throw IOException
  }
  catch (IOException e)
  {
    // Handle the error, or just print it, like:
    println("Error when writing file: " + e.getMessage());
    // Alternatively (show where the error happened
    e.printStackTrace();
  }
  finally // This part is executed in all cases, with or without exception
  {
    if (writer != null) // Can be null if the constructor thrown an exception
    {
      try
      {
        writer.close();
      }
      catch (IOException e) // Yes, even close() can throw an exception!
      {
        println("Error when closing file: " + e.getMessage());
      }
    }
  }
}

Writer appendToFile(Writer writer, String path, String data)
    throws IOException
{
  if (writer == null)
  {
    if (path == null)
    {
      // A classical way to handle bad input to a method.
      // Note that you need to create the exception (new) before throwing it.
      throw new IllegalArgumentException("Either writer or path must be non-null");
    }
    // The 'true' parameter allows to append at the end of the file
    writer = new FileWriter(path, true); // Can throw IOException
  }
  writer.append(data).append("\n"); // Can also throw IOException
  return writer;
}

void setup()
{
  String path = "G:/Tmp/Foo.txt"; // Use a path adapted to your system. Try a non-existing folder to see exceptions...
  writeToFile(path, "Foo");
  // Not efficient as we have to open and close the file on each string to write
  writeToFile(path, "Bar");
  
  Writer writer = null;
  try
  {
    writer = appendToFile(null, path, "aFoo");
    // We can chain the writing
    appendToFile(writer, null, "aBar");
    // Test the IAE...
    appendToFile(null, null, "aBar");
  }
  catch (IOException e)
  {
    println("Error when writing file: " + e.getMessage());
  }
  catch (IllegalArgumentException e) // Optional, show we can handle several exceptions
  {
    println("Oops!\n" + e.getMessage());
  }
  finally // This part is executed in all cases, with or without exception
  {
    if (writer != null) // Can be null if the constructor thrown an exception
    {
      try
      {
        writer.close();
      }
      catch (IOException e) // Yes, even close() can throw an exception!
      {
        println("Error when closing file: " + e.getMessage());
      }
    }
  }
  exit();
}

