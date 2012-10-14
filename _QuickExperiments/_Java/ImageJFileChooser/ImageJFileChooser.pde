// Browse -- http://processing.org/discourse/beta/num_1269983154.html
// Swing version, updated for 2.0

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

File selectedFile;
protected String selectImage(final String prompt)
{
  try
  {
    SwingUtilities.invokeAndWait(new Runnable()
    {
      public void run()
      {
        JFileChooser fileDialog = new JFileChooser();
        fileDialog.setDialogTitle(prompt);
        FileNameExtensionFilter fileFlter = new FileNameExtensionFilter(
            "JPG & PNG Images", "jpg", "png"
        );
        fileDialog.setFileFilter(fileFlter);
        int userAnswer = fileDialog.showOpenDialog(ImageJFileChooser.this); // Or just null
        if (userAnswer == JFileChooser.APPROVE_OPTION)
        {
          selectedFile = fileDialog.getSelectedFile();
        }
      }
    });
    return selectedFile == null ? null : selectedFile.getAbsolutePath();
  }
  catch (Exception e)
  {
    e.printStackTrace();
    return null;
  }
}

