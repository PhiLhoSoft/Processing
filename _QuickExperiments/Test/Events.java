import java.util.ArrayList;

class Events
{
   static final String endTag = "END:VEVENT";

   private ArrayList<EventData> events;
   private String icsLines;

   Events(String[] lines)
   {
      events = new ArrayList<EventData>();
      EventData event = new EventData();
      for (int i = 0; i < lines.length; i++)
      {
         if (lines[i].equals(endTag))
         {
            events.add(event);
            event = new EventData();
         }
         else
         {
            event.ParseLine(lines[i]);
         }
      }
   }

   int GetEventNb()
   {
      return events.size();
   }

   EventData GetEvent(int i)
   {
      return events.get(i);
   }
}
