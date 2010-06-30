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

  for (int i = 0; i < mum.length; i++) {
    family = xml.getChild(i);
    //get family relations
    friend1 = family.getChild(0);
    int mate1 = friend1.getIntAttribute("mate1");
    friend2 = family.getChild(1);
    int mate2 = friend2.getIntAttribute("mate2");

    mum[i] = new Mother(1+i);
    //add friends
    mum[i].addFriend(mate1);
    mum[i].addFriend(mate2);
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
  Son son = mum[1].getBoy(1);
  son.removeFriend(3);

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
    for (int i = 0; i < kids; i++) {
      boys.add(new Son(id, i+1));
    }
  }

  void transmit() {
    girl.display();
    for (int i = 0; i < boys.size(); i++) {
      Son maleChild = getBoy(i+1);
      maleChild.display();
    }
  }

  Son getBoy(int id)
  {
    if (id < 1 || id > boys.size())
      return null; // or throw exception or return "empty" boy
    return (Son) boys.get(id-1);
  }

  void addFriend(int id)
  {
    friends.add(id);
    girl.addFriend(id);
    for (int i = 0; i < boys.size(); i++) {
      Son maleChild = getBoy(i+1);
      maleChild.addFriend(id);
    }
  }

  void removeFriend(int fallenOutWith)
  {
    friends.remove(new Integer(fallenOutWith));
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

  void addFriend(int id)
  {
    friends.add(id);
  }

  void removeFriend(int fallenOutWith)
  {
    println(id + ": girl: i've had a fight with friend " + fallenOutWith + "!");
    friends.remove(new Integer(fallenOutWith));
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

  Son(int identity, int whom) {
    id = identity;
    who = whom;
  }

  void addFriend(int id)
  {
    friends.add(id);
  }

  void removeFriend(int fallenOutWith)
  {
    println(id + ": " + who + ": i've had a fight with friend " + fallenOutWith + "!");
    friends.remove(new Integer(fallenOutWith));
  }

  void display() {
    println(id + ": " + who + ": " + "boy's friends" + friends);
  }
}
