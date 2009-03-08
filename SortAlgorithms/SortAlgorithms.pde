static final int LARGE_PRIME = 444443;

static final int ITEM_NB = 128;

int[] values = new int[ITEM_NB];
Item[] items = new Item[ITEM_NB];

void setup()
{
  size(1000, 500);
  smooth();

}

void draw()
{
}

void mousePressed()
{
}

void mouseMoved()
{
}

void GenerateValues()
{
  for (int iterator = 0, value = 0; iterator < ITEM_NB; iterator++)
  {
    value = (value + LARGE_PRIME) % ITEM_NB;
    values[i] = value;
  }
}

class Item
{
  static int RADIUS = 8;
  static int MARGIN = 2;
  static int ITEM_VPOS = RADIUS + MARGIN;

  color itemColor;
  int itemPos;

  void Item(color c, int p)
  {
    itemColor = c;
    itemPos = p;
  }

  void draw()
  {
    fill(itemColor);
    noStroke();
    circle(itemPos * (RADIUS + MARGIN), ITEM_VPOS, RADIUS * 2, RADIUS * 2);
  }
}

