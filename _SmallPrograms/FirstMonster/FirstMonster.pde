Monster monster;
PVector axis = new PVector(10, 0);

void setup()
{
  size(400, 400);
  monster = new Monster();
}

void draw()
{
  background(255);
  monster.update();
  monster.display();
}

void mousePressed()
{
//  startX = mouseX; startY = mouseY;
}

void mouseReleased()
{
//  float radius = sqrt(sq(startX - mouseX) + sq(startY - mouseY));
//  Spherize(startX, startY, int(radius));
}

class Monster
{
  int posX, posY;
  float radiusMin, radiusMax;
  float angleIncrementMin, angleIncrementMax;

  Monster()
  {
    posX = width / 2;
    posY = height / 2;
    radiusMax = width / 3;
    radiusMin = radiusMax * 0.80;
//~     angleIncrementMin = PI/877;
//~     angleIncrementMax = PI/617;
    angleIncrementMin = PI/87;
    angleIncrementMax = PI/61;
  }

  void update()
  {
    posX = mouseX;
    posY = mouseY;
  }

  void display()
  {
    fill(0);
    float angle = 0;
    pushMatrix();
    translate(posX, posY);
    beginShape();
    do
    {
      angle += random(angleIncrementMin, angleIncrementMax);
      float radius = random(radiusMin, radiusMax);
      float x = radius * cos(angle);
      float y = radius * sin(angle);
      vertex(x, y);
    } while (angle < TWO_PI);
    endShape(CLOSE);
    popMatrix();
  }
}

