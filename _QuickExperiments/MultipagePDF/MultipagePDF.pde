import processing.pdf.*;

PFont f;
int pageCount = 10;
int prevX;

void setup() {
  size(400, 400, PDF, "filename.pdf");
  f = createFont("Arial", 72);
  prevX = width/2;
}

void draw() {
  println("Making page " + frameCount);
  background(255);
  fill(#005500);
  stroke(#000055);
  strokeWeight(5);
  textFont(f, 72);
  int newX = int(random(0, width));
  // Draw something good here
  line(prevX, 0, newX, height);
  prevX = newX;
  text("Page " + frameCount, 100, 200);

  // When finished drawing, quit and save the file
  if (frameCount >= 10) {
    println("Done");
    exit();
  } else {
    PGraphicsPDF pdf = (PGraphicsPDF) g;  // Get the renderer
    pdf.nextPage();  // Tell it to go to the next page
  }
}


