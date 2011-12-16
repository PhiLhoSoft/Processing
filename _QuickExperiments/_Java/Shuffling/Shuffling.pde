final int SIZE = 10;

void setup()
{
  String[] numbers = new String[SIZE];
  for (int i = 0; i < numbers.length; i++)
  {
    numbers[i] = Integer.toString(i);
  }
  println(Arrays.toString(numbers));
  Collections.shuffle(Arrays.asList(numbers));
  println(Arrays.toString(numbers));
  exit();
}

