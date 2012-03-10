String[] fruits =
{
  "strawberry;0;200;3",
  "banana;20;0;0",
  "prune;10;40;0",
  "pear;5;70;10",
  "apple;2;0;7"
};

HashMap<String, FruitData> fruitData = new HashMap<String, FruitData>();
 
void setup () 
{
  size(200, 200);
  
  for (String line : fruits)
  {
    String[] elt = line.split(";");
    FruitData fd = new FruitData(int(elt[1]), int(elt[2]), int(elt[3]));
    fruitData.put(elt[0], fd);
  }
  
  println(fruitData.get("apple"));
  println(fruitData.get("banana"));
  println(fruitData.get("mushroom"));
   
  for (String key : fruitData.keySet())
  {
    println(key + " -> " + fruitData.get(key));
  }
  
  exit();
}
 
class FruitData
{
  // I don't know what the values are for in the example...
  int a;
  int b;
  int c;
  
  FruitData(int pa, int pb, int pc)
  {
    a = pa;
    b = pb;
    c = pc;
  }
  
  public String toString()
  {
    return "Fruit: " + a + " / " + b + " / " + c;
  }
}

