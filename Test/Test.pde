import processing.pdf.*;
boolean bool;
PFont font;
void setup() {
  size(512,512,PDF,"test.pdf");
  background(255);
  bool = true; 
  font = createFont("Arial",48);
  fill(0);
}
void draw() {
  if (bool) {
    beginRecord(PDF, "test.pdf");
    textFont(font);
  }
  text("Hello!",200,200);
  if (bool) {
    endRecord();
    bool = false;
  }
}

