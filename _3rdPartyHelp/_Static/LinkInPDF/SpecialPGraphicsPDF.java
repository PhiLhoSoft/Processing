import processing.core.*;
import processing.pdf.*;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

public class SpecialPGraphicsPDF extends PGraphicsPDF
{
//~   @Override
//~   protected void allocate() // Called by PGraphics in setSize()
//~   {
//~     output = new ByteArrayOutputStream(16384);
//~   }
  public PdfContentByte getContent()
  {
    return content;
  }
}

