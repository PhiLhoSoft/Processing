void setup()
{
  size(200, 100);

  // The string as typed by the user
  String gradient = "#000000, #ff0000, #00ff00";
  // Although I would just ask for a simpler input:
  // (less to type!)
  String gradient2 = "0000FF ff00FF FFff00";
  
  // Anyway, I can transform the former to the latter!
  String gradient1 = gradient.replaceAll("[#,]", "");
  
  // And get an array out of that:
  String[] stringGradientStops1 = gradient1.split(" ");
  String[] stringGradientStops2 = gradient2.split(" ");
  
  color[] ca = GetGradientStops(stringGradientStops1);
  ShowColors(ca, 10);
  ca = GetGradientStops(stringGradientStops2);
  ShowColors(ca, 50);
}

color[] GetGradientStops(String[] strGrStops)
{
  color[] colors = new color[strGrStops.length];
  for (int i = 0; i < strGrStops.length; i++)
  {
    try 
    {
      // Convert to opaque color
      println("Converting " + strGrStops[i] + " (" + i + ")");
      colors[i] = 0xFF000000 + unhex(strGrStops[i]);
      println("Got " + hex(colors[i]));
    }
    catch (NumberFormatException nfe)
    {
      println("Problem with " + strGrStops[i] + " (" + i + ")");
      colors[i] = #FFFFFF;
    }
  }
  return colors;
}

void ShowColors(color[] colors, int yPos)
{
  for (int i = 0; i < colors.length; i++)
  {
    fill(colors[i]);
    rect(10 + i * 40, yPos, 30, 30);
  }
}

