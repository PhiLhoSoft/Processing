// https://forum.processing.org/topic/mouse-over-and-show-image

PImage bg, bgMask, face;
color[] buildingColors = { #FF0000, #FFFF00, #00FF00, #0000FF, #00FFFF, #FFFFFF }; // And so on
int[][] faceCoord =
{
  { 63, 326 }, // x in faceCoord[i][0], y in faceCoord[i][1]
  { 295, 326 },
  { 548, 326 },
  { 129, 573 },
  { 352, 573 },
  { 552, 573 },
};
int[] facePosition;

void setup() 
{
  size(800, 900); // Always first call!
  bg = loadImage("building.png"); 
  bgMask = loadImage("buildingMap.png");
  face = loadImage("face.png");
}

void draw() 
{
  background(250);
  image(bg, 0, 0);
  if (facePosition != null)
  {
    image(face, facePosition[0], facePosition[1] - face.height);
  }
}

void mousePressed()
{
  color now = bgMask.get(mouseX, mouseY);
  facePosition = null;
  for (int i = 0; i < buildingColors.length; i++)
  {
    color c = buildingColors[i];
    if (c == now)
    {
      // Found
      facePosition = faceCoord[i];
    }
  }
}

