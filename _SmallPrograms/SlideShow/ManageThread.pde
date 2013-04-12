class ImageLoader extends Thread implements Iterable<PImage>
{
  boolean running;
  ArrayDeque<PImage> images = new ArrayDeque<PImage>();
  String imageToLoad;

  ImageLoader()
  {
    running = true;
  }
  
  void requestImage(String fileName)
  {
    imageToLoad = fileName;
  }
  
  public Iterator<PImage> iterator()
  {
    return images.iterator();
  }
  
  public void run()
  {
    while (running)
    {
      if (imageToLoad != null)
      {
        PImage image = loadImage(imageToLoad);
        if (image.width > MAX_IMAGE_WIDTH)
        {
          image.resize(MAX_IMAGE_WIDTH, image.height * MAX_IMAGE_WIDTH / image.width);
        }
        images.addFirst(image);
        if (images.size() > MAX_IMAGES)
        {
          images.removeLast();
        }
        imageToLoad = null;
      }
      delay(100);
    }
  }
}

