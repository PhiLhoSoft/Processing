import java.util.*;
import java.io.*;

import java.awt.*;
import java.awt.image.*;

import javax.imageio.ImageIO;

import com.drew.imaging.*;
import com.drew.imaging.jpeg.*;
import com.drew.metadata.*;
import com.drew.metadata.exif.*;
import com.drew.metadata.iptc.*;
import com.drew.metadata.jpeg.*;


class ExifProcessing
{
  static void ShowInformation(Metadata metadata)
  {
    Iterator directories = metadata.getDirectoryIterator();
    while (directories.hasNext())
    {
      Directory directory = (Directory) directories.next();
      // iterate through tags and print to System.out
      Iterator tags = directory.getTagIterator();
      while (tags.hasNext())
      {
        Tag tag = (Tag) tags.next();
        // use Tag.toString()
        System.out.println(tag);
      }
    }
  }

  static void WriteThumbnail(Metadata metadata, File pictureFile)
  {
    ExifDirectory dir = (ExifDirectory) metadata.getDirectory(ExifDirectory.class);
    if (!dir.containsThumbnail())
    {
      System.out.println("No thumbnail");
      return;
    }
    String fileName = pictureFile.getName();
    File file = new File(pictureFile.getParentFile().getPath(),
        fileName.replaceAll("\\.jpe?g$", ".thumb.jpg"));
    if (file.getName().equals(fileName))
    {
      // Don't overwrite file if something is going wrong!
      System.out.println("Wrong extension? " + file.getAbsolutePath());
      return;
    }
    try
    {
      dir.writeThumbnail(file.getAbsolutePath());
      System.out.println("Thumbnail written: " + file.getAbsolutePath());
    }
    catch (MetadataException me)
    {
      System.out.println(me);
    }
    catch (IOException ioe)
    {
      System.out.println(ioe);
    }
  }

  // Most of the code there comes from unfinished (commented out) work in ExifDirectory.java
  static BufferedImage GetThumbnail(Metadata metadata)
  {
    BufferedImage bi = null;
    ExifDirectory dir = (ExifDirectory) metadata.getDirectory(ExifDirectory.class);
    if (!dir.containsThumbnail())
    {
      return null;
    }
    int compression = 0;
    try
    {
      compression = dir.getInt(ExifDirectory.TAG_COMPRESSION);
    }
    catch (MetadataException e)
    {
      System.out.println("Unable to determine thumbnail type " + e);
      return null;
    }
    byte[] thumbnailBytes = null;
    try
    {
      thumbnailBytes = dir.getThumbnailData();
    }
    catch (MetadataException me)
    {
      System.out.println(me);
      return null;
    }

    if (compression == ExifDirectory.COMPRESSION_JPEG)
    {
      try
      {
        return ImageIO.read(new ByteArrayInputStream(thumbnailBytes));
      }
      catch (IOException ioe)
      {
        System.out.println(ioe);
      }
    }
    else
    {
      // uncompressed thumbnail (raw RGB data)
      if (!dir.containsTag(ExifDirectory.TAG_PHOTOMETRIC_INTERPRETATION))
          return null;

      int imageWidth = 0, imageHeight = 0;
      try
      {
        if (!dir.containsTag(ExifDirectory.TAG_THUMBNAIL_IMAGE_WIDTH))
        {
          System.out.println("No thumbnail size");
          return null;
        }
        imageWidth = dir.getInt(ExifDirectory.TAG_THUMBNAIL_IMAGE_WIDTH);
        imageHeight = dir.getInt(ExifDirectory.TAG_THUMBNAIL_IMAGE_HEIGHT);
      }
      catch (MetadataException e)
      {
        System.out.println("Cannot get thumbnail dimensions: " + e);
        return null;
      }

      try
      {
        // If the image is RGB format, then convert it to a bitmap
        int photometricInterpretation = dir.getInt(ExifDirectory.TAG_PHOTOMETRIC_INTERPRETATION);
        if (photometricInterpretation == ExifDirectory.PHOTOMETRIC_INTERPRETATION_RGB)
        {
          // RGB
//~           // From dmitri_trembovetski at http://forums.sun.com/thread.jspa?threadID=757947&messageID=4330508
//~           ColorSpace cs = ColorSpace.getInstance(ColorSpace.CS_sRGB);
//~           int[] nBits = { 8 };
//~           ColorModel cm = new ComponentColorModel(cs, nBits, false, true,
//~               Transparency.OPAQUE, DataBuffer.TYPE_BYTE);
//~           SampleModel sm = cm.createCompatibleSampleModel(imageWidth, imageHeight);
//~           DataBufferByte db = new DataBufferByte(array, imageWidth * imageHeight);
//~           WritableRaster raster = Raster.createWritableRaster(sm, db, null);
//~           BufferedImage image = new BufferedImage(cm, raster, false, null);
          BufferedImage image = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_RGB);
//          image.setRGB(0, 0, imageWidth, imageHeight, thumbnailBytes, 0, imageWidth);
          return image;
        }
        else if (photometricInterpretation == ExifDirectory.PHOTOMETRIC_INTERPRETATION_YCBCR)
        {
          // YCbCr
//~           ColorSpace cs = ColorSpace.getInstance(ColorSpace.TYPE_YCbCr); // Wrong, I think...
          // TODO
          System.out.println("Unhandled YCbCr thumbnail");
          return null;
        }
        else if (photometricInterpretation == ExifDirectory.PHOTOMETRIC_INTERPRETATION_MONOCHROME)
        {
          // Monochrome
//~           ColorSpace cs = ColorSpace.getInstance(ColorSpace.CS_GRAY);
          // TODO
          System.out.println("Unhandled Monochrome thumbnail");
          return null;
        }
      }
      catch (Exception e)
      {
        System.out.println("Unable to extract thumbnail: " + e);
        return null;
      }
    }
    return bi;
  }
}
