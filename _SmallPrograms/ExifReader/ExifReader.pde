import com.drew.imaging.*;
import com.drew.imaging.jpeg.*;
import com.drew.metadata.*;
import com.drew.metadata.exif.*;
import com.drew.metadata.iptc.*;
import com.drew.metadata.jpeg.*;


void setup()
{
  size(800, 800);
  background(0);
/*
  String pictureFolder = selectFolder("Image Folder");

  if (pictureFolder == null)
  {
    println("Canceled");
    return;
  }
*/
String pictureFolder = "E:/Documents/Images/Tests";

  File pictFolder = new File(pictureFolder);
  File[] pictureFiles = pictFolder.listFiles(
      new FilenameFilter()
      {
        boolean accept(File dir, String name)
        {
          String fn = name.toLowerCase();
          // Exif is only in these files, no?
          return fn.endsWith(".jpg") || fn.endsWith(".jpeg");
        }
      }
  );
  int x = 10, y = 10;
  int maxHeight = 0;
  for (int fi = 0; fi < pictureFiles.length; fi++)
  {
    File pf = null;
    Metadata metadata = null;
    try
    {
      pf = pictureFiles[fi];
      metadata = JpegMetadataReader.readMetadata(pf);
    }
    catch (JpegProcessingException ex)
    {
      println("Ouch! " + pf.getName());
    }
    if (metadata != null)
    {
//      println("\n" + pf);
//      ExifProcessing.ShowInformation(metadata);
//      ExifProcessing.WriteThumbnail(metadata, pf);
      BufferedImage bi = ExifProcessing.GetThumbnail(metadata);
      if (bi == null)
        continue; // No thumbnail
      println("\n" + pf);
//      println(bi);
      PImage pi = GetPImage(bi);
      println("Thumb: " + pi.width + "x" + pi.height);
      if (x + pi.width > width)
      {
        x = 10;
        y += maxHeight + 10;
        maxHeight = 0;
      }
      image(pi, x, y);
      x += pi.width + 10;
      if (pi.height > maxHeight)
      {
        maxHeight = pi.height;
      }
    }
  }
//  exit();
}

PImage GetPImage(BufferedImage image)
{
  Raster raster = image.getRaster();
  if (raster.getTransferType() == DataBuffer.TYPE_INT)
  {
    // Just use the built-in converter
    return new PImage(image);
//    PImage pi = createImage(image.getWidth(), image.getHeight(), RGB);
//    raster.getDataElements(0, 0, pi.width, pi.height, pi.pixels);
  }
  else
  {
    // Can be DataBuffer.TYPE_BYTE (that's what we have in the Jpeg thumbnails
    // or something else
    PImage pi = createImage(image.getWidth(), image.getHeight(), RGB);
    PixelGrabber pg = new PixelGrabber(image, 0, 0, pi.width, pi.height,
        pi.pixels, 0, pi.width);
    try
    {
      pg.grabPixels();
    }
    catch (InterruptedException e) { }
    return pi;
  }
}
