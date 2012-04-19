// 

// Ball handling
final int BALL_NB = 10;
// Positions
float[] posX = new float[BALL_NB];
float[] posY = new float[BALL_NB];
// Movement (linear)
float[] speedX = new float[BALL_NB];
float[] speedY = new float[BALL_NB];
// Radius of the balls
int[] radius = new int[BALL_NB];
// And the colors
color[] ballColor = new color[BALL_NB];
 
void setup()
{
  size(600, 400);
  smooth();
 
  // Initialize the ball's data
  posX[0] = 120;
  posY[0] = 50;
  speedX[0] = -2;
  speedY[0] = 3;
  radius[0] = 24;
  ballColor[0] = #002277;

  // Initialize the other ball's data
  posX[1] = 220;
  posY[1] = 150;
  speedX[1] = 2;
  speedY[1] = -3;
  radius[1] = 32;
  ballColor[1] = #007722;
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
  posX[n] += speedX[n];
  // Check the horizontal position against the bounds of the sketch
  if (posX[n] < radius[n] || posX[n] > width - radius[n])
  {
    // We went out of the area, we invert the h. speed (moving in the opposite direction)
    // and put back the ball inside the area
    speedX[n] = -speedX[n];
    posX[n] += speedX[n];
  }
  // Idem for the vertical speed/position
  posY[n] += speedY[n];
  if (posY[n] < radius[n] || posY[n] > height - radius[n])
  {
    speedY[n] = -speedY[n];
    posY[n] += speedY[n];
  }
}
 
void displayBall(int n)
{
  // Simple filled circle
  noStroke();
  fill(ballColor[n]);
  ellipse(posX[n], posY[n], radius[n] * 2, radius[n] * 2);
}

