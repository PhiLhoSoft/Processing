//sketch of family relations
//3 families: each family is a unit being
//a mother with 3 children: One daughter and Two sons.
//each family is friends with the others
//
//OOP properties:
//each family member is a class-object
//Mother class is composed of children -
//daughter and son classes are inner classes of mother class
//sons are in an arrayList

XMLElement xml;
int mums = 3;
Mother[] mum = new Mother[mums];


void setup() {
  //load family relations from file
  xml = new XMLElement(this, "relations.xml");
  mums = xml.getChildCount();
  XMLElement family;
  XMLElement identity;
  XMLElement friend1;
  XMLElement friend2;

  for (int i=0; i<mum.length; i++) {
    family = xml.getChild(i);
    //get family relations
    friend1 = family.getChild(0);
    int mate1 = friend1.getIntAttribute("mate1");
    friend2 = family.getChild(1);
    int mate2 = friend2.getIntAttribute("mate2");

    mum[i] = new Mother(1+i);
    //add friends
    mum[i].friends.add(mate1);
    mum[i].girl.friends.add(mate1);
    mum[i].friends.add(mate2);
    mum[i].girl.friends.add(mate2);
  }
  noLoop();
}

void draw() {
  for (int i = 0; i < mum.length; i++) {
    mum[i].transmit();
  }
}

void mousePressed()
{
  //remove the friend of one son
  Son son = (Son) mum[1].boys.get(0);
  println(2 + ": " + 0 + ": i've had a fight with friend 3!");

  for (int i = 0; i < son.friends.size(); i++) {
    int fallenOutWith = (Integer) son.friends.get(i);
    println(fallenOutWith);
    if (fallenOutWith == 3) {
      son.friends.remove(new Integer(fallenOutWith));
    println("removed");
    }
  }

  redraw();
}


/*................................................*/
int kids = 2;


class Mother {
  Daughter girl;
  ArrayList boys;
  ArrayList friends = new ArrayList();
  int ref;

  Mother(int id) {
    girl = new Daughter(id);
    ref = id;
    boys = new ArrayList();
    for (int i=0; i<kids; i++) {
      boys.add(new Son(id, i, friends));
    }
  }

  void transmit() {
   girl.display();
   for (int i=0; i<boys.size(); i++) {
     Son maleChild = (Son) boys.get(i);
     maleChild.display();
    }
  }

  void display() {
    println(ref + ": " + "mum's friends" + friends);
  }
}
/*................................................*/
class Daughter {
  int id;
  ArrayList friends = new ArrayList();

  Daughter(int identity) {
    id = identity;
  }

  void display() {
    println(id + ": " + "girl's friends" + friends);
  }
}
/*................................................*/
class Son {
  int id;
  int who;
  ArrayList friends = new ArrayList();

  Son(int identity, int whom, ArrayList buddies) {
    id = identity;
    who = whom;
    friends = buddies;
  }

  void display() {
    println(id + ": " + who + ": " + "boy's friends" + friends);
  }
}

