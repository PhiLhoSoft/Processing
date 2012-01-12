final String path = "G:/Images/icons";
final int imgW = 70;
final int imgH = 50;
 
void setup()
{
  size(700, 500);
  background(255);
  
  FilenameFilter filter = new FilenameFilter()
  {
    public boolean accept(File dir, String name)
    {
      return name.endsWith(".jpg") // Enough for you
          || name.endsWith(".png") || name.endsWith(".gif"); // More for my test
    }
  };
  
  int posX = 0;
  int posY = 0;
  File[] files = new File(path).listFiles(filter);
  for (File f : files)
  {
    PImage img = loadImage(f.getAbsolutePath());
    image(img, posX, posY, imgW, imgH);
    if (posX + imgW > width) 
    { 
       posX = 0; 
       posY += imgH;
       if (posY > height)
       {
         break; // Stop drawing
       }
    }
    else
    {
      posX += imgW;
    }
  }
}

