void setup()
{
  println("Creating world");
  Plant grass = new Plant(); println();
  Plant daisy = new Flower(); println();
  Animal cow = new Herbivore(); println();
  Animal lion = new Carnivore(); println();
  Animal pig = new Omnivore(); println();
  
  println();
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
  
  println(pig.isLiving);
}

interface Eater {
  boolean likesToEat(Organism o);
}
abstract class Organism {
  boolean isLiving;
  Organism() { isLiving = true; print(this.getClass().getSimpleName() + " > Organism"); }
}
class Plant extends Organism {
  Plant() { print("-Plant"); }
}
class Flower extends Plant {
  Flower() { print("-Flower"); }
}
abstract class Animal extends Organism implements Eater {
  Animal() { print("-Animal"); }
}
class Herbivore extends Animal {
  Herbivore() { print("-Herbivore"); }
  boolean likesToEat(Organism o) {
    return o instanceof Plant;
  }
}
class Carnivore extends Animal {
  Carnivore() { print("-Carnivore"); }
  boolean likesToEat(Organism o) {
    return o instanceof Animal;
  }
}
class Omnivore extends Animal {
  Omnivore() { print("-Omnivore"); }
  boolean likesToEat(Organism o) {
    return o instanceof Animal || o instanceof Plant;
  }
}



