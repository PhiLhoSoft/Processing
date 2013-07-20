import java.io.*;
import java.awt.image.BufferedImage;

final String path = "G:/Musique/_Anime/Higurashi no Naku Koro ni - Dear you -Thanks-.mp3";
PImage mp3Image;

void setup()
{
  size(800, 800);

  final String path = "G:/Musique/_Anime/Iggy Pop - Monster Men (Les Zinzins de l'espace).mp3";
  File file = new File(path);
  try
  {
    InputStream is = new FileInputStream(file);
    BufferedImage image = getID3Image(is);
    is.close();
    if (image != null)
    {
      mp3Image = new PImage(image.getWidth(), image.getHeight(), PConstants.ARGB);
      image.getRGB(0, 0, mp3Image.width, mp3Image.height, mp3Image.pixels, 0, mp3Image.width);
      mp3Image.updatePixels();
    }
  }
  catch (IOException e)
  {
    println(e);
  }
}

void draw()
{
  background(255);
  image(mp3Image, 0, 0);
}

// Adapted from http://supportforums.blackberry.com/t5/Java-Development/how-to-retrieve-ID3-art-Image-from-an-mp3-file/m-p/358490#M67015
// Minor fixes / improvements, and getting rid of the RIM Blackberry dependency.
public BufferedImage getID3Image(InputStream dataStream)
throws UnsupportedEncodingException, IOException
{
  /*---------------------------
   * ID3 v1 tags cannot contain images, so no need to process them.
   * ID3 v1 tags are also placed at the end of the MP3 so checking the beginning of the file won't do anything useful.
   *---------------------------
   */

  // Read the tags, searching for the album artwork
  long currentPosition = 0;
  byte[] imageData = null;
  String mimeType = null;

  byte[] buffer = new byte[10];
  if (dataStream.read(buffer, 0, 10) != 10 || !(new String(buffer, 0, 3).equals("ID3")))
  {
    // Not on start of ID3 data, nothing to find, just don't try
    return null;
  }
  currentPosition += 10;
  // Found a ID3 version 2 or greater tag

  // Now to actually parse a tag
  int majorVersion = buffer[3] & 0xFF;
  byte minorVersion = buffer[4];
  byte[] destinationArray = new byte[4];
  System.arraycopy(buffer, 6, destinationArray, 0, 4);
  // Read a 28-bit int for size
  int size = read28bit(destinationArray);
  long end = currentPosition + size;
  long dataLength = end - 11L;

  boolean v2_2 = false;
  if (majorVersion == 2)
  {
    // ID3 v2.2
    v2_2 = true;
  }
  else if (majorVersion == 3 || majorVersion == 4)
  {
    // ID3 v2.3 / ID3 v2.4

      // Extra data seems might exist, go through
    boolean hasExtendedHeader = (buffer[5] & 0x40) == 0x40;
    if (hasExtendedHeader)
    {
      byte[] extendedHeaderBuffer = new byte[4];
      dataStream.read(extendedHeaderBuffer, 0, 4);
      currentPosition += 4;
      int extendedHeaderLength = read32bit(extendedHeaderBuffer);
      byte[] extendedHeaderData = new byte[extendedHeaderLength + 4];
      System.arraycopy(extendedHeaderBuffer, 0, extendedHeaderData, 4, extendedHeaderLength);
      dataStream.read(extendedHeaderData, 4, extendedHeaderLength);
      currentPosition += extendedHeaderLength;
      // No use for this data in the picture so just ignore it
    }
    v2_2 = false;
  }

  while (currentPosition < dataLength)
  {
    // Get the frame header and make sure that it is a valid frame.
    byte[] frameBuffer = new byte[v2_2 ? 6 : 10];
    if (dataStream.read(frameBuffer, 0, frameBuffer.length) != frameBuffer.length || (frameBuffer[0] & 0xFF) <= 0)
      break;

    currentPosition += frameBuffer.length;
    String frameId = new String(frameBuffer, 0, v2_2 ? 3 : 4);
    destinationArray = new byte[v2_2 ? 3 : 4];
    System.arraycopy(frameBuffer, destinationArray.length, destinationArray, 0, destinationArray.length);
    int frameSize = 0;
    switch (majorVersion)
    {
    case 2:
      // 24-bit
      frameSize = read24bit(destinationArray);
      break;
    case 3:
      // 32-bit
      frameSize = read32bit(destinationArray);
      break;
    case 4:
      // 28-bit
      frameSize = read28bit(destinationArray);
      break;
    default:
      continue;
    }
    // Now read the data and check to see if it is a picture
    frameBuffer = new byte[frameSize];
    if (dataStream.read(frameBuffer, 0, frameSize) == frameSize)
    {
      currentPosition += frameSize;
      if (frameId.equals("PIC") || frameId.equals("APIC"))
      {
        // Got the frame data
        int refPoint = 0;
        // First we get the encoding type
        int encodingType = (frameBuffer[refPoint++] & 0xFF); // 0=ISO-8859-1, 1=UTF-16, 2=UTF-16BE, 3=UTF-8
        if (encodingType < 0 || encodingType > 3)
          // Do we need to stop reading the image because we can't get the description?
          // On the other hand, it should not happen anyway, perhaps the data is corrupt?
          throw new UnsupportedEncodingException("Cannot get picture description. Frame Encoding is invalid.");

        // Second we get the mime type
        int indexPoint = refPoint;
        while (frameBuffer[refPoint++] != 0)
          ;
        int mimeLength = refPoint - indexPoint;
        if (mimeLength > 1)
        {
          mimeType = new String(frameBuffer, indexPoint, mimeLength - 1);
        }

        // Third we get the picture type
        int pictureType = frameBuffer[refPoint++] & 0xFF;

        // Fourth we load the picture description
        // Check length
        int scanPoint = refPoint;
        switch (encodingType)
        {
        case 0:
        case 3:
          // 8-bit string
          while (scanPoint < frameBuffer.length && frameBuffer[scanPoint++] != 0)
            ;
          break;
        case 1:
        case 2:
          // 16-bit string
          do
          {
            byte b1 = frameBuffer[scanPoint++];
            byte b2 = frameBuffer[scanPoint++];
            if (b1 == 0 && b2 == 0)
              break;
          } 
          while (scanPoint < frameBuffer.length - 1);
          break;
        }
        // And read the string
        int descriptionLength = scanPoint - refPoint;
        byte[] descriptionBuffer = new byte[descriptionLength];
        int pos = 0;
        switch (encodingType)
        {
        case 0:
        case 3:
          // 8-bit string
          while (pos < descriptionLength)
          {
            descriptionBuffer[pos++] = frameBuffer[refPoint++];
          }
          break;
        case 1:
        case 2:
          // 16-bit string
          do
          {
            byte b1 = frameBuffer[refPoint++];
            byte b2 = frameBuffer[refPoint++];
            if (encodingType == 1 && b1 == 0xFF && b2 == 0xFE)
              continue; // Skip BOM

            descriptionBuffer[pos++] = b1;
            descriptionBuffer[pos++] = b2;
          } 
          while (pos < descriptionLength);
          break;
        }

        String encoding = null;
        switch (encodingType)
        {
        case 0:
          encoding = "ISO-8859-1";
          break;
        case 1:
          encoding = "UTF-16";
          break;
        case 2:
          encoding = "UTF-16BE";
          break;
        case 3:
          encoding = "UTF-8";
          break;
        }
        String description = new String(descriptionBuffer, encoding);

        // Finally, THE MAIN EVENT, the image data
        int imageSize = frameBuffer.length - refPoint;
        imageData = new byte[imageSize];
        System.arraycopy(frameBuffer, refPoint, imageData, 0, imageSize);
        break;
      }
    }
  }

  if (imageData != null)
  {
    InputStream imageStream = new ByteArrayInputStream(imageData);
    BufferedImage image = javax.imageio.ImageIO.read(imageStream);
    imageStream.close();
    return image;
  }
  // No image found
  return null;
}

private final int read32bit(byte[] data)
{
  return
    ((data[0] & 0xFF) << 24) |
    ((data[1] & 0xFF) << 16) |
    ((data[2] & 0xFF) <<  8) |
    (data[3] & 0xFF);
}

private final int read28bit(byte[] data)
{
  return
    ((data[0] & 0xFF) << 21) |
    ((data[1] & 0xFF) << 14) |
    ((data[2] & 0xFF) <<  7) |
    (data[3] & 0xFF);
}

private final int read24bit(byte[] data)
{
  return
    ((data[1] & 0xFF) << 16) |
    ((data[2] & 0xFF) <<  8) |
    (data[3] & 0xFF);
}

