/**
 * Based on Pie Chart  
 * By Ira Greenberg 
 * 
 * Uses the arc() function to generate a pie chart from the data
 * stored in an array.
 * Draw the sides of the pie parts.
 */
 
size(400, 400);
background(200);
smooth();
//noStroke();
stroke(#886600);
int centerX = width / 2;
int centerY = height / 2;

float diameter = min(width, height) * 0.75;
int[] angs = { 30, 10, 45, 35, 60, 38, 75, 67 };
float lastAng = 0;

for (int i = 0; i < angs.length; i++)
{
  fill(angs[i] * 3.0);
  float newAng = radians(angs[i]);
  arc(centerX, centerX, diameter, diameter, lastAng, lastAng + newAng);
  line(centerX, centerY, centerX + diameter/2 * cos(lastAng), centerY + diameter/2 * sin(lastAng));
  lastAng += newAng;  
}

