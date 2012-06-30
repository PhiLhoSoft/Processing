String[] stopWordList = { "all", "and", "are", "as", "at", "be", "but", "by", "do", "done,",
  "for", "from", "he", "her", "him", "in", "is", "it", "of", "or", "our", "me", "my", "no", "not", "on",
  "she", "so", "that", "the", "there", "they", "this", "to", "too", "you", "your"
}; // And so on...

// List of stop words, allowing a quick check if a given string is part of this list
HashSet<String> stopWords = new HashSet<String>();


void setup()
{
  // Build the stop word structure
  stopWords.addAll(Arrays.asList(stopWordList));
  // Simple check...
  println(stopWords);

  String[] lines = loadStrings("input.txt");
  println("Read " + lines.length + " lines");

  String text = join(lines, " ");

  println("== Count words");
  countWords(text);

  println("== Decimate words");
  decimateWords(text);
  exit();
}

