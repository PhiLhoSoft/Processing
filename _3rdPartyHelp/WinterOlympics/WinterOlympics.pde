//WHAT IS WRONG WITH THE ROTATION IN DRAW
//when totalling no. of medals by nationality into new array, only append for country that is not in array already!
//need o sort this for re-sizing? - or is the pdf setup ok?

// Code by Ladle (Sam Humphrey)
// Various refactoring by PhiLho (Philippe Lhoste)
// Remarks by PhiLho are marked with //PL//

import processing.pdf.*;


//SOURCE: http://espn.go.com/olympics/winter/2010/results/_/date/20100220
String[] sourceAddressesByDate = new String[17];//17 days of olympics.

String[] nationNumOfMedals= new String[0];

int goldMedalCounter = 0;//total of all golds.
int silverMedalCounter = 0;//total of all silvers.
int bronzeMedalCounter = 0;//total of all bronzes.

final String MEDAL_IMAGE_GOLD = "medalimage-G";
final String MEDAL_IMAGE_SILVER = "medalimage-S";
final String MEDAL_IMAGE_BRONZE = "medalimage-B";

PFont font;
PFont bigFont;
int fontSize;
int bigFontSize;

int diameterOne;
float lastAng = 0;
float degreesPerMedal;
int goldCount;
int silverCount;
int bronzeCount;

color bronzeColour = color(144, 127, 80);
color silverColour = color(206, 206, 206);
color goldColour = color(255, 215, 15);

class MedalInformation
{
  String athleteName;
  String country;
  String event;
  char medal;
  String winDate;

  // Override a fundamental method (found on all objects) to make personalized
  // textual output of this class
  public String toString()
  {
    return "MedalInformation: " + athleteName + " (" +
        country + ") " + event + " -> " + medal + " (" + winDate + ")";
  }
}

// Comparator is an interface: it is a contract, a way to say
// "the class implementing this interface guarantee to have the methods defined in this interface,
// so I can safely call them".
class CompareNames implements Comparator
{
  // Comparator defines only the compare() method, which takes two objects (of same type)
  // and return an int: < 0 if o1 < o2, == 0 if o1 == o2 and > 0 if o1 > o2
  public int compare(Object o1, Object o2)
  {
    // We are given untyped objects, we must cast them back to their type to access fields or methods
    // We use String's natural comparison method
    return ((MedalInformation) o1).athleteName.compareTo(((MedalInformation) o2).athleteName);
  }
}
class CompareEvent implements Comparator
{
  public int compare(Object o1, Object o2)
  {
    return ((MedalInformation) o1).event.compareTo(((MedalInformation) o2).event);
  }
}
class CompareCompound implements Comparator
{
  public int compare(Object o1, Object o2)
  {
    // First sort by country
    MedalInformation mi1 = (MedalInformation) o1;
    MedalInformation mi2 = (MedalInformation) o2;
    if (mi1.country.equals(mi2.country))
    {
      // Same country, compare by athlete's last name
      int p1 = mi1.athleteName.indexOf(" ");
      String name1 = mi1.athleteName;
      if (p1 > 0)
      {
        name1 = name1.substring(p1 + 1);
      }
      int p2 = mi2.athleteName.indexOf(" ");
      String name2 = mi2.athleteName;
      if (p2 > 0)
      {
        name2 = name2.substring(p2 + 1);
      }
      return name1.compareTo(name2);
    }
    else
    {
      // Compare by country
      return mi1.country.compareTo(mi2.country);
    }
  }
}

ArrayList allMedalInformation = new ArrayList();

