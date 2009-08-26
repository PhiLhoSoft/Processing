void setup()
{
  Plant grass = new Plant();
  Plant daisy = new Flower();
  Animal cow = new Herbivore();
  Animal lion = new Carnivore();
  Animal pig = new Omnivore();
  
  println(lion.likesToEat(cow));
  println(lion.likesToEat(pig));
  println(lion.likesToEat(grass));
  println(lion.likesToEat(daisy));
  println();
  println(cow.likesToEat(lion));
  println(cow.likesToEat(pig));
  println(cow.likesToEat(grass));
  println(cow.likesToEat(daisy));
  println();
  println(pig.likesToEat(lion));
  println(pig.likesToEat(cow));
  println(pig.likesToEat(grass));
  println(pig.likesToEat(daisy));
  println(pig.likesToEat(pig));
}

interface Eater {
  boolean likesToEat(Organism o);
}
abstract class Organism {
  boolean isLiving;
  Organism() { isLiving = true; }
}
class Plant extends Organism {
  Plant() {}
}
class Flower extends Plant {
  Flower() { super(); }
}
abstract class Animal extends Organism implements Eater {
  Animal() {}
}
class Herbivore extends Animal {
  Herbivore() { super(); }
  boolean likesToEat(Organism o) {
    return o instanceof Plant;
  }
}
class Carnivore extends Animal {
  Carnivore() { super(); }
  boolean likesToEat(Organism o) {
    return o instanceof Animal;
  }
}
class Omnivore extends Animal {
  Omnivore() { super(); }
  boolean likesToEat(Organism o) {
    return o instanceof Animal || o instanceof Plant;
  }
}



