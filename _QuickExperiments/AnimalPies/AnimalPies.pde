// Hard-coded here, should be read from a file
String[] lines =
{
  "10 45 35 0 10",
  "25 40 20 15 0",
  "0 50 10 20 20 ",
  "20 15 20 25 20",
  "5 10 15 20 25",
  "5 7 11 13 17 2 11 3 5 7 19"
};

PieChart[] pieCharts;

void setup()
{
  size(800, 200);
  pieCharts = new PieChart[lines.length];
  for (int i = 0; i < lines.length; i++)
  {
    pieCharts[i] = new PieChart(lines[i]);
  }
}

void draw()
{
  for (int i = 0; i < pieCharts.length; i++)
  {
    pushMatrix();
    translate(100 + i * 120, height/2);
    scale(100);
    pieCharts[i].display();
    popMatrix();
  }
}

class PieChart
{
  float[] values;
  color[] colors =
  {
    #FF0000, #00FF00, #0000FF, #FFFF00, #00FFFF,
    // Yes, there are slightly too much colors!
    #FF00FF, #000000, #FFFFFF
  };

  PieChart(String tsvValues)
  {
    String[] sValues = split(tsvValues, " ");
    values = new float[sValues.length];
    float total = 0;
    for (int i = 0; i < sValues.length; i++)
    {
      values[i] = float(sValues[i]);
      total += values[i];
    }
    if (total < 99.99 || total > 100.01) // Tolerate float rounding errors...
    {
      println("Warning! Incorrect total of values: " + total);
    }
  }

  void display()
  {
    noStroke();
    float startAngle = 0;
    for (int i = 0; i < values.length; i++)
    {
      fill(colors[i % colors.length]);
      // Angle proportional to value
      float pieAngle = (values[i] / 100) * TWO_PI;
      // Use normalized values, scale and translate
      // will give the wanted size/position
      arc(0, 0, 1, 1, startAngle, startAngle + pieAngle);
      startAngle += pieAngle;
    }
  }
}

