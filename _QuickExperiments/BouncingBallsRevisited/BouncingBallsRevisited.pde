// BouncingBallRevisited
// Based on Bouncing Bubbles example in Processing, "Based on code from Keith Peters (www.bit-101.com)."

final int numBalls = 12;
final float spring = 0.05;
final float gravity = 0.03;
final float friction = -0.9;
Ball[] balls = new Ball[numBalls];

void setup()
{
  size(640, 200);
  smooth();

  for (int i = 0; i < balls.length; i++)
  {
    balls[i] = new Ball();
  }
}

void draw()
{
  background(255);
  
  for (int i = 0; i < balls.length; i++)
  {
    for (int j = i; j < balls.length; j++)
    {
      // Check collision against the remainder of the balls
      if (balls[i].isCollidingWith(balls[j]))
      {
        balls[i].bounceWith(balls[j]);
      }
    }
  }

  for (int i = 0; i < balls.length; i++)
  {
    balls[i].move();
    balls[i].display();
  }
}

class Ball
{
  float x, y; // Position
  float vx, vy; // Speeds
  float diameter;
  color c;

  Ball()
  {
    x = random(width);
    y = random(height);
    diameter = random(20, 40);
    c = int(random(250));
  }

  // Code straight from the example
  void move() 
  {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction;
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction;
    }
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  boolean isCollidingWith(Ball ball)
  {
    return dist(x, y, ball.x, ball.y) < (diameter + ball.diameter) / 2;
  }
  
  // Also code from the example
  void bounceWith(Ball ball)
  {
    float dx = ball.x - x;
    float dy = ball.y - y;
    float minDist = (ball.diameter + diameter) / 2;
    float angle = atan2(dy, dx);
    float targetX = x + cos(angle) * minDist;
    float targetY = y + sin(angle) * minDist;
    float ax = (targetX - ball.x) * spring;
    float ay = (targetY - ball.y) * spring;
    vx -= ax;
    vy -= ay;
    ball.vx += ax;
    ball.vy += ay;
  }
 
  void display()
  {
    noStroke();
    fill(c);
    ellipse(x, y, diameter, diameter);
  }
}

