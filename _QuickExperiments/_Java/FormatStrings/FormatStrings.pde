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
  
  exit();
}

