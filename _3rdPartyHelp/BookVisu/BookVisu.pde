ArrayList/* <bookNode> */ bookParticles = new ArrayList();
HashMap/* <sourceNode> */ sources = new HashMap();
HashMap/* <subjectNode> */ subjects = new HashMap();

/*
bookLinks[] bookConnections;
subjLinks[] subjConnections;
*/
/*..................................................................*/
void setup() {
 size(300,300);
 background(50);
 smooth();
 
/* Example of data:
<branches>
<node>
<title name="book1"/>
<source origin="author1"/>
<subjects tag1="topic1" tag2="topic2"/>
</node>
<node>
<title name="book2"/>
<source origin="author2"/>
<subjects tag1="topic1" tag2="topic3" tag3="topic4" tag4="topic5"/>
</node>
</branches>
*/
  // I lazily setup manually data, you seem to manage well XML parsing...
  bookNode bn = new bookNode("book1", getRandomVector());
  bookParticles.add(bn);
  sourceNode src = new sourceNode("author1", getRandomVector());
  bn.add(src);
  subjectNode subj = new subjectNode("topic1", getRandomVector());
  bn.add(subj);
  subj = new subjectNode("topic2", getRandomVector());
  bn.add(subj);
  
  bn = new bookNode("book2", getRandomVector());
  bookParticles.add(bn);
  src = new sourceNode("author2", getRandomVector());
  bn.add(src);
  subj = new subjectNode("topic1", getRandomVector());
  bn.add(subj);
  subj = new subjectNode("topic3", getRandomVector());
  bn.add(subj);
  subj = new subjectNode("topic4", getRandomVector());
  bn.add(subj);
  subj = new subjectNode("topic5", getRandomVector());
  bn.add(subj);
  
  bn = new bookNode("book3", getRandomVector());
  bookParticles.add(bn);
  src = new sourceNode("author1", getRandomVector());
  bn.add(src);
  src = new sourceNode("author3", getRandomVector());
  bn.add(src);
  subj = new subjectNode("topic4", getRandomVector());
  bn.add(subj);
  subj = new subjectNode("topic2", getRandomVector());
  bn.add(subj);
  
  for (int i = 0; i < bookParticles.size(); i++) {
    bookNode b = (bookNode) bookParticles.get(i);
    b.display();
  }
  Collection csrc = sources.values();
  for (Iterator it = csrc.iterator(); it.hasNext(); ) {
    sourceNode s = (sourceNode) it.next();
    s.display();
  }
  Collection csubj = subjects.values();
  for (Iterator it = csubj.iterator(); it.hasNext(); ) {
    subjectNode s = (subjectNode) it.next();
    s.display();
  }
}

PVector getRandomVector()
{
  return new PVector(random(width), random(height));
}

// Take out common parts of classes and put them in a separate class
// Classes extending this one just inherit (get) their fields and methods.
class Node {
  
 PVector position;
 String name;
 color fillColor;
 
 Node(PVector loc, color c) {
   position = loc;
   fillColor = c;
 }
 
 void display() {
   noStroke();
   fill(fillColor);
   ellipse(position.x, position.y, 5, 5);
   fill(200,200,200,50);
   ellipse(position.x, position.y, 15, 15);
 }
 
}

class bookNode extends Node {

  String title;
 
  ArrayList authorSources = new ArrayList();
  ArrayList subjectTags = new ArrayList();
 
  bookNode(String t, PVector loc) {
    super(loc, #FF0000);
    title = t;
  }
  
  void add(sourceNode src) {
    // Is that author already seen?
    sourceNode sn = (sourceNode) sources.get(src.origin);
    if (sn == null) { // No
      // Add it to the list of authors
      // with the name as key
      sources.put(src.origin, src);
    } else {
      // Yes, just add the reference to this source
      src = sn;
    }
    // Add it to the list of sources of the book
    authorSources.add(src);
  }
  
  // We can have two identically named methods as long
  // as their list of parameters are different
  void add(subjectNode subj) {
    // Is that tag already seen?
    subjectNode sn = (subjectNode) subjects.get(subj.tag);
    if (sn == null) { // No
      // Add it to the list of tags
      // with the name as key
      subjects.put(subj.tag, subj);
    } else {
      // Yes, just add the reference to this source
      subj = sn;
    }
    // Add it to the list of sources of the book
    subjectTags.add(subj);
  }
  
  void display() {
    super.display();
    stroke(200);
    strokeWeight(0.5);
    for (int i = 0; i < authorSources.size(); i++) {
      sourceNode s = (sourceNode) authorSources.get(i);
      line(position.x, position.y, s.position.x, s.position.y);
    }
    for (int j = 0; j < subjectTags.size(); j++) {
      subjectNode s = (subjectNode) subjectTags.get(j);
      line(position.x, position.y, s.position.x, s.position.y);
    }
  }

}

/*..................................................................*/
class sourceNode extends Node {
  
  String origin;
  
  sourceNode(String source, PVector loc) {
    super(loc, #99FF00);
    origin = source;
  }
  
  /* @Override */
  int hashCode() { return origin.hashCode(); }
  // Should also check that o is not null, of right type, etc.
  /* @Override */
  boolean equals(Object o) { return origin.equals(((sourceNode) o).origin); }
  
}

class subjectNode extends Node {
  
  String tag;
  
  subjectNode(String subject, PVector loc) {
    super(loc, #FFBB00);
    tag = subject;
  }
  
  /* @Override */
  int hashCode() { return tag.hashCode(); }
  /* @Override */
  boolean equals(Object o) { return tag.equals(((subjectNode) o).tag); }
 
}

