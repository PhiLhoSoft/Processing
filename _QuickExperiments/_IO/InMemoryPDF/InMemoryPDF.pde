import processing.pdf.*;

PFont f;
int pageCount = 10;
int prevX;
PGraphics pdf;

void setup()
{
  size(400, 400);
  f = createFont("Arial", 72);
  prevX = width/2;
  pdf = createGraphics(400, 400, "processing.pdf.InMemoryPGraphicsPDF");
  pdf.beginDraw();
}

void draw()
{
  println("Making page " + frameCount);
  pdf.background(255);
  pdf.fill(#005500);
  pdf.stroke(#000055);
  pdf.strokeWeight(5);
  pdf.textFont(f, 72);
  int newX = int(random(0, width));
  // Draw something good here
  pdf.line(prevX, 0, newX, height);
  prevX = newX;
  pdf.text("Page " + frameCount, 100, 200);

  // When finished drawing, quit and save the file
  if (frameCount >= 10)
  {
    // Clean up phase
    pdf.dispose();
    pdf.endDraw();

    InMemoryPGraphicsPDF impgpdf = (InMemoryPGraphicsPDF) pdf;  // Get the real renderer
    byte[] pdfData = impgpdf.getBytes();
    println("Done: " + pdfData.length + " bytes");
    // Output file to disk, to examine it
    // Purpose is actually to serialize it over network
    try {
      FileOutputStream fos = new FileOutputStream("E:/temp/Output.pdf");
      BufferedOutputStream bos = new BufferedOutputStream(fos, 16384);
      bos.write(pdfData);
      bos.flush();
      bos.close();
    } catch (IOException ioe) {} // Not super clean but just ad hoc here
    
    exit();
  }
  else
  {
    PGraphicsPDF pdfg = (PGraphicsPDF) pdf;  // Get the renderer
    pdfg.nextPage();  // Tell it to go to the next page
  }
}
