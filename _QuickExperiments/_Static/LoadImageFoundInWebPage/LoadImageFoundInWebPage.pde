// https://forum.processing.org/topic/load-image-from-web-13-7-2012

String URL_BASE = "http://apod.nasa.gov/apod/";
String URL_PAGE = "astropix.html";

PImage astroImage;

// Optional spaces, the IMG tag and its attribute, capture of the URL, anything after it
Pattern pat = Pattern.compile("\\s*<IMG SRC=\"(image/.*?)\".*");

void setup()
{
  size(1024, 768);
  frameRate(30);
  
  DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
  String imageName = "Nasa-" + df.format(new Date()) + ".jpg";
  
  String url = findImageURL(URL_BASE + URL_PAGE);
  if (url != null) // Found
  {
    astroImage = loadCachedImage(imageName, URL_BASE + url);
  }
}

void draw()
{
  image(astroImage, 0, 0);
}

String findImageURL(String pageURL)
{
  String url = null;
  String[] lines = loadStrings(pageURL);
  for (String line : lines)
  {
    Matcher m = pat.matcher(line);
    if (m.matches())
    {
      url = m.group(1);
      break;
    }
  }
  return url;
}

PImage loadCachedImage(String fileName, String url)
{
  PImage img = loadImage(fileName);
  if (img == null) // Not downloaded yet
  {
    img = loadImage(url);
    if (img != null)
    {
      img.save(fileName); // Cache of the file
    }
    else
    {
      println("Unable to load the image from " + url);
      exit();
    }
  }
  return img;
}


