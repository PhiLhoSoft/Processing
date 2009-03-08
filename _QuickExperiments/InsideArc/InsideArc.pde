int x = 100;
int y = 100;
int d = 200;
float a1 = 0, a2 = 0;
float na1, na2;

// Get any angle, between -infinite and +infinite, and clamp it between 0 and 2*PI
float normalizeAngle(float angle)
{
  // First, limit it between -2*PI and 2*PI, using modulo operator
  float na = angle % (2 * PI);
  // If the result is negative, bring it back to 0, 2*PI interval
  if (na < 0) na = 2*PI + na;
  return na;
}

void setup()
{
  background(0);
  size(400, 400);
}

void draw()
{
  if (frameCount % 20 == 0)
  {
    // Every 20 frames, change the angles in opposite directions with different speeds,
    // to make interesting range of angles
    a1 += PI/11;
    a2 -= PI/7;
  }
  // Normalize angles
  na1 = normalizeAngle(a1);
  na2 = normalizeAngle(a2);
  // Draw the circle base of the arc
  fill(#00FF00); ellipse(x, y, d, d);
  // Find the angle between the mouse position and the x axis from the center of the circle
  float a = normalizeAngle(atan2(mouseY - y, mouseX - x));
  // Find if the mouse is close enough of center
  boolean nearCenter = sqrt(sq(mouseX - x) + sq(mouseY - y)) <= d /2;
  boolean between;
  // First case: small arc, below half of circle
  if (na1 < na2)
  {
    // Just check we are between these two angles
    between = na1 <= a && a <= na2;
  }
  else  // Second case: wide arc, more than half of circle
  {
    // Check we are NOT in the remaining (empty) area...
    between = !(na2 <= a && a <= na1);
  }
  if (nearCenter && between)
  {
    // Both conditions (distance and angle) fulfilled: show arc in red
    fill(#FF0000);
  }
  else
  {
    // Not in arc: show it in blue
    fill(#0000FF);
  }
  // Just draw the wanted arc: I use the original angles to ensure the algorithm is sound
  arc(x, y, d, d, a1, a2);
}
