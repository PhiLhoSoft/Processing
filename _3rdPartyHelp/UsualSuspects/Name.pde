class Name implements Comparable {

  float x, y;
  String name;
  float nameWidth;
  int id;
  int targetID;
  boolean inPosition;

  Name(String name, int id){
    this.name = name;
    nameWidth = textWidth(name);
    this.id = id;
  }

  void display(){
    text(name, x, y+lineHeight);
  }

  String toString(){
    return "id: " + id + "\tnameWidth: " + nameWidth + "\t" + name;
  }

  int compareTo(Object anotherName) throws ClassCastException {
    if (!(anotherName instanceof Name)) {
      throw new ClassCastException(" A Name object expected.");
    }
    return int(nameWidth - ((Name) anotherName).nameWidth);
  }
}

