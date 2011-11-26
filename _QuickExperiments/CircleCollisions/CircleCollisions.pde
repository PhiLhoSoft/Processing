final int BALL_NB = 1000;
final int MARGIN = 50;
Ball[] balls = new Ball[BALL_NB];

java.awt.Image back;

public void paint(java.awt.Graphics g)
{
  java.awt.Graphics fg = frame.getGraphics();
  fg.drawImage(back, 0, 0, null);
  super.paint(g);
}

void setup()
{
  size(800, 800);
  smooth();

  for (int i = 0; i < BALL_NB; i++)
  {
    float x = random(MARGIN, width - MARGIN);
    float y = random(MARGIN, height - MARGIN);
    color c = color(random(50, 150), random(100, 200), random(150, 255));
    balls[i] = new Ball(x, y, c);
  }
  
  PImage backImg = loadImage("G:/Images/backdrop.png");
  back = backImg.getImage();
}

void draw()
{
  boolean bOneCanGrow = false;
  for (int i = 0; i < BALL_NB; i++)
  {
    for (int j = 0; j < BALL_NB; j++)
    {
      if (i != j)
      {
        if (dist(balls[i].posX, balls[i].posY, balls[j].posX, balls[j].posY) <=
            balls[i].radius + balls[j].radius)
        {
          balls[i].bCanGrow = balls[j].bCanGrow = false;
        }
      }
    }
    if (balls[i].bCanGrow)
    {
      bOneCanGrow = true;
    }
  }
  if (bOneCanGrow)
  {
    background(#AAFFEE);
  }
  else
  {
    background(#EEFFEE);
  }
  for (int i = 0; i < BALL_NB; i++)
  {
    balls[i].Grow();
    balls[i].Display();
  }
}

class Ball
{
  float posX, posY; // Position
  float radius = 1;
  color ballColor;
  boolean bCanGrow = true;

  Ball(float px, float py, color c)
  {
    posX = px; posY = py;
    ballColor = c;
  }

  void Grow()
  {
    if (bCanGrow)
    {
      radius += 1;
    }
  }

  void Display()
  {
    noStroke();
    fill(ballColor);
    ellipse(posX, posY, radius * 2, radius * 2);
  }
}
