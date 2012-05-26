// Change path to one on your system
final String PATH = "H:/Temp/Other"; // final = won't change, constant
File dir = new File(PATH);

// Get the list of files
File[] files = dir.listFiles();
println(files);
String toOpen = null;

// Look at the file names
for (File file : files)
{
  // Check extension
  if (file.getName().endsWith(".txt"))
  {
    // Get path. Note: I could also make a file filter to give to listFiles
    toOpen = file.getAbsolutePath();
    break;
  }
}
String[] lines = new String[0]; // No need to check for null with this trick
if (toOpen != null)
{
  lines = loadStrings(toOpen);
}
println(lines);


// Alternative

dir = new File("H:/Temp"); // More files there...
files = dir.listFiles(new FileFilter()
{
  public boolean accept(File file)
  {
    if (file.isDirectory())
      return false; // Only files. A directory can have a dot in its name...
    String name = file.getName();
    return name.endsWith(".txt") || name.endsWith(".xml");
  }
});
println(files);

exit();


