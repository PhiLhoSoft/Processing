import java.util.*;
import java.util.Map.Entry;

NavigableMap<Float, Integer> values = new TreeMap<Float, Integer>();
final int TO_DISPLAY = 5;

void setup()
{
  size(500, 800);
  fill(0);
  textSize(24);
}

void draw()
{
  background(255);
  if (frameCount % 17 == 0) // Simulates data coming at a slower rate
  {
    values.put(random(-50, 50), frameCount);
  }

  int c = 0;
  for (Entry<Float, Integer> me : values.descendingMap().entrySet())
  {
    if (c > TO_DISPLAY)
      break;
      
    text(
        nf(me.getValue().intValue(), 2, 0) + "   " + 
        nf(me.getKey().floatValue(), 2, 3),
       10, 30 + c * 30); 
    c++;
  }
}

