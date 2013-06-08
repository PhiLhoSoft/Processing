int buttonWidth = 200;
int buttonHeight = 75;
int buttonX = 20;
int buttonY = 20;

boolean selected;
File selectedFile;
 
void setup()
{
  size(500, 500);
  smooth();
  
  selectInput("Select a file to process", "fileSelected");
}
 
void draw()
{
  background(#AACCFF);
  
  if (!selected)
  {
    fill(#FF5500);
    textSize(20);
    text("Please, choose a text file", 10, 50);
    return; // Don't do anything until a file is selected
  }
   
  // Normal program 
  boolean over = mouseX > buttonX && mouseX < buttonX + buttonWidth &&
      mouseY > buttonY && mouseY < buttonY + buttonHeight;
      
  drawButtonBackground(buttonX, buttonY, over);
  noFill();
  stroke(0);
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
}
 

void drawButtonBackground(int x, int y, boolean light)
{
  color topColor = #AA5500;
  color bottomColor = #0055AA;
  if (light)
  {
    topColor = #FF5500;
    bottomColor = #0055FF;
  }
  for (int line = 0; line < buttonHeight; line++)
  {
    color sc = lerpColor(topColor, bottomColor, (float) line / buttonHeight);
    stroke(sc);
    line(x, y + line, x + buttonWidth - 1, y + line);
  }
}

void fileSelected(File selection) 
{
  selectedFile = selection;

  if (selection == null) 
  {
    println("Window was closed or the user hit cancel.");
    exit();
  } 
  else 
  {
    println("User selected " + selection.getAbsolutePath());
    selected = true;
  }
}

