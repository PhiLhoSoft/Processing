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
  }

  HashMap<String, Word> words = new HashMap<String, Word>();
  HashSet<String> stopWords = new HashSet<String>();

  WordList()
  {
    stopWords.addAll(Arrays.asList(stopWordList));
    println(stopWords);
  }

  void add(String s)
  {
    if (s.length() < 2)
      return; // Exclude 0 or 1 sized words
    if (stopWords.contains(s))
      return; // Exclude known stop words
      
    Word word = words.get(s);
    if (word == null) // Not found
    {
      // Create a new word
      word = new Word(s);
      words.put(s, word);
    }
    else
    {
      word.count++; // Update it directly in the hash map
    }
 }

  void print()
  {
    Collection<Word> values = words.values();
    for (Word word : values)
    {
      // Print frequent words
      if (word.count > 1)
      {
        println(word.w + ": " + word.count);
      }
    }
  }

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
        allWordList[c++] = word.w + ": " + word.count;
      }
    }
    String[] out = Arrays.copyOf(allWordList, c);
    saveStrings(file, out);
  }
}

