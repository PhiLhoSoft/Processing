final int DEUCE = -1; // Equality
final int ADVANTAGE = -2; // One point of advance
final int WIN = -3; // Winner of the game

void incrementScore(int player)
{
  if (points[player] == 0 || points[player] == 15)
  {
    points[player] += 15;
  }
  else if (points[player] == 30)
  {
    points[player] = 40;
    if (points[1 - player] == 40)
    {
      points[player] = points[1 - player] = DEUCE;
    }
  }
  else if (points[player] == 40)
  {
    if (points[1 - player] < 40) // Other player
    {
      points[player] = WIN;
    }
  }
  else if (points[player] == DEUCE)
  {
    println("D");
    if (points[1 - player] == ADVANTAGE)
    {
      points[player] = points[1 - player] = DEUCE;
    }
    else
    {
      points[player] = ADVANTAGE;
    }
  }
  else if (points[player] == ADVANTAGE)
  {
    points[player] = WIN;
  }
  else
  {
    points[player] = points[1 - player] = DEUCE;
  }
}
 
int ballPosX, ballPosY, ballSpeedX;
int[] points = new int[2]; // 0 = P1, 1 = P2
 
void checkScore()
{
  boolean scored = false;
  if (ballPosX < 0)
  {
    incrementScore(1);
    scored = true;
  }
  else if (ballPosX > width)
  {
    incrementScore(0);
    scored = true;
  }
  if (scored)
  {
    ballPosX = width / 2;
    ballPosY = height / 2;
    ballSpeedX *= -1;
    announceScore();
  }
}

void announceScore()
{
  print(points[0] + " / " + points[1] + " == ");
  if (points[0] == WIN)
  {
    println("Game, Player 1");
    points[0] = points[1] = 0;
  }
  else if (points[1] == WIN)
  {
    println("Game, Player 2");
    points[0] = points[1] = 0;
  }
  else if (points[0] == points[1] && points[0] == DEUCE)
  {
    println("Deuce");
  }
  else if (points[0] == ADVANTAGE)
  {
    println("Advantage, Player 1");
  }
  else if (points[1] == ADVANTAGE)
  {
    println("Advantage, Player 2");
  }
  else println();
}
 
void setup()
{
  size(1000, 500);
}
 
void draw()
{
}
 
void keyPressed()
{
  if (keyCode == LEFT)
  {
    ballPosX = width + 1;
  }
  else if (keyCode == RIGHT)
  {
    ballPosX = -1;
  }
  checkScore();
}

