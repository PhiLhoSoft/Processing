void setup()
{
  println(mix("abc", 2));
  println(mix("ab", 3));
}

String[] mix(String digits, int numberLength)
{
  int base = digits.length();
  int sequenceLength = int(pow(base, numberLength));
  println(sequenceLength);
  String[] result = new String[sequenceLength];
  String[] digitArray = digits.split("");
//  println(digitArray);
  for (int i = 0; i < sequenceLength; i++)
  {
      result[i] = MapDigits(i, numberLength, base, digitArray);
  }
  
  return result;
}

String MapDigits(int val, int numberLength, int base, String[] digitArray)
{
  String r = "";
  for (int i = 0; i < numberLength; i++)
  {
    int d = val % base;
    val = val / base;
    r = digitArray[d + 1] + r; // Small string, string concatenation OK here
  }
  return r;
}

