ArrayList al = new ArrayList(10);

for (int i = 0; i < 10; i++) al.add(">--" + i);

al.add(1, "One");
al.add(3, "Three");
al.add(5, "Five");
al.add(8, "Eight");

ListIterator it = al.listIterator();
while (it.hasNext())
{
  int i = it.nextIndex();
  String s = (String) it.next();
  println(i + " " + s);
}

SomeTestClass ta = new SomeTestClass();
ta.Print();

