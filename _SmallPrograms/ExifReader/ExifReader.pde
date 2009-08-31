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

  String pictureFolder = selectFolder("Image Folder");

  if (pictureFolder == null)
  {
    println("Canceled");
    return;
  }
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
      println("\n" + pf);
      metadata = JpegMetadataReader.readMetadata(pf);
    }
    catch (JpegProcessingException ex)
    {
      println("Ouch! " + pf.getName());
    }
    if (metadata != null)
    {
      ExifProcessing.ShowInformation(metadata);
      ExifProcessing.WriteThumbnail(metadata, pf);
    }
  }
  exit();
}
