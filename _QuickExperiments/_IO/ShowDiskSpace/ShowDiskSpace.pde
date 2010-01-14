void setup()
{
  println("Free space in MB");
  File homeDir = new File("C:/windows");
  ShowSpace(homeDir);
  File otherDir = new File("E:/");
  ShowSpace(otherDir);
}

void ShowSpace(File dir)
{
  println(dir.getAbsolutePath());
  println("Total space  = " + FormatResult(dir.getTotalSpace()));
  println("Free space   = " + FormatResult(dir.getFreeSpace()));
  println("Usable space = " + FormatResult(dir.getUsableSpace()));
}

String FormatResult(long number)
{
  // Bytes to MB
  // Align on right at 10 characters, including locale group separator
  return String.format("%,10d", number / 1024 / 1024);
}



