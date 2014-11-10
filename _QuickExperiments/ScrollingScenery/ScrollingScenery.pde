final int GRID_SIZE = 20;
int halfScreen;

// Simple scenery definition, can be (must be!) most complex
int[] scenery = new int[200];

int currentPos;
int scrollPos = GRID_SIZE;

void setup()
{
  size(600, 200);
  
  for (int i = 0; i < scenery.length; i++)
  {
    if (random(1) > 0.85)
    {
      scenery[i] = int(random(height / GRID_SIZE));
    }
  }
  // Half screen in terms of grid size
  halfScreen = currentPos = width / GRID_SIZE / 2;
}

void draw()
{
  background(255);
  
  text(currentPos + " -- " + scrollPos, 10, 50);
  
  fill(#005588);
  for (int i = currentPos - halfScreen, j = 0; i < currentPos + halfScreen; i++, j++)
  {
    if (scenery[i] > 0)
    {
      rect(scrollPos + j * GRID_SIZE, height - scenery[i] * GRID_SIZE, 
          GRID_SIZE, height);
    }
  }
  fill(#AA8800);
  ellipse(width / 2, height / 2, 20, 10); // Character!
  
  scrollPos--;
  //scrollPos %= halfScreen;
  if (scrollPos == 0)
  {
    currentPos++;
    scrollPos = GRID_SIZE;
    if (currentPos == scenery.length - halfScreen)
      exit(); // End
  }
}


