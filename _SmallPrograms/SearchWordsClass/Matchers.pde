interface Matcher
{
  boolean IsMatching(String sentence);
}

class WordInside implements Matcher
{
  String word;

  WordInside(String w)
  {
    word = w;
  }
  boolean IsMatching(String sentence)
  {
    return sentence.toLowerCase().contains(word);
  }
}

class RegExMatcher implements Matcher
{
  String regex;

  RegExMatcher(String re)
  {
    regex = re;
  }
  RegExMatcher(String re, boolean bLoose)
  {
    if (bLoose)
    {
      regex = ".*" + re + ".*";
    }
    else
    {
      regex = re;
    }
  }
  boolean IsMatching(String sentence)
  {
    return sentence.toLowerCase().matches(regex);
  }
}

/*
Other possible variants (can be combined):
- strict: doesn't use toLowerCase
- at start: uses sentence.startsWith()
- at end (endsWith())
- and so on
*/
