import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;

String pastedMessage;
PImage pastedImage;

void setup()
{
  size(800, 200);
  PFont f = createFont("Arial", 12);
  textFont(f);
}

void draw()
{
  background(255);
  if (pastedImage != null)
  {
    image(pastedImage, 5, 5);
  }
  if (pastedMessage != null)
  {
    fill(#008800);
    text(pastedMessage, 5, 15);
  }
}

void keyPressed()
{
  if (key == 0x16) // Ctrl+v
  {
    pastedMessage = GetTextFromClipboard();
    pastedImage = GetImageFromClipboard();
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
