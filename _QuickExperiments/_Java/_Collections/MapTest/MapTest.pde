void setup()
{

String data =
    "Hi, i am looking for the best and easiest way for the following task." +
    "Ive got an array containing an unknown number of different names... " +
    "all these names different times. What need is to count them and sort them by how often they appear. " +
    "To get something like a top ten list of names." +
    "Whats the best approach for this ? " +
    "Using a hashmap maybe? The different strings would be the keys, " +
    "the number of times they occur would be the values. " +
    "Then, there should be a method to sort a hashmap based on its values.";
String[] names = data.toLowerCase().replaceAll("\\W", " ").replaceAll(" +", " ").split(" ");

Map map = new HashMap();

for (int i = 0; i < names.length; i++)
{
  String key = names[i];
  NameAndNumber nan = (NameAndNumber) map.get(key);
  if (nan == null)
  {
    // New entry
    map.put(key, new NameAndNumber(key, 1));
  }
  else
  {
    map.put(key, new NameAndNumber(key, nan.m_number + 1));
  }
}

// Sort the collection
ArrayList keys = new ArrayList(map.keySet());
Collections.sort(keys, new NameAndNumberComparator(map));

// List the top ten
int MAX = 10; int count = 0;
Iterator it = keys.iterator();
while (it.hasNext() && count < MAX)
{
  String key = (String) it.next();
  NameAndNumber nan = (NameAndNumber) map.get(key);
  println(key + " -> " + nan.m_number);
  count++;
}

exit();
}

class NameAndNumber
{
  String m_name;
  int m_number;

  NameAndNumber(String name, int number)
  {
    m_name = name;
    m_number = number;
  }
}

class NameAndNumberComparator implements Comparator, Serializable
{
  Map m_map;
  
  NameAndNumberComparator(Map map)
  {
    m_map = map;
  }
  
  //@Override
  public int compare(Object o1, Object o2)
  {
    // Get values associated to the keys to compare
    NameAndNumber nan1 = (NameAndNumber) m_map.get(o1);
    NameAndNumber nan2 = (NameAndNumber) m_map.get(o2);
    // Sort by descending order
    return nan2.m_number - nan1.m_number;
  }
}
