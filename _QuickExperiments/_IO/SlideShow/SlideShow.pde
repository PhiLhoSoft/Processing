import java.io.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

private PrintWriter output;
private OutputStream os;
private DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // Ansi date format

int counter; // Automatically initialized at 0
final int DISPLAY_TIME = 5000; // 5000 ms = 5 seconds
int lastTime; // When the current image was first displayed

String logFileName = "FileList.txt";

/* First version, taking the images from the data folder
final int IMAGE_NB = 20; // Supposing we have 20 images
File[] files = new File[IMAGE_NB];
PImage[] images = new PImage[IMAGE_NB];

void setup()
{
  size(700, 700);

  for (int i = 0; i < IMAGE_NB; i++)
  {
    files[i] = dataFile("img" + nf(i+1, 2) + ".png"); // nf() allows to generate 01, 02, etc.
    images[i] = loadImage(files[i].getAbsolutePath());
  }
  randomizeImages();
  lastTime = millis();
}
*/

String imageFolderPath = "G:/Images";
File[] files;
PImage[] images;

// Second version, just listing the images
void setup()
{
  size(700, 700);

  File imageFolder = new File(imageFolderPath);
  files = imageFolder.listFiles(new FileFilter()
  {
    public boolean accept(File file)
    {
      if (file.isDirectory())
        return false; // Only files. A directory can have a dot in its name...
      String name = file.getName();
      return name.endsWith(".jpg") || name.endsWith(".png") || name.endsWith(".gif");
    }
  });
  images = new PImage[files.length];

  for (int i = 0; i < files.length; i++)
  {
    images[i] = loadImage(files[i].getAbsolutePath());
  }
  randomizeImages();
  showImageInfo();
  lastTime = millis();
}

void draw()
{
  background(255);
  fill(#005599);

  if (millis() - lastTime >= DISPLAY_TIME) // Time to display next image
  {
    counter++;
    if (counter == files.length) // Or IMAGE_NB
    {
      // Displayed all images, re-randomize the images
      randomizeImages();
    }
    lastTime = millis();
    showImageInfo();
  }
  image(images[counter], 0,0);
}

void randomizeImages()
{
  for (int i = images.length - 1; i > 0; i--)
  {
    int j = int(random(i + 1));
    // Swap
    PImage ti = images[i];
    images[i] = images[j];
    images[j] = ti;
    // Swap
    File tf = files[i];
    files[i] = files[j];
    files[j] = tf;
  }
}

void showImageInfo()
{
  File f = files[counter];
  trace("Name: " + f.getName());
  trace("Size: " + f.length());
  String lastModified = dateFormat.format(new Date(f.lastModified()));
  trace("Last Modified: " + lastModified);
  trace("-----------------------");
}

void trace(String line)
{
  println(line);
  log(line);
}

/*-- A simple logger --*/

public void log(String line)
{
  // The file is opened on each write, in append mode
  PrintWriter output = null;
  try
  {
    // Create a file writer in append mode
    output = new PrintWriter(new FileWriter(sketchPath(logFileName), true));
    output.println(line);
  }
  catch (IOException e)
  {
    e.printStackTrace(); // Dumb and primitive exception handling...
    output = null;
  }
  finally
  {
    if (output != null)
    {
      output.close();
    }
  }
}
