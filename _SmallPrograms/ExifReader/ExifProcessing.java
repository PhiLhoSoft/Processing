import java.util.*;
import java.io.*;

import java.awt.*;
import java.awt.image.*;


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
}
