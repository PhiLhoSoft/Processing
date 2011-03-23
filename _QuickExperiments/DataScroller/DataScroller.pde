int DATA_SIZE = 100;
float[] data = new float[DATA_SIZE];
int counter;

void setup()
{
  size(500, 200);
  smooth();
  frameRate(5);
  noiseDetail(2);
  noiseSeed(System.currentTimeMillis());
  
  for (int i = 0; i < DATA_SIZE; i++)
  {
    data[i] = getValue();
  }
}

void draw()
{
  background(255);
  fill(#005599);
  text(data[0], 10, 20);

  for (int i = 1; i < data.length; i++)
  {
    line(i * 5, data[i -1], (i + 1) * 5, data[i]);
    data[i - 1] = data[i];
  }
  data[DATA_SIZE - 1] = getValue();
}

float getValue()
{
  return map(noise(counter++ * 0.1), 0.0, 1.0, 10.0, height - 10.0);
}

