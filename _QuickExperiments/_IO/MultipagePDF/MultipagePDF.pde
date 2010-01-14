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
  pdf = createGraphics(400, 400, PDF, "multipage.pdf");
  pdf.beginDraw();
  
  String[] fonts = ((PGraphicsPDF) pdf).listFonts();
  for (int i = 0; i < fonts.length; i++)
  {
    println(fonts[i]);
  }
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
    println("Done");
    pdf.dispose();
    pdf.endDraw();
    exit();
  } 
  else 
  {
    PGraphicsPDF pdfg = (PGraphicsPDF) pdf;  // Get the renderer
    pdfg.nextPage();  // Tell it to go to the next page
  }
}


