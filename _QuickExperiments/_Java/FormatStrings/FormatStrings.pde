import java.util.*;

final String format = "This year is {0,number,integer} days " +
    "{1,number,integer} hours {2,number,integer} minutes " +
    "and {3,number,integer} seconds old";

void setup()
{
  Date date = new Date(); // Today
  DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  Date past = null;
  try
  {
    past = new Date(df.parse("2011-01-01 00:00:00").getTime());
  }
  catch (ParseException e)
  {
    e.printStackTrace();
    exit();
    return;
  }
  long seconds = (date.getTime() - past.getTime()) / 1000;
  long minutes = seconds / 60;
  long hours = minutes / 60;
  long days = hours / 24;
  seconds -= minutes * 60;
  minutes -= hours * 60;
  hours -= days * 24;
  
  String message = MessageFormat.format(format,
      days,
      hours,
      minutes,
      seconds
  );
  println(message);
  
  String scoreMsg = "Your score is %5d point%s";
  String msg = String.format(scoreMsg, seconds, seconds == 1 ? "" : "s");
  println(msg);
  msg = String.format(scoreMsg, seconds * 314, seconds == 1 ? "" : "s");
  println(msg);
  
  println("\n\n");
  showParsingFormattting();
  
  exit();
}

void showParsingFormattting()
{
  // https://forum.processing.org/topic/sorting-arraylists-by-date-object
  
  String dateString = "Fri Mar 30 14:27:17 CDT 2012";
  DateFormat parser = new SimpleDateFormat("EEE MMM d HH:mm:ss z yyyy", Locale.US);
  Date date = parseDate(dateString, parser);
  
  println(date);
  
  DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss"); // Iso format
  println(formatter.format(date));
  
  println(date.getTime() / 1000 / 3600);
  String secondDateString = "Fri Mar 30 15:33:17 CDT 2012";
  Date secondDate = parseDate(secondDateString, parser);
  println((secondDate.getTime() - date.getTime()) / 1000 / 3600.0);
}

Date parseDate(String dateString, DateFormat parser)
{
  Date date = null;
  try
  {
    date = parser.parse(dateString);
  }
  catch (ParseException e)
  {
    println("Incorrect format of date! " + e.getMessage());
  }
  return date;
}

