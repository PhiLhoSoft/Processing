import java.io.*;
import java.util.*;

final int MAX_IMAGES = 5;
final int MAX_IMAGE_WIDTH = 200;
final String PATH = "G:/Images/";
String[] images;
ImageLoader loader;
int counter;
int position;

void setup()
{
  size(1200, 400);
  imageMode(CENTER);
  
  File imageDir = new File(PATH);
  images = imageDir.list(new FilenameFilter()
  {
    public boolean accept(File dir, String name)
    {
      return name.endsWith(".gif") ||
          name.endsWith(".jpg") ||
          name.endsWith(".png");
    }
  });
//  println(images);
  loader = new ImageLoader();
  loader.start();
  println("Starting");
}

void draw()
{
  background(255);
  int c = 0;
  for (PImage image : loader)
  {
    int pos = position - c++ * MAX_IMAGE_WIDTH;
    if (pos > width)
    {
      pos -= width;
    }
    image(image, pos, height / 2);
  }
  position++;
}

void keyPressed()
{
  counter %= images.length;
  String path = PATH + images[counter++];
  println("Loading " + path);
  loader.requestImage(path);
}


