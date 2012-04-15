String mirror = "AHIMOTUVWXYimnouvwx";
boolean IsMirrorImage(String input)
{
  for (int i = 0; i < input.length(); i++) 
  {
    String charI = input.substring(i, i+1);
    print(charI);
    if (!mirror.contains(charI))
      return false;
  }
  return true;
}
boolean IsPalindrome(String input)
{
  int len = input.length();
  for (int i = 0; i < len / 2; i++) 
  {
    char cL = input.charAt(i);
    char cR = input.charAt(len - 1 - i);
    if (cL != cR)
      return false;
  }
  return true;
}

String[] tests =
{
  "",
  "z",
  "A",
  "Processing",
  "LOL",
  "HannaH",
  "HAMMAH",
  "wAxAw",
  // Not enough, of course
  "WHAT",
  "HAMMix",
};

void setup()
{
  for (String test : tests)
  {
    println("-" + IsMirrorImage(test));
  }
  
  println("\nReal tests\n");
  
  for (String test : tests)
  {
    println("-" + (IsMirrorImage(test) && IsPalindrome(test)));
  }
  
  exit();
}

