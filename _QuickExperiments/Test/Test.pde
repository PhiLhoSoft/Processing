Events events;
String[] lines;
int positionCount = 0;
String file = "events.ics";

//---------------------------------------------------------------------- -------------------
void setup()
{
  size(200, 200);
  fill(255);
  noLoop();
  
  if (online)
  {
    println(param("AParameter"));
  }

  lines = loadStrings(file);
  events = new Events(lines);

  println("How many events pulled from " + file + "? " + events.GetEventNb());

  for (int i = 0; i < events.GetEventNb(); i++)
  {
    EventData e = events.GetEvent(i);
    println(i + " > " + e);
  }
}
