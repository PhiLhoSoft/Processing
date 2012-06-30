void decimateWords(String text)
{
  WordAnalysis wordAnalyst = new WordAnalysis();
  // Collapse multiple spaces into one
  text = text.replaceAll(" +", " ");
  String[] wordArray = split(text, ' ');
  // Add the words of the line
  for (String word : wordArray)
  {
    wordAnalyst.add(word);
  }

  wordAnalyst.show();
  wordAnalyst.export("outputDecimate.txt");
}

class WordAnalysis
{
  // Simple class to store a word and its surrounding punctuation (if any)
  // Internal as we don't need to expose it to the outer world...
  class Word
  {
    String word;
    String leftPunct;
    String rightPunct;

    Word(String s)
    {
      // \W = not-word chars, \w = word chars
      Pattern p = Pattern.compile("^(\\W*)(\\w+|\\w[\\w'-]+\\w)(\\W*)$");
      Matcher m = p.matcher(s);
      if (m.find())
      {
        String w = m.group(2);
        if (w.length() < 2)
          return; // Exclude 0 or 1 sized words
        if (stopWords.contains(w.toLowerCase()))
          return; // Exclude known stop words

        word = w;
        leftPunct = m.group(1);
        rightPunct = m.group(3);
      }
    }

    // Allows to get a human readable string out of the object
    String toString()
    {
      String lp = leftPunct == null ? "" : leftPunct;
      String rp = rightPunct == null ? "" : rightPunct;
      return lp + word + rp;
    }
  }

  // List of words and their count, with unicity guarantee
  ArrayList<Word> words = new ArrayList<Word>();

  WordAnalysis()
  {
  }

  // Add a word
  void add(String w)
  {
    // Create a new word
    Word word = new Word(w);
    if (word.word != null)
    {
      words.add(word);
    }
  }

  // Print out the list on the console
  void show()
  {
    for (Word word : words) 
    {
      print(word.toString());
      print(" ");
    }
  }

  // Export the list to a file
  void export(String file)
  {
    PrintWriter output = createWriter(file); 
    for (Word word : words) 
    {
      output.print(word.toString());
      output.print(" ");
    }
    output.close();
  }
}
