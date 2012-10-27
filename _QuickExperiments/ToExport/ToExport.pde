void f(float x)
{
  println("F");
}
void f(double x)
{
  println("D");
}
void setup()
{
  f(1);
  f(1.0);
  f(1.0f);
  f(1.0d);
}