void setup() {
  size(1000, 1000, PDF, "filename.pdf");
  diameterOne = width/4;
  fontSize = diameterOne/45;
  bigFontSize = diameterOne/10;
  smooth();
  font = createFont("Arial", fontSize);
  bigFont = createFont("Arial", bigFontSize);
  textFont(font);
  fill(0);

  for (int i = 0; i < sourceAddressesByDate.length; i++) {//loop through the days..---------------------------------------------------------------------------------------------SKIPPING DAYS!!? - make sure this gets reset to 0.

    String medalWinDate = "201002" + (12 + i);
    sourceAddressesByDate[i] = "http://espn.go.com/olympics/winter/2010/results/_/date/" + medalWinDate;//gets the url of each day's results table.
    println("loading day" + (i + 1) + "strings");
    String[] tempDaySourceLines = loadStrings(sourceAddressesByDate[i]);

    if (tempDaySourceLines != null) {// if I've got the source strings & it's ok continue..
      String tempDaySource = join(tempDaySourceLines, " ");//joins all source for day.
      String[] currentDayGroupsSource = split(tempDaySource, "stathead");//splits the source into an array for each group( alpine/nordic etc).
      //println(sourceAddressesByDate[i]);
      //println(currentDayGroupsSource);//prints array of all the day's groups source.

      for (int b=1; b < currentDayGroupsSource.length; b++) {//loop through groups and split into events.
        String[] thisDaysEvents = split(currentDayGroupsSource[b], "colhead");//splits the group into events.
        //println(thisDaysEvents);//prints array of the day's events source.

        //THIS IS WITHIN EACH EVENT, OF ALL DAYS.
        for (int n=1; n < thisDaysEvents.length; n++) {//for every event this day..
          String dayEvent = thisDaysEvents[n];
          int startGetEvent = dayEvent.indexOf("\"4\">") + 4;
          int endGetEvent = dayEvent.indexOf("<", startGetEvent);
          String event = dayEvent.substring(startGetEvent, endGetEvent);

          ParseMedalData(dayEvent, event, medalWinDate, MEDAL_IMAGE_GOLD, 'G');
          ParseMedalData(dayEvent, event, medalWinDate, MEDAL_IMAGE_SILVER, 'S');
          ParseMedalData(dayEvent, event, medalWinDate, MEDAL_IMAGE_BRONZE, 'B');

          //      if (event.indexOf("medalimage") < 0) {//if there are no medals to get for the event..
          //        println("No medals awarded for this event");
          //      }

        }//end of every event loop.
      }//end of group loop.
    }//end of if source != null.

  }//end of main loop.

}//end of setup.



float goldMedalsTotalMappedToCircle;
float silverMedalsTotalMappedToCircle;
float bronzeMedalsTotalMappedToCircle;

void draw() {
  noLoop();//----------------------------------------------------------WHAT IS WRONG WITH THE ROTATION IN DRAW?
  noStroke();
  background(255);

//~   Collections.sort(allMedalInformation, new CompareNames());
//~   Collections.sort(allMedalInformation, new CompareEvent());
  Collections.sort(allMedalInformation, new CompareCompound());
  println(allMedalInformation);

  int arrayLength = allMedalInformation.size();
  degreesPerMedal = 360/arrayLength;//calculates degrees of a circle per medal winner.
//-----------------------------//-----------------------------//-----------------------------//-----------------------------//-----------------------------
/* TO DO: not used in result anyway
  String[] allNationalitiesOrdered;
  allNationalitiesOrdered = sort(allWinningNationalities);
  String allNationalitiesList = join(allNationalitiesOrdered,  " ");//orders and joins all nationalities array for counting.

  for (int i = 0; i < allNationalitiesOrdered.length; i++) {

    String nationalityNow = allNationalitiesOrdered[i];
    int index = 0;
    int count = 0;
    while (allNationalitiesList.indexOf(nationalityNow, index) >= 0) {
      count++;
      index = allNationalitiesList.indexOf(nationalityNow, index) + 3; //search from after this occurance next time...
    }
    //println(count + " " + nationalityNow + " medals");

    for (int b = 0; b < nationNumOfMedals.length; b++) {
      if (nationNumOfMedals[b].indexOf(nationalityNow) < 0) {//if it doesnt find this country/medal in the array already continue...---------------------WORKS BUT ADDS FAR TOO MANY HERE!
        nationNumOfMedals = append(nationNumOfMedals, nationalityNow + " " + count);//adds nation + medalcount to a new array.
      }
    }
  }
  //println(nationNumOfMedals);
*/
//-----------------------------//-----------------------------//-----------------------------//-----------------------------//-----------------------------

  for (int i = 0; i < allMedalInformation.size(); i++) {//goes through all medals won..
    MedalInformation mi = (MedalInformation) allMedalInformation.get(i);
    if (mi.medal == 'G') {//counts gold medals.
      goldMedalCounter++;
    }
    else if (mi.medal == 'S') {//counts gold medals.
      silverMedalCounter++;
    }
    else if (mi.medal == 'B') {//counts gold medals.
      bronzeMedalCounter++;
    }
  }

  //println(goldMedalCounter + " golds");
  //println(silverMedalCounter + " silvers");
  //println(bronzeMedalCounter + " bronzes");
  goldMedalsTotalMappedToCircle = map(goldMedalCounter, 0, arrayLength, 0, 360);
  silverMedalsTotalMappedToCircle = map(silverMedalCounter, 0, arrayLength, 0, 360);
  bronzeMedalsTotalMappedToCircle = map(bronzeMedalCounter, 0, arrayLength, 0, 360);
  //println(goldMedalsTotalMappedToCircle + "goldMedalsTotalMappedToCircle");
  //println(silverMedalsTotalMappedToCircle + "silverMedalsTotalMappedToCircle");
  //println(bronzeMedalsTotalMappedToCircle + "bronzeMedalsTotalMappedToCircle");

  for (int i = 0; i < 3; i++) {//draws 3 slices for medal colours.
    float totalMappedToCircle = 0;
    if (i == 0) {//if its drawing the golds..
      fill(goldColour);
      totalMappedToCircle = goldMedalsTotalMappedToCircle;
    }
    else if (i == 1) {//if it's drawing silvers..
      fill(silverColour);
      totalMappedToCircle = silverMedalsTotalMappedToCircle;
    }
    else if (i == 2) {//if it's drawing bronzes..
      fill(bronzeColour);
      totalMappedToCircle = bronzeMedalsTotalMappedToCircle;
    }
    arc(width/2, height/2, diameterOne, diameterOne, lastAng, lastAng + radians(totalMappedToCircle));//draws an arc for g, s, & b.
    lastAng += radians(totalMappedToCircle);//adds last angle on to make slices join properly.
  }
  fill(255);
  ellipse(width/2, height/2, diameterOne*0.9, diameterOne*0.9);//clears the centre of the circle.
  textFont(bigFont);
  fill(0);
  textAlign(CENTER);
  text("Vancouver 2010", width/2, height/2);
  text("Medalists", width/2, (height/2) + bigFontSize);
  textFont(font);
  textAlign(LEFT);

  translate(width/2, height/2); //translates everything to centre.

  for (int i = 0; i < allMedalInformation.size(); i++) { //loops through final collected array.
    MedalInformation mi = (MedalInformation) allMedalInformation.get(i);
    Draw('G', mi); // Gold medals
    Draw('S', mi); // Silver medals
    Draw('B', mi); // Bronze medals
  }
  println("Gold: " + goldCount + ", Silver: " + silverCount + ", Bonze: " + bronzeCount);

  exit();
}//end of draw.

