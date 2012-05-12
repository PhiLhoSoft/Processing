class Measure
{
  int sensorNb;
  float value;
  Measure(int id, float v)
  {
    sensorNb = id;
    value = v;
  }
  
  public String toString()
  {
    return "M[" + sensorNb + "] = " + value;
  }
}
ArrayList<Measure>[] measures = new ArrayList[5];
 
void setup()
{
  for (int i = 0; i< measures.length; i++)
  {
    measures[i] = new ArrayList<Measure>();
  }
  
  measures[0].add(new Measure(1, 5.0));
  measures[0].add(new Measure(3, 15.0));
  measures[0].add(new Measure(2, 7.0));
  measures[0].add(new Measure(5, 11.0));
  measures[0].add(new Measure(4, 9.0));
  
  measures[1].add(new Measure(1, 115.0));
  measures[1].add(new Measure(5, 125.0));
  measures[1].add(new Measure(3, 117.0));
  measures[1].add(new Measure(4, 119.0));
  measures[1].add(new Measure(2, 99.0));
  
  println(measures[0]);
  println(measures[1]);
  
  Collections.sort(measures[0], new CompareMeasures(false));
  println(measures[0]);
  
  Collections.sort(measures[1], new CompareMeasures(true));
  println(measures[1]);

  exit();
}


class CompareMeasures implements Comparator<Measure>
{
  int sortOrder = 1;
  
  CompareMeasures(boolean bReverse)
  {
    if (bReverse) sortOrder = -1;
  }
  
  //@Override
  public int compare(Measure m1, Measure m2)
  {
    if (m1.value < m2.value) return -sortOrder;
    if (m1.value > m2.value) return sortOrder;
    return 0;
  }
}

