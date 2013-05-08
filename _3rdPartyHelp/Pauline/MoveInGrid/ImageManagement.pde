void getImage(int imageIndex, int gridIndex)
{
  // Dispose of the  previous image
  g.removeCache(images[gridIndex]);
  images[gridIndex] = null;

  // Load asynchronously the wanted image
  ImageLoader il = new ImageLoader(imageIndex, gridIndex);
  Thread ilt = new Thread(il);
  ilt.start();
}

class ImageLoader implements Runnable
{
  private int imageIndex;
  private int gridIndex;

  public ImageLoader(int imageIndex, int gridIndex)
  {
    this.imageIndex = imageIndex;
    this.gridIndex = gridIndex;
  }

  public void run()
  {
    PImage img = loadImage("H:/Temp/Pauline/" + nf(imageIndex, 4) + ".jpg");
    images[gridIndex] = img;
  }
}
