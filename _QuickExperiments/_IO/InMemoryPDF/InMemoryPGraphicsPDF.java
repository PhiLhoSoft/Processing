package processing.pdf;

import java.io.*;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

import processing.core.*;
import processing.pdf.*;

/*
Various problems with PGraphicsPDF, perhaps to be fixed in a future version:
- File temp isn't used, should be removed.
- Fields are package protected. Perhaps they should be just 'protected'. It would ease overriding.
- beginDraw() doesn't check if 'file' field is not null. Should issue a meaningful error message if not.
- beginDraw() relies on 'file' existence.
Perhaps we should put:
        FileOutputStream fos = new FileOutputStream(file);
        BufferedOutputStream bos = new BufferedOutputStream(fos, 16384);
lines after 'file' creation and have a generic OutputStream as field, instead.
If beginDraw() uses this OutputStream, it would allow more flexibility in output.
*/
public class InMemoryPGraphicsPDF extends PGraphicsPDF
{
  protected OutputStream outStream;
  protected void allocate() // Called by PGraphics in setSize()
  {
    outStream = new ByteArrayOutputStream(16384);
  }
  public void beginDraw() {
    if (document == null) {
      document = new Document(new Rectangle(width, height));
      try {
        writer = PdfWriter.getInstance(document, outStream);
        document.open();
        content = writer.getDirectContent();
      } catch (Exception e) {
        e.printStackTrace();
        throw new RuntimeException("Problem saving the PDF file.");
      }
      mapper = new DefaultFontMapper();
      if (PApplet.platform == PApplet.MACOSX) {
        try {
          String homeLibraryFonts =
            System.getProperty("user.home") + "/Library/Fonts";
          mapper.insertDirectory(homeLibraryFonts);
        } catch (Exception e) {
        }
        mapper.insertDirectory("/System/Library/Fonts");
        mapper.insertDirectory("/Library/Fonts");
      } else if (PApplet.platform == PApplet.WINDOWS) {
        File roots[] = File.listRoots();
        for (int i = 0; i < roots.length; i++) {
          if (roots[i].toString().startsWith("A:")) {
            continue;
          }
          File folder = new File(roots[i], "WINDOWS/Fonts");
          if (folder.exists()) {
            mapper.insertDirectory(folder.getAbsolutePath());
            break;
          }
          folder = new File(roots[i], "WINNT/Fonts");
          if (folder.exists()) {
            mapper.insertDirectory(folder.getAbsolutePath());
            break;
          }
        }
      }
      g2 = content.createGraphics(width, height, mapper);
    }
    super.beginDraw();
  }
  public byte[] getBytes() {
    return ((ByteArrayOutputStream) outStream).toByteArray();
  }
}
