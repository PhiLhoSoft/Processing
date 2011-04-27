// http://forum.processing.org/topic/new-to-processing-advice-needed-on-animating-data-as-drops-of-liquid

color[] orderTypes = { #FF0000, #FFFF00, #00FF00, #00FFFF, #0000FF };
float MIN_VAL = 10;
float MAX_VAL = 2000;

ArrayList<Drop> drops = new ArrayList<Drop>();
Layers layers = new Layers();

void setup()
{
  size(800, 600);
  smooth();
}

void draw()
{
  background(255);
  checkData();
  updateAnimation();
}

void checkData()
{
  float rnd = random(1000);
  if (rnd > 25)
    return; // No new data...

  // Get value from database
  float val = map(random(100), 0, 100, MIN_VAL, MAX_VAL);
  // And get data type too
  int type = int(random(0, orderTypes.length));
  Drop drop = new Drop(val, type);
  drops.add(drop);
}

void updateAnimation()
{
  // Need an iterator to allow removing while iterating
  for (Iterator<Drop> iter = drops.iterator(); iter.hasNext(); )
  {
    Drop drop = iter.next();
    drop.update();
    drop.display();
    if (drop.y > height - layers.totalHeight)
    {
      layers.add(drop);
      iter.remove();
    }
  }
  layers.display();
}

class Drop
{
  int x, y;
  float speed;
  float radius;
  color colorType;

  final static int MIN_RADIUS = 10;
  final static int MAX_RADIUS = 50;

  Drop(float val, int type)
  {
    radius = map(val, MIN_VAL, MAX_VAL, MIN_RADIUS, MAX_RADIUS);
    colorType = orderTypes[type];
    y = 0;
    x = int(radius + random(0, width - 2 * radius));
    speed = 3;
  }

  void update()
  {
    y += speed;
  }

  void display()
  {
    noStroke();
    fill(colorType);
    ellipse(x, y, radius, radius);
  }
}

class Layers
{
  ArrayList<LiquidLayer> layers = new ArrayList<LiquidLayer>();
  float totalHeight;

  Layers()
  {

  }

  void add(Drop drop)
  {
    boolean bUpdated = false;
    for (LiquidLayer ll : layers)
    {
      if (ll.colorType == drop.colorType)
      {
        ll.add(drop);
        bUpdated = true;
        break;
      }
    }
    if (!bUpdated)
    {
      LiquidLayer ll = new LiquidLayer(drop.colorType);
      ll.add(drop);
      layers.add(ll);
    }
  }

  void display()
  {
    totalHeight = 0;
    println("---");
    for (LiquidLayer ll : layers)
    {
      ll.display(totalHeight);
      totalHeight += ll.level;
    }
  }
}

class LiquidLayer
{
  float level;
  color colorType;

  LiquidLayer(color type)
  {
    colorType = type;
  }

  void add(Drop drop)
  {
    level += drop.radius / drop.MIN_RADIUS;
  }

  void display(float pos)
  {
    noStroke();
    fill(colorType);
    rect(0, height - pos - level, width, level);
  }
}

