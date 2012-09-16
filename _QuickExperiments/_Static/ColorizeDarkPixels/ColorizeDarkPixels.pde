PImage img;
ArrayList<PVector> list = new ArrayList<PVector>();
 
void setup() 
{
  size(800, 400);
  // 400x400 B&W image
  img = loadImage("H:/PhiLhoSoft/images/SqMeBW.jpg");
}
 
void draw() 
{
  background(0);
  image(img, 0, 0);
  image(img, img.width, 0);

  collectDarkPixels((float) mouseX / width * 255.0);  
  
  // Use the list
  loadPixels();
  float ratio = 255 / 400.0;
  for (int i = 0; i < list.size(); i++)
  {
    PVector v = list.get(i);
    color c = color(150, (v.x % 400) * ratio, (v.x / 400) * ratio);
    pixels[(int) (v.x + v.y * img.width * 2)] = c;
  }
  updatePixels();
}

void collectDarkPixels(float threshold)
{
  list.clear(); // Remove previous results
  //Load the pixels
  img.loadPixels();
  //Loop through each pixel (use image size instead of pixels.length!)
  for (int ix = 0; ix < img.width; ix++) 
  {
    for (int iy = 0; iy < img.height; iy++) 
    {
      //Set col to the grey level at that pixel
      float col = brightness(img.pixels[ix + iy * img.width]);
      //If the brightness is less than the threshold on an gray scale (to include dark gray)
      if (col < threshold) {
        //Add the X and Y coordinates to the list
        list.add(new PVector(ix, iy));
      }
    }
  }
//  println(threshold + " " + list.size());
}

