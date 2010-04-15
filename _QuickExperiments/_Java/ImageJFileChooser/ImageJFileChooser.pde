import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.SwingUtilities;

void setup()
{
  size(500, 500);
  String filePath = selectImage("Choose an Image");
  println(filePath);
  if (filePath != null)
  {
    PImage img = loadImage(filePath);
    image(img, 0, 0);
  }
  else
  {
    exit();
  }
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
        JFileChooser fileDialog = new JFileChooser();
        fileDialog.setDialogTitle(prompt);
        FileNameExtensionFilter filter = new FileNameExtensionFilter(
            "JPG & PNG Images", "jpg", "png");
        fileDialog.setFileFilter(filter);
        int returnVal = fileDialog.showOpenDialog(parentFrame);
        if (returnVal == JFileChooser.APPROVE_OPTION) 
        {
          selectedFile = fileDialog.getSelectedFile();
        }
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

