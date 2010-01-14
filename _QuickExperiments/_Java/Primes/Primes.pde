/*
int topPrime = 150000;
int current = 2;
int count = 0;
int lastPrime = 2;

long start = System.currentTimeMillis();

while (count < topPrime) {

  boolean prime = true;

  int top = (int)Math.sqrt(current) + 1;

  for (int i = 2; i < top; i++) {
    if (current % i == 0) {
      prime = false;
      break;
    }
  }

  if (prime) {
    count++;
    lastPrime = current;
  }
  if (current == 2) {
    current++;
  } else {
    current = current + 2;
  }
}

System.out.println("Last prime = " + lastPrime);
System.out.println("Total time = " + (double)(System.currentTimeMillis() - start) / 1000);

exit();

// Last prime = 2015177
// Total time = 4.391
*/

//~ static final int wantedPrimeNb = 150000;
final int wantedPrimeNb = 100;
int currentNumber = 5;
int count = 0;
int lastPrime = 2;

long start = System.currentTimeMillis();

NEXT_TESTING_NUMBER:
while (count < wantedPrimeNb)
{
  currentNumber += increment;
  increment = 6 - increment;
  if ((currentNumber & 1) == 0)
  {
    // Even number
    continue;
  }
  int top = (int) Math.sqrt(currentNumber) + 1;
  testingNumber = 5;
  increment = 2;
  do
  {
    if (currentNumber % testingNumber == 0)
    {
      continue NEXT_TESTING_NUMBER;
    }
    testingNumber += increment;
    increment = 6 - increment;
  } while (testingNumber < top);
  // If we got there, we have a prime
  count++;
  lastPrime = current;
  System.out.println(lastPrime);
}

System.out.println("Last prime = " + lastPrime);
System.out.println("Total time = " + (double) (System.currentTimeMillis() - start) / 1000);

exit();
