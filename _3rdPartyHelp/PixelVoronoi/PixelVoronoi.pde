float[] px = new float[0];
float[] py = new float[0];
float[] distance = new float[0];
color backgroundColor = color(155);

void setup()
{
  size(800, 480);
  rectMode(CENTER);
}

void draw()
{
}

void mousePressed()
{
  // add new point
  px = append(px, mouseX);
  py = append(py, mouseY);
  distance = append(distance, 0);
  if (distance.length<2) return;

  loadPixels();
  for (int y = 0; y < height; y++)
  {
    for (int x = 0; x < width; x++)
    {
      // calculate the distance between the pixel and each point
      for (int i = 0; i < px.length; i++)
      {
        distance[i] = dist(x, y, px[i], py[i]);
      }
      Arrays.sort(distance);
//      sortDistance();
      float diff = abs(distance[0] - distance[1]);
      color c = backgroundColor;
      if (diff <= 5)
      {
        c = color(255 - 20 * diff);
      }
      pixels[x + y * width] = c;
    }
  }
  updatePixels();

  // rendering points as rectangles
  fill(#AABB55);
  noStroke();
  for (int i = 0; i < px.length; i++)
  {
    rect(px[i], py[i], 10, 10);
  }
}

void sortDistance()
{
  for (int i = 0; i <px.length-1; i++)
  {
    for (int j = i; j < px.length; j++)
    {
      if (distance[i] > distance[j])
      {
        float d = distance[i];
        distance[i] = distance[j];
        distance[j] = d;
      }
    }
  }
}
