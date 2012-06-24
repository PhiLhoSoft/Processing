String[] stopWordList = { "all", "and", "are", "as", "at", "be", "but", "by", "do", "done,",
  "for", "from", "he", "her", "him", "in", "is", "it", "of", "or", "our", "me", "my", "no", "not", "on",
  "she", "so", "that", "the", "there", "they", "this", "to", "too", "you", "your"
}; // And so on...

void setup()
{
  String[] lines = loadStrings("input.txt");

  println("Read " + lines.length + " lines");

  WordList words = new WordList();
  for (String line : lines)
  {
    // Get rid of non-alphabetical chars
    line = line.replaceAll("[^a-zA-Z -]", " ");
    // Collapse multiple spaces into one
    line = line.replaceAll(" +", " ").toLowerCase();
    String[] wordList = split(line, ' ');
    // Add the words of the line
    for (String word : wordList)
    {
      words.add(word);
    }
  }
  words.print();
  words.export("output.txt");
  exit();
}

class WordList
{
  // Simple class to store a word and its count in a collection
  // Internal as we don't need to expose it to the outer world...
  class Word
  {
    String w;
    int count = 1;

    Word(String s)
    {
      w = s;
    }

    // Allows to get a human readable string out of the object
    String toString()
    {
      return w + ": " + count;
    }
  }

  // List of words and their count, with unicity guarantee
  HashMap<String, Word> words = new HashMap<String, Word>();
  // List of stop words, with quick check if a given string is part of this list
  HashSet<String> stopWords = new HashSet<String>();

  WordList()
  {
    // Build the stop word structure
    stopWords.addAll(Arrays.asList(stopWordList));
    // Simple check...
    println(stopWords);
  }

  // Add a word
  void add(String w)
  {
    if (w.length() < 2)
      return; // Exclude 0 or 1 sized words
    if (stopWords.contains(w))
      return; // Exclude known stop words

    Word word = words.get(w); // Get it from the list
    if (word == null) // Not found
    {
      // Create a new word
      word = new Word(w);
      words.put(w, word);
    }
    else
    {
      // Update it directly in the hash map
      word.count++;
    }
  }

  // Print out the list on the console
  void print()
  {
    // List of the values
    Collection<Word> values = words.values();
    for (Word word : values)
    {
      // Print frequent words
      if (word.count > 1)
      {
        println(word); // Calls toString() automatically
      }
    }
  }

  // Export the list to a file
  void export(String file)
  {
    Collection<Word> values = words.values();
    int nb = values.size();
    String[] allWordList = new String[nb];
    int c = 0;
    for (Word word : values)
    {
      if (word.count > 1)
      {
        allWordList[c++] = word.toString(); // Must call explicitly here
      }
    }
    // Make a copy of the array, truncated to the real size
    String[] out = Arrays.copyOf(allWordList, c);
    // and save it to the file
    saveStrings(file, out);
  }
}
