// http://forum.processing.org/two/discussion/326/hyperlink-in-pdf-export

import processing.pdf.*;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;

import com.lowagie.text.Anchor;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.html.HtmlWriter;
import com.lowagie.text.pdf.PdfWriter;

PGraphicsPDF pdf;

void setup() {
  PGraphics pdf = createGraphics(512, 512, "ExtendedPDF", "H:/Temp/test.pdf");

  ExtendedPDF p = (ExtendedPDF) pdf;

  beginRecord(p);

  Document document = p.getDocument();

  try {

    Font font1 = FontFactory.getFont(FontFactory.TIMES_ROMAN, 12, Font.NORMAL, Color.BLACK);
    Font font2 = FontFactory.getFont(FontFactory.HELVETICA, 11, Font.UNDERLINE, new Color(0, 0, 255));
    Paragraph paragraph = new Paragraph("Please visit my ", font1);
    Anchor anchor = new Anchor("website (external reference)", font2);
    anchor.setReference("http://www.java2s.com");
    paragraph.add(anchor);

    document.add(paragraph);
    document.add(paragraph);
    document.add(paragraph);
    anchor.setReference("http://www.processing.org");
    document.add(paragraph);
  } 
  catch (Exception e) {
  }

  endRecord();
  println("Done");
  exit();
}

