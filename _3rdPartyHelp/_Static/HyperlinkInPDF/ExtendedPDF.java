import processing.core.*;
import processing.pdf.*;
 
public class ExtendedPDF extends PGraphicsPDF {
 
  com.lowagie.text.Document getDocument(){
    return document;
  }
 
}

