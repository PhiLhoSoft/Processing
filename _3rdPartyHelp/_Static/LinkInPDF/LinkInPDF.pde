import processing.pdf.*;

import java.awt.Color;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

void setup()
{
  size(400, 400, "SpecialPGraphicsPDF", "H:/Temp/Test.pdf");
  // draw something in the background
  for (int i = 0; i < height; i += 10) {
    line(0, 0, width, i);
    line(width, height, 0, i);
  }
  // build hyperlinks for these del.icio.us users
  String[] users = new String[] {
    "adm",
    "blackbeltjones",
    "d3",
    "garuda",
    "golan",
    "hahakid",
    "jbleecker",
    "lennyjpg",
    "reas",
    "toxi"
  };
  try {
    for (int i = 0; i < users.length; i++) {
      // java colours are normalized 0.0 .. 1.0
      Color linkCol = new Color(random(1), random(1), random(1));
      Chunk c = new Chunk(users[i], FontFactory.getFont(FontFactory.HELVETICA, 14, Font.UNDERLINE, linkCol));
      c.setBackground(new Color(0, 0, 0), 5, 5, 5, 5);
      c.setAnchor("http://del.icio.us/" + users[i]);
      // this is using a hacked version of PGraphicsPDF to get access to the PDF content
      PdfContentByte cb = ((SpecialPGraphicsPDF) g).getContent();
      ColumnText ct = new ColumnText(cb);
      float x = random(width-100);
      float y = random(height-100);
      ct.setSimpleColumn(new Phrase(c), x, y, x+100, y+50, 16, Element.ALIGN_CENTER);
      ct.go();
    }
  }
  catch(Exception e) {
    e.printStackTrace();
  }
  exit();
}
