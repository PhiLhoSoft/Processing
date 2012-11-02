import java.util.zip.*;

String path = "H:/Temp/";
String[] files = { "TeamList.txt", "Cursor.png" };

void setup()
{
  // Input files
  FileInputStream in = null;
  // Output file
  ZipOutputStream out = null;
  try
  {
    out = new ZipOutputStream(new FileOutputStream("H:/Temp/Test.zip"));
    for (String file : files)
    {
      in = new FileInputStream(path + file);
      // Name the file inside the zip file
      out.putNextEntry(new ZipEntry(file));
      byte[] b = new byte[1024];
      int count;
      while ((count = in.read (b)) > 0) 
      {
        out.write(b, 0, count);
      }
      in.close();
    }
  }
  catch (IOException e)
  {
    e.printStackTrace();
  }
  finally
  {
    try
    {
      if (out != null) out.close();
      if (in != null) in.close();
    }
    catch (IOException e)
    {
      e.printStackTrace();
    }
  }
}

