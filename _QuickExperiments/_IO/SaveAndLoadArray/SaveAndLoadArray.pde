void setup()
{
  int[] test1 = { 1, 10, 100, 1000, 10000, 100000, 1000000, 2000000 };
  float[] test2 = { 1000000.0, 100000.0, 10000.0, 1000.0, 100.0, 10.0, 1.0, 0.0 };
  float[][] test3 =
  {
    { 5.0, 70.0, 500.0, 7000.0, 50000.0, 700000.0, 5000000.0 },
    { 7000000.0, 500000.0, 70000.0, 5000.0, 700.0, 50.0, 7.0 }
  };
  float[] test4 = new float[65536]; // To see compression benefits... (not so much!)
  for (int i = 0; i < test4.length; i++)
  {
    test4[i] = 57 * sin(i / 57.0);
  }
  String path = savePath("test");

  SaveObject(path + "1.bin", test1);
  SaveObject(path + "1.gz",  test1);
  SaveObject(path + "2.bin", test2);
  SaveObject(path + "2.gz",  test2);
  SaveObject(path + "3.bin", test3);
  SaveObject(path + "3.gz",  test3);
  SaveObject(path + "4.bin", test4);
  SaveObject(path + "4.gz",  test4);

  println("\nValues");
  println("int");      println(test1); test1 = null;
  println("float1");   println(test2); test2 = null;
  println("float2 0"); println(test3[0]);
  println("float2 1"); println(test3[1]); test3 = null;

  test1 = (int[]) LoadObject(path + "1.bin");
  test2 = (float[]) LoadObject(path + "2.bin");
  test3 = (float[][]) LoadObject(path + "3.bin");

  println("\nRead raw");
  println("int");      println(test1); test1 = null;
  println("float1");   println(test2); test2 = null;
  println("float2 0"); println(test3[0]);
  println("float2 1"); println(test3[1]); test3 = null;

  test1 = (int[]) LoadObject(path + "1.gz");
  test2 = (float[]) LoadObject(path + "2.gz");
  test3 = (float[][]) LoadObject(path + "3.gz");

  println("\nRead compressed");
  println("int");      println(test1); test1 = null;
  println("float1");   println(test2); test2 = null;
  println("float2 0"); println(test3[0]);
  println("float2 1"); println(test3[1]); test3 = null;
  
  exit();
}

void SaveObject(String fileName, Object toSave)
{
  ObjectOutputStream out = null;
  try
  {
    FileOutputStream fos = new FileOutputStream(fileName);
    OutputStream os = fos;
    if (fileName.endsWith("gz")) // Processing style
    {
      os = new GZIPOutputStream(fos);
    }
    out = new ObjectOutputStream(os);
    out.writeObject(toSave);
    out.flush();
  }
  catch (IOException e)
  {
    e.printStackTrace();
  }
  finally
  {
    if (out != null)
    {
      try { out.close(); } catch (IOException e) {}
    }
  }
}

Object LoadObject(String fileName)
{
  ObjectInputStream in = null;
  Object readVal = null;
  try
  {
    FileInputStream fis = new FileInputStream(fileName);
    InputStream is = fis;
    if (fileName.endsWith("gz")) // Processing style
    {
      is = new GZIPInputStream(fis);
    }
    in = new ObjectInputStream(is);
    readVal = in.readObject();
  }
  catch (IOException e)
  {
    e.printStackTrace();
  }
  catch (ClassNotFoundException e)
  {
    e.printStackTrace();
  }
  finally
  {
    if (in != null)
    {
      try { in.close(); } catch (IOException e) {}
    }
  }
  return readVal;
}
