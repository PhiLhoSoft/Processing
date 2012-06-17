final int SIZE = 10;
String[] numbers = new String[SIZE];

PImage[] images = new PImage[6]; // put 60 or whatever

boolean bManual = true;

void setup()
{
  for (int i = 0; i < numbers.length; i++)
  {
    numbers[i] = Integer.toString(i);
  }
  println(Arrays.toString(numbers));
//  println(numbers); // Easier to compare with a above
  if (bManual)
    manualShuffleString();
  else
    shuffleStrings();
  println(Arrays.toString(numbers));
//  println(numbers);

  for (int i = 0; i < images.length; i++)
  {
    images[i] = createImage(5, 5, RGB);
  }
  println(images);
  if (bManual)
    manualShuffleImages();
  else
    shuffleImages();
  println(images);

  exit();
}

void shuffleStrings()
{
  Collections.shuffle(Arrays.asList(numbers));
}

void shuffleImages()
{
  // Put the images in an array list as Java can shuffle
  // such object, not arrays (sic).
  ArrayList<PImage> imagesToMix = new ArrayList<PImage>();
  Collections.addAll(imagesToMix, images);
  Collections.shuffle(imagesToMix);
  imagesToMix.toArray(images);
}

// Using the Fisher-Yates algorithm
void manualShuffleString()
{
  for (int i = numbers.length - 1; i > 0; i--)
  {
    int j = int(random(i + 1));
    // Swap
    String t = numbers[i];
    numbers[i] = numbers[j];
    numbers[j] = t;
  }
}
void manualShuffleImages()
{
  for (int i = images.length - 1; i > 0; i--)
  {
    int j = int(random(i + 1));
    // Swap
    PImage t = images[i];
    images[i] = images[j];
    images[j] = t;
  }
}

