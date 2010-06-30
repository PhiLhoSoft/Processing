StringTokenizer toker;
String[] pieces;
String aString;
String delims;

// Initial code by Quark
// [url=http://processing.org/discourse/yabb2/YaBB.pl?num=1275610741]Retracing the steps of splitTokens()[/url]

void setup()
{
  // String to parse
  aString = "Mary had ^^ a, little   lamb." +
      "\nwhose fleece was; white!? as snow...";
  // Characters used as separators
  delims = "^,.;:!?";
  
  // Create a tokeniser for this string
  // Last param = true since we want the deliminators as well
  // WHITESPACE defined by Processing
  toker  = new StringTokenizer(aString, delims + WHITESPACE, true);
  
  String[] pieces = new String[toker.countTokens()];
  int index = -1;
  boolean bWasDelim = false;
  while (toker.hasMoreTokens()) 
  {
    String part = toker.nextToken();
    if (WHITESPACE.contains(part))
      continue;  // Just skip these
    if (delims.contains(part)) 
    {
        if (bWasDelim) 
        {
          pieces[index] += part;
        } 
        else 
        {
          pieces[++index] = part;
          bWasDelim = true;
        }
    } 
    else 
    {
      pieces[++index] = part;
      bWasDelim = false;
    }
  }
  // Get a truncated result since we dropped parts
  String[] result = Arrays.copyOf(pieces, index);
  
  for (int i = 0; i < result.length; i++) 
  {
    println(i + "\t>" + result[i] + "<");
  }
  exit();
} 

