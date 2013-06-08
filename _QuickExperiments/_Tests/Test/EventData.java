
class EventData
{
   String dateStart;
   String timeStart;
   String dateEnd;
   String timeEnd;
   String description;
   String summary;

   EventData()
   {

   }

   void ParseLine(String line)
   {
      String[] parts = line.split(":");
      String tag = parts[0];
      if (tag.equals("DTSTART"))
      {
         String[] d = parts[1].split("T");
         dateStart = d[0];
         timeStart = d[1];
      }
      else if (tag.equals("DTEND"))
      {
         String[] d = parts[1].split("T");
         dateEnd = d[0];
         timeEnd = d[1];
      }
      else if (tag.equals("DESCRIPTION"))
      {
         description = parts[1];
      }
      else if (tag.equals("SUMMARY"))
      {
         summary = parts[1];
      }
   }

   @Override
   public String toString()
   {
      return dateStart + " " + timeStart + " to " + dateEnd + " " + timeEnd +
            " > " + description + " (" + summary + ")";
   }
}
