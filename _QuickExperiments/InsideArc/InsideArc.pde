// Data of arc
int x = 200;
int y = 200;
int d = 200;
float a1 = 0, a2 = 0;

void setup()
{
  background(0);
  size(400, 400);
}

void draw()
{
  background(255);
  if (frameCount % 20 == 0)
  {
    // Every 20 frames, change the angles in opposite directions with different speeds,
    // to make interesting range of angles
    // EDIT: Looks like something is broken (in 1.0.5) as arc() doesn't accept negative
    // angles any longer?
    a1 += PI/11;
    a2 -= PI/7;
  }
  // Draw the circle base of the arc in green
  fill(#00FF00); ellipse(x, y, d, d);
  if (IsPointInsideArc(mouseX, mouseY, x, y, d, a1, a2))
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

// Get any angle, between -infinite and +infinite, and clamp it between 0 and 2*PI
float normalizeAngle(float angle)
{
  // First, limit it between -2*PI and 2*PI, using modulo operator
  float na = angle % (2 * PI);
  // If the result is negative, bring it back to 0, 2*PI interval
  if (na < 0) na = 2*PI + na;
  return na;
}

// Return true if the given point is inside an arc of circle.
// Doesn't work with arc of ellipse...
boolean IsPointInsideArc(float pointX, float pointY,
    float centerX, float centerY, float diameter, float angle1, float angle2)
{
  // Find if the mouse is close enough of center
  boolean nearCenter = sqrt(sq(pointX - centerX) + sq(pointY - centerY)) <= d /2;
  if (!nearCenter)
    return false; // Quick exit...

  // Normalize angles
  float na1 = normalizeAngle(angle1);
  float na2 = normalizeAngle(angle2);
  // Find the angle between the point and the x axis from the center of the circle
  float a = normalizeAngle(atan2(pointY - centerY, pointX - centerX));

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
  return between;
}
