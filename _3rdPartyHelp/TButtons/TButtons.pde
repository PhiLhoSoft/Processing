// http://forum.processing.org/topic/tbutton-v0-11
// http://bwong.ca/TButton_01.html
PFont fontA;
// Default button
TButton tbd;
TButton tb0;
TButton tb1;
color bgc = #000000;

void setup() {
  size(300, 400);
  smooth();
  // Just to avoid creating the vlw file...
  // Not perfect as the text font is global to the whole sketch.
  fontA = createFont("Calibri", 16);
  textFont(fontA, 16);

  tbd = new TButton("Default Button");
  tbd.setPosition(149, 300);

  tb0 = new TButton("TButton v0.11");
  tb0.setPosition(149, 99);
  tb0.setWidth(130).setHeight(28);
  // Default bevel size, don't change it
  tb0.setBackColor(#888888).setOverBackColor(#889977).setPressBackColor(#667755);
  tb0.setTextColor(#004400).setOverTextColor(#880000).setPressTextColor(#665577);

  tb1 = new TButton("by Brian Wong");
  tb1.setPosition(149, 199);
  tb1.setWidth(130).setHeight(28);
  tb1.setBevelSize(10).setPressBevelSize(7);
  tb1.setBackColor(#778899).setOverBackColor(#887799).setPressBackColor(#550000);
  tb1.setTextColor(#000066).setOverTextColor(#dddd00).setPressTextColor(#aaaa00);
}

boolean bDefaultActive;
void draw() {
  background(bgc);

  boolean buttonClicked0 = tb0.update();
  // Some people will prefer to  write if (tb0.update()) {
  // but having a separate variable makes easier to debug or print out its value,
  // and update() doesn't sound "natural" as a boolean value.
  if (buttonClicked0) {
    if (bgc == 0) {
      bgc = 255;
    } else  {
      bgc = 0;
    }
    swapButtons();
  }

  boolean buttonClicked1 = tb1.update();
  if (buttonClicked1) {
    if (bgc == #abcdef) {
      bgc = 0;
    } else  {
      bgc = #abcdef;
    }
    swapButtons();
  }

  boolean buttonClickedDefault = tbd.update();
  color c = #55FFAA;
  if (buttonClickedDefault) {
    bDefaultActive = !bDefaultActive; // Toggle it
  }
  if (bDefaultActive) {
    c = #FF55AA;
  }
  fill(c);
  // Note this ellipse has a stroke!
  ellipse(tbd.buttonX + tbd.buttonWidth, tbd.buttonY, tbd.buttonHeight, tbd.buttonHeight);
}

void swapButtons() {
  int px = tb0.buttonX;
  int py = tb0.buttonY;
  tb0.setPosition(tb1.buttonX, tb1.buttonY);
  tb1.setPosition(px, py);
}

class TButton {
  String buttonText;
  // Trying to set sensible default values, so that if setter isn't called, button still looks good
  int buttonWidth = 130;
  int buttonHeight = 30;
  int buttonX;
  int buttonY;
  // Avoid most abbreviations in identifier names: they don't save that much keystrokes,
  // even less with good text editors/IDEs. And they introduce confusion (col = color or column?)
  // and reduce readability.
  color bgColor = #C0C0C0; // BG is quite usual and not so much ambiguous
  color textColor = #000000;
  color bgOverColor = #D0D0E0;
  color textOverColor = #555555;
  int bevelSize = 5;
  int bevelPressSize = 3;
  color bgPressColor = #D0B0B0;
  color textPressColor = #775555;

  // Make it non accessible from outside
  private boolean buttonPressed;

  public TButton(String bt) {
    buttonText = bt;
  }
  // Define the setters.
  // The traditional way is to just make them void and just set the value in it,
  // but an useful extension is to make them return the object itself, allowing a nice chaining of calls.
  public TButton setHeight(int bh) {
    buttonHeight = bh;
    return this;
  }
  public TButton setWidth(int bw) {
    buttonWidth = bw;
    return this;
  }
  public TButton setBackColor(int bc) {
    bgColor = bc;
    return this;
  }
  public TButton setOverBackColor(int bc) {
    bgOverColor = bc;
    return this;
  }
  public TButton setPressBackColor(int bc) {
    bgPressColor = bc;
    return this;
  }
  public TButton setTextColor(int tc) {
    textColor = tc;
    return this;
  }
  public TButton setOverTextColor(int tc) {
    textOverColor = tc;
    return this;
  }
  public TButton setPressTextColor(int tc) {
    textPressColor = tc;
    return this;
  }
  public TButton setBevelSize(int bs) {
    bevelSize = bs;
    return this;
  }
  public TButton setPressBevelSize(int bs) {
    bevelPressSize = bs;
    return this;
  }

  public boolean update() {
    boolean buttonClicked = false;
    if (mouseX > buttonX - buttonWidth/2 - bevelSize &&
        mouseX < buttonX + buttonWidth/2 + bevelSize &&
        mouseY > buttonY - buttonHeight/2 - bevelSize &&
        mouseY < buttonY + buttonHeight/2 + bevelSize) {
      if (!buttonPressed && mousePressed) {
        buttonPressed = true;
      }
      if (buttonPressed && !mousePressed) {
        buttonPressed = false;
        buttonClicked = true;
      }
      if (buttonPressed && mousePressed) {
        bevel(bgPressColor, textPressColor, bevelPressSize);
      } else {
        bevel(bgOverColor, textOverColor, bevelSize);
      }
    } else {
      buttonPressed = false;
      bevel(bgColor, textColor, bevelSize);
    }
    return buttonClicked;
  }

  private void bevel(int bcol, int tcol, int bevelSize) {
    pushStyle();
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    noStroke();

    fill(bcol, 255);
    rect(buttonX, buttonY, buttonWidth + bevelSize * 2, buttonHeight + bevelSize * 2);
    fill(tcol, 255);
    text(buttonText, buttonX, buttonY);
    fill(bgColor);
    if (bevelSize > 0) {
      int hbh = buttonHeight / 2; // Half Button Height...
      int hbw = buttonWidth / 2; // Guess...
      int hbhB = hbh + bevelSize;
      int hbwB = hbw + bevelSize;
      fill(255, 60);
      quad(buttonX - hbwB, buttonY - hbhB,
          buttonX + hbwB, buttonY - hbhB,
          buttonX + hbw, buttonY - hbh,
          buttonX - hbw, buttonY - hbh);
      fill(255, 26);
      quad(buttonX + hbwB, buttonY - hbhB,
          buttonX + hbwB, buttonY + hbhB,
          buttonX + hbw, buttonY + hbh,
          buttonX + hbw, buttonY - hbh);
      fill(0, 60);
      quad(buttonX + hbw, buttonY + hbh,
          buttonX + hbwB, buttonY + hbhB,
          buttonX - hbwB, buttonY + hbhB,
          buttonX - hbw, buttonY + hbh);
      fill(0, 26);
      quad(buttonX - hbw, buttonY + hbh,
          buttonX - hbwB, buttonY + hbhB,
          buttonX - hbwB, buttonY - hbhB,
          buttonX - hbw, buttonY - hbh);
    }
    popStyle();
  }

  public void setPosition(int mx, int my) {
    buttonX = mx;
    buttonY = my;
  }
}

void keyPressed() {
  if (key == ESC) {
    key = 0;
  }
}
