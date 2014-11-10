PImage img; 
boolean fileSelected;
String path;
java.awt.Insets insets;

void setup() 
{
  size(400, 400);
  frame.pack();
  insets = frame.getInsets();
  //  frame.setResizable(true); 
  selectImage();
}

void draw() 
{
  if (fileSelected) 
  {
    img = loadImage(path);
    size(img.width, img.height);

    int ww = Math.max(width, MIN_WINDOW_WIDTH) + insets.left + insets.right;
    int wh = Math.max(height, MIN_WINDOW_HEIGHT) + insets.top + insets.bottom;
    frame.setSize(ww, wh);
    frame.toFront();
    fileSelected = false;
  }
  if (img != null)
  {
    image(img, 0, 0);
  }
}

void fileSelected(File selection) 
{
  if (selection != null) 
  {
    path = selection.getAbsolutePath();
    fileSelected = true;
    println("User selected " + selection.getAbsolutePath());
  }
}

void keyPressed() 
{
  if (key == ' ') selectImage();
}

void selectImage()
{
  selectInput("Select a file to process:", "fileSelected");
}