void ParseMedalData(String dayEvent, String event, String medalWinDate, String medalImage, char medalSymbol)
{
  if (dayEvent.indexOf(medalImage) < 0)
    return; // There is no the information we look for

  MedalInformation info = new MedalInformation();
  allMedalInformation.add(info);

  info.event = event;
  info.medal = medalSymbol;
  info.winDate = medalWinDate;

  if (medalSymbol == 'G')
  {
    int startGetCountry = dayEvent.indexOf("&nbsp;") + 6;
    int endGetCountry = dayEvent.indexOf("&nbsp") + 9;
    info.country = dayEvent.substring(startGetCountry, endGetCountry);
  }
  else
  {
    int startGetCountry = dayEvent.indexOf(medalImage) + 12;
    int endGetCountry = dayEvent.indexOf("&nbsp", startGetCountry) + 9;
    info.country = dayEvent.substring(endGetCountry-3, endGetCountry);
  }

  int lookFromIndex = dayEvent.indexOf(medalImage);
  int preGetAthleteName = dayEvent.indexOf("href", lookFromIndex) + 4;
  int startGetAthleteName = dayEvent.indexOf(">", preGetAthleteName) + 1;
  int endGetAthleteName = dayEvent.indexOf("<", startGetAthleteName);
  String athleteName = dayEvent.substring(startGetAthleteName, endGetAthleteName);
  if ((athleteName.length() > 8) && (athleteName.substring(0, 8).equals("Complete"))) {// if it finds a team event instead of a name, rename to the event name.
    println("COMPLETE! - renaming to team event.");
    int getResultsIndex = athleteName.indexOf("Results");
    String renamedTeamEvent = athleteName.substring(9, getResultsIndex-1);
    athleteName = "Team Event - " + renamedTeamEvent;
  }
  info.athleteName = athleteName;
}

void Draw(char medalSymbol, MedalInformation info)
{
  if (info.medal != medalSymbol)
    return; // We don't process this one

//~   println(info.athleteName);
  float medalsAngle;
  pushMatrix();
  switch (medalSymbol)
  {
  case 'G':
    medalsAngle = goldMedalsTotalMappedToCircle/goldMedalCounter;
    goldCount++;
    fill(goldColour);
    rotate(radians(((goldCount - 1) * medalsAngle) + degreesPerMedal));
    break;
  case 'S':
    medalsAngle = silverMedalsTotalMappedToCircle/silverMedalCounter;
    silverCount++;
    fill(silverColour);
    rotate(radians(goldMedalsTotalMappedToCircle +
        (silverCount - 1) * medalsAngle + degreesPerMedal));
    break;
  case 'B':
    medalsAngle = bronzeMedalsTotalMappedToCircle/bronzeMedalCounter;
    bronzeCount++;
    fill(bronzeColour);
    rotate(radians(goldMedalsTotalMappedToCircle + silverMedalsTotalMappedToCircle +
        (bronzeCount - 1) * medalsAngle + degreesPerMedal));
    break;
  }
  text(info.athleteName, diameterOne, 0);

  PImage flag = loadImage(info.country + ".gif");
//~     println(flag.width + " " + flag.height);
  if (flag != null) {
    image(flag, diameterOne/2, 0, 8, 5);
  }
  popMatrix();
}
