// http://wiki.processing.org/w/From_several_arrays_to_classes

// Ball handling
final int BALL_NB = 5;
Ball[] balls = new Ball[BALL_NB];
 
void setup()
{
  size(600, 400);
  smooth();
 
  // The colors to use
  color[] colors = { #DDEE55, #AA44EE, #22BBAA, #0022FF, #00FF22 };
  // Initialize the balls' data
  for (int i = 0; i < BALL_NB; i++)
  {
    balls[i] = new Ball(8 + i * 8, colors[i]);
  }
}
 
void draw()
{
  // Erase the sketch area
  background(#AAFFEE);
  for (int i = 0; i < BALL_NB; i++)
  {
    // Compute the new ball position
    moveBall(i);
    // And display it
    displayBall(i);
  }
}
 
void moveBall(int n)
{
  // Move by the amount determined by the speed
  balls[n].posX += balls[n].speedX;
  // Check the horizontal position against the bounds of the sketch
  if (balls[n].posX < balls[n].radius || balls[n].posX > width - balls[n].radius)
  {
    // We went out of the area, we invert the h. speed (moving in the opposite direction)
    // and put back the ball inside the area
    balls[n].speedX = -balls[n].speedX;
    balls[n].posX += balls[n].speedX;
  }
  // Idem for the vertical speed/position
  balls[n].posY += balls[n].speedY;
  if (balls[n].posY < balls[n].radius || balls[n].posY > height - balls[n].radius)
  {
    balls[n].speedY = -balls[n].speedY;
    balls[n].posY += balls[n].speedY;
  }
}
 
void displayBall(int n)
{
  // Simple filled circle
  noStroke();
  fill(balls[n].ballColor);
  ellipse(balls[n].posX, balls[n].posY, balls[n].radius * 2, balls[n].radius * 2);
  fill(#FF0000);
  text(str(n), balls[n].posX, balls[n].posY);
}

boolean bStopped;
void mousePressed() { if (bStopped) loop(); else noLoop(); bStopped = !bStopped; }

class Ball
{
  float posX, posY; // Position
  float speedX, speedY; // Movement (linear)
  int radius; // Radius of the ball
  color ballColor; // And its color

  Ball(int r, color c)
  {
    // This actually calls the other constructor, providing the missing values
    this(random(r, width - r), random(r, height - r), random(-7, 7), random(-7, 7), r, c);
  }

  Ball(float x, float y, float sx, float sy, int r, color c)
  {
    posX = x;
    posY = y;
    speedX = sx;
    speedY = sy;
    radius = r;
    ballColor = c;
  }
}

