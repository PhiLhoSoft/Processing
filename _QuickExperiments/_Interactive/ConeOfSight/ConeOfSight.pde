int x, y;
PVector player = new PVector(250, 550);
float angle = PI / 2;
float coneAngle = PI / 4;
float angleStep = PI / 60;
 
void setup()
{
  size(800, 800);
  frameRate(10);
  
  smooth();
  x = width / 2;
  y = height / 2;
}
 
void draw()
{
  background(255);
  playerDraw();
  enemiesDraw();
}
 
void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == LEFT) angle -= angleStep;
    if (keyCode == RIGHT) angle += angleStep;
  }
  if (angle > TWO_PI) angle -= TWO_PI;
  if (angle < 0) angle += TWO_PI;
  
  if (key == 'r') // Random
  {
    player = new PVector(random(20, width - 20), random(20, height - 20));
  }
}
 
boolean isPlayerInSight(float playerX, float playerY, float coneX, float coneY, float coneDir) 
{
  boolean bCanSee = false;
  float minAngle = coneDir - coneAngle / 2;
  float maxAngle = coneDir + coneAngle / 2;
 
  float angle = atan2(playerY - coneY, playerX - coneX);
  if (angle < 0)
  {
    angle += TWO_PI;
  }

  // Test if the angle is inside the 'cone' (between the min angle and max angle)
  if (angle >= minAngle && angle <= maxAngle) 
  {
    bCanSee = true;
  }
  return bCanSee;
}
 
void enemiesDraw()
{
  noStroke();
  fill(255, 255, 128);
  ellipse(x, y, 20, 20);
  
  if (isPlayerInSight(
      player.x, player.y, 
      x, y,
      angle)) 
  {
    stroke(255, 0, 0);
  }
  else
  {
    stroke(255, 128, 0);
  }
  // Draw a visual representation of the cone of sight
  line(x, y, x + cos(angle + coneAngle / 2) * width, y + sin(angle + coneAngle / 2) * height);
  line(x, y, x + cos(angle - coneAngle / 2) * width, y + sin(angle - coneAngle / 2) * height);
}
 
void playerDraw()
{
  noStroke();
  fill(0, 255, 128);
  ellipse(player.x, player.y, 10, 10);
}

