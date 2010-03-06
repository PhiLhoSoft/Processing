//WHAT IS WRONG WITH THE ROTATION IN DRAW
//when totalling no. of medals by nationality into new array, only append for country that is not in array already!
//need o sort this for re-sizing? - or is the pdf setup ok?

// Remarks by PhiLho are marked with //PL//

import processing.pdf.*;

//PL// Long variable names are good, but the Array suffix is a bit too much.
// Usually I just use the plural (or a name like List or Sequence) for array variables.
//PL// Added some spaces around operators to make code "breathe" and break visually long lines in smaller chunks.
//PL// And fixed indenting.

//SOURCE: http://espn.go.com/olympics/winter/2010/results/_/date/20100220
String[] sourceAddressesByDate = new String[17];//17 days of olympics.

String[] allWinningAthletes = new String[0];
char[] allWonMedals = new char[0];
String[] allWinningNationalities = new String[0];
String[] allMedalEvents = new String[0];
String[] allMedalWinDates = new String[0];

String[] fullDetails = new String[0];
String[] nationNumOfMedals= new String[0];

int goldMedalCounter = 0;//total of all golds.
int silverMedalCounter = 0;//total of all silvers.
int bronzeMedalCounter = 0;//total of all bronzes.

PFont font;
PFont bigFont;
int fontSize;
int bigFontSize;

int diameterOne;
float lastAng = 0;
int goldCount;
int silverCount;
int bronzeCount;

