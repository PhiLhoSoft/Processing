import java.awt.image.BufferedImage;

import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;

String pastedMessage;
PImage pastedImage;

void setup()
{
  size(800, 200);
  PFont f = createFont("Arial", 15);
  textFont(f);
}

void draw()
{
  background(255);
  for (int i = 0; i < width; i += 2)
  {
    float noiseVal = noise((i + mouseX) * 0.02, mouseY * 0.01);
    stroke(noiseVal * 256);
    line(i, 0, i, height);
  }
  if (pastedImage != null)
  {
    image(pastedImage, mouseX, mouseY);
  }
  if (pastedMessage != null)
  {
    fill(#008800);
    text(pastedMessage, mouseX, mouseY);
  }
}

void keyPressed()
{
  if (key == 0x16) // Ctrl+v
  {
    pastedMessage = GetTextFromClipboard();
    pastedImage = GetImageFromClipboard();
  }
  else if (key == 0x03) // Ctrl+c
  {
    SetImageToClipboard((BufferedImage) g.image);
  }
}

String GetTextFromClipboard()
{
  String text = (String) GetFromClipboard(DataFlavor.stringFlavor);
  return text;
}

PImage GetImageFromClipboard()
{
  PImage img = null;
  java.awt.Image image = (java.awt.Image) GetFromClipboard(DataFlavor.imageFlavor);
  if (image != null)
  {
    img = new PImage(image);
  }
  return img;
}

Object GetFromClipboard(DataFlavor flavor)
{
  Clipboard clipboard = getToolkit().getSystemClipboard();
  Transferable contents = clipboard.getContents(null);
  Object obj = null;
  if (contents != null && contents.isDataFlavorSupported(flavor))
  {
    try
    {
      obj = contents.getTransferData(flavor);
    }
    catch (UnsupportedFlavorException exu) // Unlikely but we must catch it
    {
      println("Unsupported flavor: " + exu);
//~       exu.printStackTrace();
    }
    catch (java.io.IOException exi)
    {
      println("Unavailable data: " + exi);
//~       exi.printStackTrace();
    }
  }
  return obj;
}

void SetImageToClipboard(Image image)
{
  ImageSelection imgSel = new ImageSelection(image);
  java.awt.Toolkit.getDefaultToolkit().getSystemClipboard().setContents(imgSel, null);
}

// http://www.exampledepot.com/egs/java.awt.datatransfer/ToClipImg.html
public static class ImageSelection implements Transferable 
{
  private Image m_image;

  public ImageSelection(Image image) 
  {
    m_image = image;
  }

  // Returns supported flavors
  public DataFlavor[] getTransferDataFlavors() 
  {
    return new DataFlavor[] { DataFlavor.imageFlavor };
  }

  // Returns true if flavor is supported
  public boolean isDataFlavorSupported(DataFlavor flavor) 
  {
    return DataFlavor.imageFlavor.equals(flavor);
  }

  // Returns image
  public Object getTransferData(DataFlavor flavor) throws UnsupportedFlavorException, IOException 
  {
    if (!isDataFlavorSupported(flavor)) 
    {
      throw new UnsupportedFlavorException(flavor);
    }
    return m_image;
  }
}


