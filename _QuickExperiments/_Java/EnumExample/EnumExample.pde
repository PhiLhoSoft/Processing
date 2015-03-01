final String SPECIAL_DAY = "FRIDAY"; 
enum Day { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY };

void setup()
{
  for (Day day : Day.values())
  {
    println(day.ordinal() + ". " + day);
    switch (day)
    {
      case SATURDAY:
      case SUNDAY:
        println("Weekend!");
        break;
      case FRIDAY:
        if (day == Enum.valueOf(Day.class, SPECIAL_DAY))
          println("Almost the weekdend!");
        break;
      default:
        println("Let's go to work...");
    }
  }
  exit();
}