color bronzeColour = color(144, 127, 80);
color silverColour = color(206, 206, 206);
color goldColour = color(255, 215, 15);

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

    sourceAddressesByDate[i] = "http://espn.go.com/olympics/winter/2010/results/_/date/201002" + (12 + i);//gets the url of each day's results table.
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
          int startGetEvent = thisDaysEvents[n].indexOf("\"4\" > ") + 4;
          int endGetEvent = thisDaysEvents[n].indexOf("<", startGetEvent);
          String event = thisDaysEvents[n].substring(startGetEvent, endGetEvent);

          if (thisDaysEvents[n].indexOf("medalimage-G") >= 0) {//if there is a GOLD medal in the current event..

            int startGetGoldCountry = thisDaysEvents[n].indexOf("&nbsp") + 6;
            int endGetGoldCountry = thisDaysEvents[n].indexOf("&nbsp") + 9;
            String goldCountry = thisDaysEvents[n].substring(startGetGoldCountry, endGetGoldCountry);
            // println(goldCountry + " goldCountry");

            //PL// Replaced all expand() followed by assignment on last index by append(): shorter and easier to understand
            allWinningNationalities = append(allWinningNationalities, goldCountry);//adds the nation to the nations array.

            allWonMedals = append(allWonMedals, 'G');//adds the medal to the totals array.

            int preGetAthleteName = thisDaysEvents[n].indexOf("href") + 4;
            int startGetAthleteName = thisDaysEvents[n].indexOf(">", preGetAthleteName) + 1;
            int endGetAthleteName = thisDaysEvents[n].indexOf("<", startGetAthleteName);
            String athleteName = thisDaysEvents[n].substring(startGetAthleteName, endGetAthleteName);
            if ((athleteName.length() > 8) && (athleteName.substring(0, 8).equals("Complete"))) {// if it finds a team event instead of a name, rename to the event name.
              println("COMPLETE! - renaming to team event.");
              int getResultsIndex = athleteName.indexOf("Results");
              String renamedTeamEvent = athleteName.substring(9, getResultsIndex-1);
              athleteName = "Team Event - " + renamedTeamEvent;
            }

            allWinningAthletes = append(allWinningAthletes, athleteName);//adds the athlete to the winners array.
            // println(allWinningAthletes);

            allMedalEvents = append(allMedalEvents, event);//adds the nation to the nations array.

            allMedalWinDates = append(allMedalWinDates, sourceAddressesByDate[i].substring(55, 63));//adds the nation to the nations array.

            //PL// Same here, and replaced multiple x = x + "string" by multiple concatenation in single expression
            fullDetails = append(fullDetails, athleteName + "," + goldCountry + "," + event + "," +
                allWonMedals[allWonMedals.length-1] + "," + allMedalWinDates[allMedalWinDates.length-1]);
          }//end of gold.

          if (thisDaysEvents[n].indexOf("medalimage-S") >= 0) {//if there is a SILVER medal in the current event..

            int startGetSilverCountry = thisDaysEvents[n].indexOf("medalimage-S") + 12;
            int endGetSilverCountry = thisDaysEvents[n].indexOf("&nbsp", startGetSilverCountry) + 9;
            String silverCountry = thisDaysEvents[n].substring(endGetSilverCountry-3, endGetSilverCountry);
            // println(silverCountry + " silverCountry");

            allWinningNationalities = append(allWinningNationalities, silverCountry);//adds the nation to the nations array.

            allWonMedals = append(allWonMedals, 'S');//adds the medal to the totals array.

            int lookFromIndex = thisDaysEvents[n].indexOf("medalimage-S");
            int preGetAthleteName = thisDaysEvents[n].indexOf("href", lookFromIndex) + 4;
            int startGetAthleteName = thisDaysEvents[n].indexOf(">", preGetAthleteName) + 1;
            int endGetAthleteName = thisDaysEvents[n].indexOf("<", startGetAthleteName);
            String athleteName = thisDaysEvents[n].substring(startGetAthleteName, endGetAthleteName);
            if ((athleteName.length() > 8) && (athleteName.substring(0, 8).equals("Complete"))) {// if it finds a team event instead of a name, rename to the event name.
              println("COMPLETE! - renaming to team event.");
              int getResultsIndex = athleteName.indexOf("Results");
              String renamedTeamEvent = athleteName.substring(9, getResultsIndex-1);
              athleteName = "Team Event - " + renamedTeamEvent;
            }

            allWinningAthletes = append(allWinningAthletes, athleteName);//adds the athlete to the winners array.
            // println(allWinningAthletes);

            allMedalEvents = append(allMedalEvents, event);//adds the nation to the nations array.

            allMedalWinDates = append(allMedalWinDates, sourceAddressesByDate[i].substring(55, 63));//adds the nation to the nations array.

            fullDetails = append(fullDetails, athleteName + "," + silverCountry + "," + event + "," +
                allWonMedals[allWonMedals.length-1] + "," + allMedalWinDates[allMedalWinDates.length-1]);
          }//end of silver.

          if (thisDaysEvents[n].indexOf("medalimage-B") >= 0) {//if there is a BRONZE medal in the current event..

            int startGetBronzeCountry = thisDaysEvents[n].indexOf("medalimage-B") + 12;
            int endGetBronzeCountry = thisDaysEvents[n].indexOf("&nbsp", startGetBronzeCountry) + 9;
            String bronzeCountry = thisDaysEvents[n].substring(endGetBronzeCountry-3, endGetBronzeCountry);
            //   println(bronzeCountry + " bronzeCountry");

            allWinningNationalities = append(allWinningNationalities, bronzeCountry);//adds the nation to the nations array.

            allWonMedals = append(allWonMedals, 'B');//adds the medal to the totals array.

            int lookFromIndex = thisDaysEvents[n].indexOf("medalimage-B");
            int preGetAthleteName = thisDaysEvents[n].indexOf("href", lookFromIndex) + 4;
            int startGetAthleteName = thisDaysEvents[n].indexOf(">", preGetAthleteName) + 1;
            int endGetAthleteName = thisDaysEvents[n].indexOf("<", startGetAthleteName);
            String athleteName = thisDaysEvents[n].substring(startGetAthleteName, endGetAthleteName);
            if ((athleteName.length() > 8) && (athleteName.substring(0, 8).equals("Complete"))) {// if it finds a team event instead of a name, rename to the event name.
              println("COMPLETE! - renaming to team event.");
              int getResultsIndex = athleteName.indexOf("Results");
              String renamedTeamEvent = athleteName.substring(9, getResultsIndex-1);
              athleteName = "Team Event - " + renamedTeamEvent;
            }

            allWinningAthletes = append(allWinningAthletes, athleteName);//adds the athlete to the winners array.

            allMedalEvents = append(allMedalEvents, event);//adds the nation to the nations array.

            allMedalWinDates = append(allMedalWinDates, sourceAddressesByDate[i].substring(55, 63));//adds the nation to the nations array.

            fullDetails = append(fullDetails, athleteName + "," + bronzeCountry + "," + event + "," +
                allWonMedals[allWonMedals.length-1] + "," + allMedalWinDates[allMedalWinDates.length-1]);
          }//end of bronze.

          //      if (thisDaysEvents[n].indexOf("medalimage") < 0) {//if there are no medals to get for the event..
          //        println("No medals awarded for this event");
          //      }

        }//end of every event loop.
      }//end of group loop.
    }//end of if source != null.

  }//end of main loop.

}//end of setup.




