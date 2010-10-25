import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import uk.co.mmscomputing.device.scanner.Scanner;
import uk.co.mmscomputing.device.scanner.ScannerDevice;
import uk.co.mmscomputing.device.scanner.ScannerIOException;
import uk.co.mmscomputing.device.scanner.ScannerIOMetadata;
import uk.co.mmscomputing.device.scanner.ScannerListener;

public class Scan /*extends Thread*/ implements ScannerListener
{
  String  filename;
  Scanner scanner;

  public Scan()
  {
    filename = "NewScan.jpg";
    scanner = Scanner.getDevice();
    scanner.addListener(this);

    try
    {
      String[] devices = scanner.getDeviceNames();
      for (String device : devices)
      {
        System.out.println(device);
      }
//      scanner.select(device[5]);
//      scanner.getScanGUI();
      scanner.acquire();
    }
    catch (ScannerIOException e)
    {
      e.printStackTrace();
    }
  }

  public void update(ScannerIOMetadata.Type type, ScannerIOMetadata metadata)
  {
    if (type.equals(ScannerIOMetadata.ACQUIRED))
    {
      final BufferedImage image = metadata.getImage();
      System.out.println("Have an image now!");
      try
      {
        File f = new File(filename);
        ImageIO.write(image, "jpg", f);
//        f.deleteOnExit();

//              new uk.co.mmscomputing.concurrent.Semaphore(0,true).tryAcquire(2000,null);
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
    else if (type.equals(ScannerIOMetadata.NEGOTIATE))
    {
      System.out.println("Negociating");
      ScannerDevice device = metadata.getDevice();
      try
      {
        device.setShowUserInterface(false);
        device.setShowProgressBar(true);
        device.setResolution(200);
//        device.setRegionOfInterest(0, 0, 210.0, 300.0);
      }
      catch (ScannerIOException e)
      {
        e.printStackTrace();
      }
    }
    else if (type.equals(ScannerIOMetadata.STATECHANGE))
    {
      System.err.println(metadata.getStateStr());
      if (metadata.isFinished())
      {
        System.out.println("Finished!");
      }
    }
    else if (type.equals(ScannerIOMetadata.EXCEPTION))
    {
      metadata.getException().printStackTrace();
    }
  }
}

