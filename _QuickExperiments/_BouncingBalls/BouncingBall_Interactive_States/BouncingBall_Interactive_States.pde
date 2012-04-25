// Illustration of http://wiki.processing.org/w/How_do_I_display_a_message_for_a_few_seconds%3F

Ball ball;
boolean bDisplayMessage;
int startTime;
final int DISPLAY_DURATION = 1000; // 1s

void setup()
{
  size(600, 400);
  smooth();
  
  PFont f = createFont("Arial", 48);
  textFont(f);

  ball = new Ball(20, 50, -4, 3, 24, #002277);
}

void draw()
{
  background(#AAFFEE);
  if (bDisplayMessage)
  {
    fill(#FFAA88);
    text("You got it!", 150, height / 2);
    if (millis() - startTime > DISPLAY_DURATION) 
    {
      bDisplayMessage = false;
    }
  }
  else
  {
    ball.move();
    ball.display();
  }
}

void mousePressed()
{
  bDisplayMessage = dist(mouseX, mouseY, ball.posX, ball.posY) < ball.radius;
  startTime = millis();
}


class Ball
{
  float posX, posY; // Position
  float speedX, speedY; // Movement (linear)
  float radius;
  color ballColor;

  Ball(float px, float py, float sX, float sY, float r, color c)
  {
    posX = px; posY = py;
    speedX = sX; speedY = sY;
    radius = r; ballColor = c;
  }

  void move()
  {
    posX += speedX;
    if (posX < radius || posX > width - radius)
    {
      speedX = -speedX;
      posX += speedX;
    }
    posY += speedY;
    if (posY < radius || posY > height - radius)
    {
      speedY = -speedY;
      posY += speedY;
    }
  }

  void display()
  {
    noStroke();
    fill(ballColor);
    ellipse(posX, posY, radius * 2, radius * 2);
  }
}

