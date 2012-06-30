void countWords(String text)
{
  WordList wordList = new WordList();
  // Get rid of non-alphabetical chars
  text = text.replaceAll("[^a-zA-Z -]", " ");
  // Collapse multiple spaces into one
  text = text.replaceAll(" +", " ").toLowerCase();
  // Make a list of words by splitting by the space char
  String[] wordArray = split(text, ' ');
  // Add the words
  for (String word : wordArray)
  {
    wordList.add(word);
  }

  // Print out the words and their frequency
  wordList.print();
  // Output to disk
  wordList.export("outputCount.txt");
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

  WordList()
  {
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