void draw() {
  noLoop();//----------------------------------------------------------WHAT IS WRONG WITH THE ROTATION IN DRAW?
  noStroke();
  background(255);
  // println("ATHLETES!");
  // println(allWinningAthletes);
  // println(allWonMedals);
  // println(allWinningNationalities);
  //  println(allMedalEvents);
  // println(allMedalWinDates);
  //println(fullDetails);

  String[] fullDetailsAlpha;
  fullDetailsAlpha= sort(fullDetails);//sorts full array by name order.
  println(fullDetailsAlpha);

  int arrayLength = fullDetails.length;
  float degreesPerMedal = 360/arrayLength;//calculates degrees of a circle per medal winner.
//-----------------------------//-----------------------------//-----------------------------//-----------------------------//-----------------------------

  String[] allNationalitiesOrdered;
  allNationalitiesOrdered = sort(allWinningNationalities);
  String allNationalitiesList = join(allNationalitiesOrdered,  " ");//orders and joins all nationalities array for counting.

  for (int i = 0; i < allNationalitiesOrdered.length; i++) {

    String nationalityNow = allNationalitiesOrdered[i];
    int index = 0;
    int count = 0;
    while(allNationalitiesList.indexOf(nationalityNow,index) >= 0) {
      count++;
      index=allNationalitiesList.indexOf(nationalityNow,index) + 3; //search from after this occurance next time...
    }
    //println(count + " " + nationalityNow + " medals");

    for (int b = 0; b < nationNumOfMedals.length; b++) {
      if (nationNumOfMedals[b].indexOf(nationalityNow) < 0) {//if it doesnt find this country/medal in the array already continue...---------------------WORKS BUT ADDS FAR TOO MANY HERE!
        nationNumOfMedals = append(nationNumOfMedals, nationalityNow + " " + count);//adds nation + medalcount to a new array.
      }
    }
  }
  //println(nationNumOfMedals);
//-----------------------------//-----------------------------//-----------------------------//-----------------------------//-----------------------------

  for (int i = 0; i < allWonMedals.length; i++) {//goes through all medals won..
    //PL// x++ is better than x += 1 which is better than x = x + 1...
    if (allWonMedals[i] == 'G') {//counts gold medals.
      goldMedalCounter++;
    }
    else if (allWonMedals[i] == 'S') {//counts gold medals.
      silverMedalCounter++;
    }
    else if (allWonMedals[i] == 'B') {//counts gold medals.
      bronzeMedalCounter++;
    }
  }

  //println(goldMedalCounter + " golds");
  //println(silverMedalCounter + " silvers");
  //println(bronzeMedalCounter + " bronzes");
  int[] medalTotals = {
    goldMedalCounter, silverMedalCounter, bronzeMedalCounter
  };
  float goldMedalsTotalMappedToCircle = map(goldMedalCounter, 0, arrayLength, 0, 360);
  float silverMedalsTotalMappedToCircle = map(silverMedalCounter, 0, arrayLength, 0, 360);
  float bronzeMedalsTotalMappedToCircle = map(bronzeMedalCounter, 0, arrayLength, 0, 360);
  ///println(goldMedalsTotalMappedToCircle + "goldMedalsTotalMappedToCircle");
  ///println(silverMedalsTotalMappedToCircle + "silverMedalsTotalMappedToCircle");
  ///println(bronzeMedalsTotalMappedToCircle + "bronzeMedalsTotalMappedToCircle");
  float[] medalTotalsMappedToCircle = {
    goldMedalsTotalMappedToCircle, silverMedalsTotalMappedToCircle, bronzeMedalsTotalMappedToCircle
  };

  float goldMedalsAngle = goldMedalsTotalMappedToCircle/goldMedalCounter;
  float silverMedalsAngle = silverMedalsTotalMappedToCircle/silverMedalCounter;
  float bronzeMedalsAngle = bronzeMedalsTotalMappedToCircle/bronzeMedalCounter;

  for (int i = 0; i < medalTotalsMappedToCircle.length; i++) {//draws 3 slices for medal colours.
    if (i == 0) {//if its drawing the golds..
      fill(goldColour);
    }
    else if (i == 1) {//if it's drawing silvers..
      fill(silverColour);
    }
    else if (i == 2) {//if it's drawing bronzes..
      fill(bronzeColour);
    }
    arc(width/2, height/2, diameterOne, diameterOne, lastAng, lastAng + radians(medalTotalsMappedToCircle[i]));//draws an arc for g, s, & b.
    lastAng += radians(medalTotalsMappedToCircle[i]);//adds last angle on to make slices join properly.
    fill(255);
    ellipse(width/2, height/2, diameterOne*0.9, diameterOne*0.9);//clears the centre of the circle.
    textFont(bigFont);
    fill(0);
    textAlign(CENTER);
    text("Vancouver 2010", width/2, height/2);
    text("Medalists", width/2, (height/2) + bigFontSize);
    textFont(font);
    textAlign(LEFT);
  }

  int getMedalFromFinal;

  translate(width/2, height/2);//translates everything to centre.

  for (int i = 0; i < fullDetailsAlpha.length; i++) {//loops through final collected array.
    // ---------------------
    getMedalFromFinal = fullDetailsAlpha[i].indexOf(",G,");
    if (getMedalFromFinal > 0) {//if it finds a gold medal..
      goldCount++;
      int getCommaOneFromFinal = fullDetailsAlpha[i].indexOf(",");//finds the first comma..
      String goldMedallist = fullDetailsAlpha[i].substring(0, getCommaOneFromFinal);
      println(goldMedallist + " " + goldCount);
      fill(goldColour);
      pushMatrix();
      rotate(radians(((goldCount-1)*goldMedalsAngle) + degreesPerMedal));
      text(goldMedallist, diameterOne, 0);//lists names.

      int getCommaBeforeNationality = fullDetailsAlpha[i].indexOf(",");
      int getCommaAfterNationality = fullDetailsAlpha[i].indexOf(",", getCommaBeforeNationality + 1);
      String nationality = fullDetailsAlpha[i].substring(getCommaBeforeNationality + 1, getCommaAfterNationality);//gets nationality.
      //println(nationality + " nationality");
      PImage flag = loadImage(nationality + ".gif");
      println(flag.width + " " + flag.height);
      if (flag != null) {
        image(flag, diameterOne/2, 0, 8, 5);
      }
      popMatrix();
    }
    //  ---------------------

    getMedalFromFinal = fullDetailsAlpha[i].indexOf(",S,");
    if (getMedalFromFinal > 0) {//if it finds a silver medal..
      silverCount = silverCount + 1;
      int getCommaOneFromFinal = fullDetailsAlpha[i].indexOf(",");//finds the first comma..
      String silverMedallist = fullDetailsAlpha[i].substring(0, getCommaOneFromFinal);
      println(silverMedallist + " " + silverCount);
      fill(silverColour);
      pushMatrix();
      rotate(radians(goldMedalsTotalMappedToCircle + (((silverCount-1)*silverMedalsAngle) + degreesPerMedal)));
      text(silverMedallist, diameterOne, 0);

      int getCommaBeforeNationality = fullDetailsAlpha[i].indexOf(",");
      int getCommaAfterNationality = fullDetailsAlpha[i].indexOf(",", getCommaBeforeNationality + 1);
      String nationality = fullDetailsAlpha[i].substring(getCommaBeforeNationality + 1, getCommaAfterNationality);//gets nationality.
      //println(nationality + " nationality");
      PImage flag = loadImage(nationality + ".gif");
      println(flag.width + " " + flag.height);
      if (flag != null) {
        image(flag, diameterOne/2, 0, 8, 5);
      }
      popMatrix();
    }
    //  ---------------------

    getMedalFromFinal = fullDetailsAlpha[i].indexOf(",B,");
    if (getMedalFromFinal > 0) {//if it finds a bronze medal..
      bronzeCount++;
      int getCommaOneFromFinal = fullDetailsAlpha[i].indexOf(",");//finds the first comma..
      String bronzeMedallist = fullDetailsAlpha[i].substring(0, getCommaOneFromFinal);
      println(bronzeMedallist + " " + bronzeCount);
      fill(bronzeColour);
      pushMatrix();
      rotate(radians(goldMedalsTotalMappedToCircle + silverMedalsTotalMappedToCircle + (((bronzeCount-1)*bronzeMedalsAngle) + degreesPerMedal)));
      text(bronzeMedallist, diameterOne, 0);

      int getCommaBeforeNationality = fullDetailsAlpha[i].indexOf(",");
      int getCommaAfterNationality = fullDetailsAlpha[i].indexOf(",", getCommaBeforeNationality + 1);
      String nationality = fullDetailsAlpha[i].substring(getCommaBeforeNationality + 1, getCommaAfterNationality);//gets nationality.
      //println(nationality + " nationality");
      PImage flag = loadImage(nationality + ".gif");
      println(flag.width + " " + flag.height);
      if (flag != null) {
        image(flag, diameterOne/2, 0, 8, 5);
      }
      popMatrix();
    }
  }

  exit();
}//end of draw.

