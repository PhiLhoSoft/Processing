String TEST_FILE1 = "Test1.jpg";
String URL1 = "http://4.bp.blogspot.com/-XayzCUVDAgA/Tcj7WBB9UiI/AAAAAAAAAPc/KMxjO3x4p0U/s1600/maquillage-catherine-zeta-jones.jpg";
String TEST_FILE2 = "Test2.jpg";
String URL2 = "http://www.starok.com/html/photos/more/catherine-zeta-jones-7752.jpg";

PImage image1, image2;
int alpha;

void setup()
{
  size(1024, 768);
  image1 = loadImage(TEST_FILE1);
  if (image1 == null) // Not downloaded yet
  {
    image1 = loadImage(URL1);
    image1.save(TEST_FILE1); // Cache of the file
  }  
  image2 = loadImage(TEST_FILE2);
  if (image2 == null) // Not downloaded yet
  {
    image2 = loadImage(URL2);
    image2.save(TEST_FILE2); // Cache of the file
  }
  frameRate(30);
}

void draw()
{
  tint(255, alpha);
  image(image1, 0, 0);
  tint(255, 255 - alpha);
  image(image2, 0, 50);
  alpha++;
  if (alpha == 255)
  {
    noLoop();
  }
}

