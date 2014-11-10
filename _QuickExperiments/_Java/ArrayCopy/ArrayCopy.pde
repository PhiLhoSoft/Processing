import java.util.Arrays;

void setup()
{
  // Declare
  int[][] numbers = new int[10][];
  // Initialize
  for (int i = 0; i < numbers.length; i++)
  {
    numbers[i] = new int[int(1 + random(10))];
    for (int j = 0; j < numbers[i].length; j++)
    {
      numbers[i][j] = i * 100 + j;
    }
  }
  // Show result
  DumpArray(numbers);

  // Declare copy
  int[][] copy = new int[numbers.length][];
  // Do the copy
  for (int i = 0; i < numbers.length; i++)
  {
    copy[i] = Arrays.copyOf(numbers[i], numbers[i].length);
  }

  // Alter the original, to show it copied more than references...
  for (int i = 0; i < numbers.length; i++)
  {
    for (int j = 0; j < numbers[i].length; j++)
    {
      numbers[i][j] = 0;
    }
  }

  // Show result
  println("");
  DumpArray(copy);
  DumpArray(numbers);

  println("\n\nTest enums\n");

  TestEnum ev = TestEnum.valueOf("Number1");
  System.out.printf("Enumeration: %s (%s) = %d -- %s (%b) = %d\n",
      ev, ev.name(), ev.ordinal(), ev.GetNameList(), ev.IsEven(), ev.GetValue());

  TestEnum[] enums = TestEnum.values();
  for (int i = 0; i < enums.length; i++)
  {
    TestEnum te = enums[i];
    System.out.printf("%d) %s = %d -- %s (%b)\n",
        te.ordinal(), te.name(), te.GetValue(), te.GetNameList(), te.IsEven());
  }
}

void DumpArray(int[][] arr)
{
  for (int i = 0; i < arr.length; i++)
  {
    for (int j = 0; j < arr[i].length; j++)
    {
      print(arr[i][j] + " ");
    }
    println("");
  }
}


