String text = "\"Well, Prince, so Genoa and Lucca are now just family estates of the " +
"Buonapartes. But I warn you, if you don't tell me that this means war, " +
"if you still try to defend the infamies and horrors perpetrated by that " +
"Antichrist--I really believe he is Antichrist--I will have nothing more " +
"to do with you and you are no longer my friend, no longer my 'faithful " +
"slave,' as you call yourself! But how do you do? I see I have frightened " +
"you--sit down and tell me all the news.\"";

void setup()
{
  
String[] tokens = text.split("\\b"); // Split on word bounds!
//println(tokens);

// Dumb version of alternatives, just reversing the strings
String[] reversed = new String[tokens.length];
for (int i = 0; i < tokens.length; i++)
{
  if (!isWord(tokens[i]))
  {
    reversed[i] = tokens[i];
  }
  else
  {
    reversed[i] = reverse(tokens[i]);
  }
}
String reversedSentence = join(reversed, "");
println(reversedSentence);


// Another version, just shuffling the words using the Fisher-Yates algorithm
String[] random = new String[tokens.length];
arrayCopy(tokens, random);
for (int i = tokens.length - 1; i > 0; i--)
{
  if (!isWord(random[i]))
    continue; // Skip non-words

  int j = int(random(i + 1));
  while (j >= 0 && !isWord(random[j]))
  {
    // If not a word, try the previous one,
    // unless we reach the start of the array
    j--;
  }
  if (j >= 0)
  {
    swap(random, i, j);
  }
}
String randomSentence = join(random, "");
println(randomSentence);

exit();
}

boolean isWord(String s)
{
  return s.matches("\\w+");
}

String reverse(String s)
{
  StringBuilder sb = new StringBuilder(s);
  return sb.reverse().toString();
}

void swap(String[] a, int i, int j)
{
  String t = a[i];
  a[i] = a[j];
  a[j] = t;
//  println(t + " " + a[i]);
}



