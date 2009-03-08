PFont font = loadFont("AmericanTypewriter-24.vlw");    
boolean bDisplay;
PImage pi; // Background image
PImage piBack; // Off-screen graphic buffer
float tPosX = 80.0, tPosY = 80.0;

String textVar = "This is a multiline\nstring with some text\nas filler.";
float tSize = 16, tLead = 18;
float tW, tH, ttH;

void setup() {
  size(300, 300);
  background(128);
  smooth();
  pi = loadImage("../../Globe.png"); // Any graphic will do, this is to show it is hidden only by the real graphics
  image(pi, 0, 0); // Draw background on display

  textFont(font, tSize);
  textLeading(tLead);
  
  // Width of text
  tW = textWidth(textVar);
  // Height of a text line
  tH = textAscent() + textDescent();
  // Total height of the lines of text
  ttH = tLead * 3; // Three lines... Should be computed with number of \n
}

void draw() {
}

void mouseReleased() {
  bDisplay = !bDisplay;
  if (bDisplay) {
    piBack = get(int(tPosX), int(tPosY - tH), int(tW), int(ttH));

//    stroke(255, 0, 0);
//    line(tPosX - 20, tPosY, tPosX + 20, tPosY);
//    line(tPosX, tPosY - 20, tPosX, tPosY + 20);
    noStroke();
    fill(200, 0, 255);
    text(textVar, tPosX, tPosY);
//    fill(0, 0, 255, 20);
//    rect(tPosX, tPosY - tH, tW, ttH);
  } else {
    copy(piBack, 0, 0, int(tW), int(ttH), 
        int(tPosX), int(tPosY - tH), int(tW), int(ttH));
  }
}
