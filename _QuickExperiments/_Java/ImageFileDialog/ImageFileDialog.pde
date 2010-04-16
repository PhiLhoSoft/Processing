import java.awt.FileDialog;
import javax.swing.SwingUtilities;

void setup()
{
  size(500, 500);
  String filePath = selectImage("Choose an Image");
  println(filePath);
}

protected String selectImage(final String prompt)
{
  checkParentFrame();

  try
  {
    SwingUtilities.invokeAndWait(new Runnable()
    {
      public void run()
      {
        FileDialog fileDialog = new FileDialog(parentFrame, prompt, FileDialog.LOAD);
        fileDialog.setFilenameFilter(new FilterImages());
        fileDialog.setVisible(true);
        String directory = fileDialog.getDirectory();
        String filename = fileDialog.getFile();
        selectedFile = (filename == null) ? null : new File(directory, filename);
      }
    });
    return (selectedFile == null) ? null : selectedFile.getAbsolutePath();
  }
  catch (Exception e) 
  {
    e.printStackTrace();
    return null;
  }
}

class FilterImages implements FilenameFilter
{
  boolean accept(File dir, String name)
  {
    println(dir + " -> " + name);
    return name.endsWith(".jpg") || name.endsWith(".png");
  }
}

