PImage img;

void setup()
{
  size(512, 512);
  img = loadImageIO("G:/Images/Tests/NonWebFormats/Peppers 4.2.07.tiff");
  image(img, 0, 0);
}
