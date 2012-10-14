// https://forum.processing.org/topic/view-a-pdf

import org.apache.pdfbox.*;
import org.apache.pdfbox.pdmodel.*;

import java.awt.image.BufferedImage;

void setup()
{
  size(800, 800);
  background(#F0F8FF);
  
  InputStream inputStream = createInput("G:/Downloads/PDF Samples/example_001.pdf");
  PDDocument doc = null;
  try 
  {
    doc = PDDocument.load(inputStream);
    final PDPage page = (PDPage) doc.getDocumentCatalog().getAllPages().get(0);
  
    PipedInputStream pis = new PipedInputStream();
    final PipedOutputStream pos = new PipedOutputStream(pis);
    BufferedImage bi = page.convertToImage(BufferedImage.TYPE_INT_ARGB, 120);
    println("Conversion done");
    PImage image = new PImage(bi);
    image(image, 0, 0);
  }
  catch (Exception e)
  {
    e.printStackTrace();
  }
  finally 
  {
    if (doc != null) 
    {
      try { doc.close(); } 
      catch (IOException e) { println("Problem when closing doc: " + e.getMessage()); }
    }
  }
}

