import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.awt.Image;
import java.awt.Toolkit;
//import java.awt.MediaTracker;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.awt.image.PixelGrabber;

final int THREADPOOL_SIZE = 9; // Max number of images to load at once
ExecutorService pool = Executors.newFixedThreadPool(THREADPOOL_SIZE);

void getImage(int imageIndex, int gridIndex)
{
  // Load asynchronously the wanted image
  ImageLoader il = new ImageLoader(this, imageIndex, gridIndex);
  pool.execute(il);
}

class ImageLoader implements Runnable
{
  private PApplet pa;
  private String fileName;
  private int gridIndex;

  public ImageLoader(PApplet pa, int imageIndex, int gridIndex)
  {
    this.pa = pa;
    fileName = "H:/Temp/Pauline/" + nf(imageIndex, 4) + ".jpg";
    this.gridIndex = gridIndex;
    println("ImageLoader " + imageIndex);
  }

  public void run()
  {
    byte bytes[] = loadBytes(fileName);
    Image awtImage = Toolkit.getDefaultToolkit().createImage(bytes);    
    /*
    MediaTracker tracker = new MediaTracker(pa);
    tracker.addImage(awtImage, 0);
    try 
    {
      tracker.waitForAll();
    } 
    catch (InterruptedException e) 
    {
      println("Interrupted");
    }
    */
    print("i");
    images[gridIndex].loadPixels();
    if (awtImage instanceof BufferedImage) 
    {
      println("b");

      BufferedImage bi = (BufferedImage) awtImage;
      WritableRaster raster = bi.getRaster();
      raster.getDataElements(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT, images[gridIndex].pixels);
    }
    else
    {
      println("a");

    // No need to get the info, we know upfront the size
//      int w = awtImage.getWidth(null);
//      int h = awtImage.getHeight(null);
      PixelGrabber pg =
          new PixelGrabber(awtImage, 0, 0, IMAGE_WIDTH, IMAGE_HEIGHT, images[gridIndex].pixels, 0, IMAGE_WIDTH);
      try 
      {
        pg.grabPixels();
      } 
      catch (InterruptedException e) { }
    } 
    images[gridIndex].updatePixels();
  }
}

