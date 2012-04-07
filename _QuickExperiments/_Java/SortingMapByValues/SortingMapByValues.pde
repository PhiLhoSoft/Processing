// https://forum.processing.org/topic/sorting-a-hashmap-by-value
import java.util.Map.Entry;
 
Map<String, Integer> counts = new HashMap<String, Integer>();
 
void setup()
{
  SortDemo demo = new SortDemo();
  demo.put("walnut", 45);
  demo.put("orange", 125);
  demo.put("apple", 45);
  demo.put("nut", 45);
  demo.put("pineapple", 12);
  demo.put("pear", 76);
  demo.put("banana", 56);
  demo.put("litchi", 45);
  
  demo.sort();
  
  for (Entry<String, Integer> entry : demo.getSortedData())
  {
    println(entry.getKey() + " -> " + entry.getValue());
  }
  
  println("\nCode stats:\n");
  SortDemo stats = new SortDemo();
  
  String[] text1 = loadStrings(sketchPath("SortingMapByValues.pde"));
  String[] text2 = loadStrings(sketchPath("SortDemo.java"));
  for (String line : text1)
  {
    parseLine(line);
  }
  for (String line : text2)
  {
    parseLine(line);
  }
  stats.putAll(counts);
  stats.sort();
  
  int count = 0;
  for (Entry<String, Integer> entry : stats.getSortedData())
  {
    println(entry.getKey() + " -> " + entry.getValue());
    if (++count > 20) break; // Only Top 20
  }
  
  exit();
}
 
void parseLine(String line)
{
  String[] words = line.split("[\\W]+");
  for (String word : words)
  {
    if (word.length() == 0)
      continue;
    if (counts.containsKey(word))
    {
      counts.put(word, counts.get(word) + 1);
    }
    else
    {
      counts.put(word, 1);
    }
  }
}

