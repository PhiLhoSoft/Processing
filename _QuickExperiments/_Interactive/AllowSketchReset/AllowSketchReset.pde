final int ITEM_NB = 25;

PImage bg;

int itemMarginX, itemMarginY, itemSize;
color[] colors = new color[ITEM_NB];
int[] sizes = new int[ITEM_NB];
int itemNb = ITEM_NB - 1; // Current number

void setup() 
{
  size(700, 500);
  
  bg = loadImage("Tree.jpg");
  itemMarginX = (width - bg.width) / 2;
  itemMarginY = (height - bg.height) / 2;
  itemSize = width - 2 * itemMargin; 
  
  for (int i = 0; i < ITEM_NB; i++)
  {
    colors[i] = color(int(random(255)), int(random(255)), int(random(255)));
    sizes[i] = int(random(10, 30));
  }
  noStroke();
}

void draw() 
{
  background(200);
  image(bg, itemMarginX, itemMarginY); // Center
  
  int position = height - itemMarginY;
  for (int i = 0; i < itemNb; i++)
  {
    fill(colors[i]);
    rect(itemMargin, position - sizes[i], itemSize, sizes[i]);
    position -= sizes[i];
  } 
}

void keyPressed()
{
  if (key == 'r') // Reset
  {
    initSketch();
  }
}

void mousePressed()
{
}

void initSketch()
{
}


