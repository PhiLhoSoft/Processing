import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.SortedSet;
import java.util.TreeSet;
 
public class SortDemo
{
  Map<String, Integer> nonSortedMap = new HashMap<String, Integer>();;
  SortedSet<Map.Entry<String, Integer>> sortedMap;
  
  public SortDemo()
  {
  }
  
  public void put(String s, Integer n)
  {
    nonSortedMap.put(s, n);
  }
  public void putAll(Map<String, Integer> rawMap)
  {
    nonSortedMap = rawMap;
  }
  
  public void sort()
  {
    sortedMap = sortByValues(nonSortedMap);
  }
  
  public SortedSet<Map.Entry<String, Integer>> getSortedData()
  {
    return sortedMap;
  }
  
  private static <K extends Comparable<? super K>, V extends Comparable<? super V>> SortedSet<Map.Entry<K, V>>
  sortByValues(Map<K, V> map)
  {
    SortedSet<Map.Entry<K, V>> sortedEntries = new TreeSet<Map.Entry<K, V>>(
        new Comparator<Map.Entry<K, V>>()
        {
          // For some reason, it doesn't accept Override even in a .java file...
          //@Override
          public int compare(Map.Entry<K, V> e1, Map.Entry<K, V> e2)
          {
            int res = e1.getValue().compareTo(e2.getValue());
            if (res != 0) 
              return -res; // Different, just give the result, negated for reversing order
            res = e1.getKey().compareTo(e2.getKey());
            return res != 0 ? res : 1; // Special fix to preserve items with equal values
          }
        });
    sortedEntries.addAll(map.entrySet());
    return sortedEntries;
  }
}

