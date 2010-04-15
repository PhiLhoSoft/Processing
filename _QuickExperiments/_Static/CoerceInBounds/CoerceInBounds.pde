// Coerce the value of a variable within given bounds: 
// a MIN value and a MAX value (value can be within these bounds, inclusive).
// With added difficulty to leave the value as is if it is already in the bounds...
int MIN = 21;
int MAX = 23;
int DELTA = MAX - MIN + 1;

void setup()
{

for (int i = 0; i < 30; i++)
{
  int x = Bound(i);
  println(i + " " + x);
  int val = int(random(0, 55));
  int y = Bound(val);
  println("     " + val + " " + y);
}
exit();

}

int Bound(int val)
{
  // We need the value to be at least MIN, so we add this value,
  // and cut of with % at MAX minus MIN since we add it already
  // (+1 to include MAX in the bounds).
  // I need to zero on MIN value to get back this value (and above)
  // but to avoid negative values, I add MIN*DELTA which is a neutral
  // operation since I mod it out. And I am sure that even with small DELTA,
  // MIN*DELTA - MIN is positive.
  return MIN + (val + MIN*DELTA - MIN) % DELTA;
}

