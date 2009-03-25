String[] fontList;

void setup()
{
  // Open file chooser to select font folder
  String folderPath = selectFolder();  
  if (folderPath == null) {
    // If a folder was not selected
    println("No folder was selected...");
  } else {
    // If a folder was selected, print path to folder
    println(folderPath);
  }
 
  // determine Path
  String path = folderPath;
  println("Listing all filenames in a directory: ");
  String[] filenames = listFileNames(path);
 
  // fontList =  PFont.list();
  fontList = filenames;    //FONT SELECTION CODE
 
  println(fontList);
  exit();
}
 
// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list(new FilenameFilter() {
      boolean accept(File dir, String name) {
        return name.endsWith(".ttf") || name.endsWith(".odf") || name.endsWith(".sit");
      }
    });
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}


