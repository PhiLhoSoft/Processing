//WHAT IS WRONG WITH THE ROTATION IN DRAW
//when totalling no. of medals by nationality into new array, only append for country that is not in array already!
//need o sort this for re-sizing? - or is the pdf setup ok?

import processing.pdf.*;


//SOURCE: http://espn.go.com/olympics/winter/2010/results/_/date/20100220
String[] sourceAddressesByDateArray = new String[17];//17 days of olympics.

String[] allWinningAthletesArray = new String[0];
char[] allWonMedalsArray = new char[0];
String[] allWinningNationalitiesArray = new String[0];
String[] allMedalEventsArray = new String[0];
String[] allMedalWinDates = new String[0];

String[] fullDetailsArray = new String[0];
String[] nationNumOfMedalsArray= new String[0];

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

void setup(){
  size(1000, 1000, PDF, "filename.pdf");
  diameterOne = width/4;
  fontSize = diameterOne/45;
  bigFontSize = diameterOne/10;
  smooth();
  font = createFont("Arial", fontSize);
  bigFont = createFont("Arial", bigFontSize);
  textFont(font);
  fill(0);
  for(int i=0; i<sourceAddressesByDateArray.length; i++){//loop through the days..---------------------------------------------------------------------------------------------SKIPPING DAYS!!? - make sure this gets reset to 0.

      sourceAddressesByDateArray[i] = "http://espn.go.com/olympics/winter/2010/results/_/date/201002"+(12+i);//gets the url of each day's results table.
    println("loading day"+(i+1)+"strings");
    String[] tempDaySourceLines = loadStrings(sourceAddressesByDateArray[i]);

    if(tempDaySourceLines != null){// if I've got the source strings & it's ok continue..
      String tempDaySource = join(tempDaySourceLines, " ");//joins all source for day.
      String[] currentDayGroupsSourceArray = split(tempDaySource, "stathead");//splits the source into an array for each group( alpine/nordic etc).
      //println(sourceAddressesByDateArray[i]);
      //println(currentDayGroupsSourceArray);//prints array of all the day's groups source.

      for(int b=1; b<currentDayGroupsSourceArray.length; b++){//loop through groups and split into events.
        String[] thisDaysEventsArray = split(currentDayGroupsSourceArray[b], "colhead");//splits the group into events.
        //println(thisDaysEventsArray);//prints array of the day's events source.

        //THIS IS WITHIN EACH EVENT, OF ALL DAYS.
        for(int n=1; n<thisDaysEventsArray.length; n++){//for every event this day..
          int startGetEvent = thisDaysEventsArray[n].indexOf("\"4\">")+4;
          int endGetEvent = thisDaysEventsArray[n].indexOf("<", startGetEvent);
          String event = thisDaysEventsArray[n].substring(startGetEvent, endGetEvent);

          if(thisDaysEventsArray[n].indexOf("medalimage-G")>=0){//if there is a GOLD medal in the current event..
            fullDetailsArray = expand(fullDetailsArray, fullDetailsArray.length+1);//adds a row to the full details array.

            int startGetGoldCountry = thisDaysEventsArray[n].indexOf("&nbsp")+6;
            int endGetGoldCountry = thisDaysEventsArray[n].indexOf("&nbsp")+9;
            String goldCountry = thisDaysEventsArray[n].substring(startGetGoldCountry, endGetGoldCountry);
            // println(goldCountry+" goldCountry");

            allWinningNationalitiesArray = expand(allWinningNationalitiesArray, allWinningNationalitiesArray.length+1);//adds the nation to the nations array.
            allWinningNationalitiesArray[allWinningNationalitiesArray.length-1] = goldCountry;

            allWonMedalsArray = expand(allWonMedalsArray, allWonMedalsArray.length+1);//adds the medal to the totals array.
            allWonMedalsArray[allWonMedalsArray.length-1] = 'G';

            int preGetAthleteName = thisDaysEventsArray[n].indexOf("href")+4;
            int startGetAthleteName = thisDaysEventsArray[n].indexOf(">", preGetAthleteName)+1;
            int endGetAthleteName = thisDaysEventsArray[n].indexOf("<", startGetAthleteName);
            String athleteName = thisDaysEventsArray[n].substring(startGetAthleteName, endGetAthleteName);
            if((athleteName.length()>8) && (athleteName.substring(0, 8).equals("Complete") == true)){// if it finds a team event instead of a name, rename to the event name.
              println("COMPLETE! - renaming to team event.");
              int getResultsIndex = athleteName.indexOf("Results");
              String renamedTeamEvent = athleteName.substring(9, getResultsIndex-1);
              athleteName = "Team Event - "+renamedTeamEvent;
            }

            allWinningAthletesArray = expand(allWinningAthletesArray, allWinningAthletesArray.length+1);//adds the athlete to the winners array.
            allWinningAthletesArray[allWinningAthletesArray.length-1] = athleteName;
            // println(allWinningAthletesArray);

            allMedalEventsArray = expand(allMedalEventsArray, allMedalEventsArray.length+1);//adds the nation to the nations array.
            allMedalEventsArray[allMedalEventsArray.length-1] = event;

            allMedalWinDates = expand(allMedalWinDates, allMedalWinDates.length+1);//adds the nation to the nations array.
            allMedalWinDates[allMedalWinDates.length-1] = sourceAddressesByDateArray[i].substring(55, 63);

            fullDetailsArray[fullDetailsArray.length-1] = athleteName;
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+goldCountry;
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+event;
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+allWonMedalsArray[allWonMedalsArray.length-1];
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+allMedalWinDates[allMedalWinDates.length-1];
          }//end of gold.

          if(thisDaysEventsArray[n].indexOf("medalimage-S")>=0){//if there is a SILVER medal in the current event..
            fullDetailsArray = expand(fullDetailsArray, fullDetailsArray.length+1);//adds a row to the full details array.
            int startGetSilverCountry = thisDaysEventsArray[n].indexOf("medalimage-S")+12;
            int endGetSilverCountry = thisDaysEventsArray[n].indexOf("&nbsp", startGetSilverCountry)+9;
            String silverCountry = thisDaysEventsArray[n].substring(endGetSilverCountry-3, endGetSilverCountry);
            // println(silverCountry+" silverCountry");

            allWinningNationalitiesArray = expand(allWinningNationalitiesArray, allWinningNationalitiesArray.length+1);//adds the nation to the nations array.
            allWinningNationalitiesArray[allWinningNationalitiesArray.length-1] = silverCountry;

            allWonMedalsArray = expand(allWonMedalsArray, allWonMedalsArray.length+1);//adds the medal to the totals array.
            allWonMedalsArray[allWonMedalsArray.length-1] = 'S';

            int lookFromIndex = thisDaysEventsArray[n].indexOf("medalimage-S");
            int preGetAthleteName = thisDaysEventsArray[n].indexOf("href", lookFromIndex)+4;
            int startGetAthleteName = thisDaysEventsArray[n].indexOf(">", preGetAthleteName)+1;
            int endGetAthleteName = thisDaysEventsArray[n].indexOf("<", startGetAthleteName);
            String athleteName = thisDaysEventsArray[n].substring(startGetAthleteName, endGetAthleteName);
            if((athleteName.length()>8) && (athleteName.substring(0, 8).equals("Complete") == true)){// if it finds a team event instead of a name, rename to the event name.
              println("COMPLETE! - renaming to team event.");
              int getResultsIndex = athleteName.indexOf("Results");
              String renamedTeamEvent = athleteName.substring(9, getResultsIndex-1);
              athleteName = "Team Event - "+renamedTeamEvent;
            }

            allWinningAthletesArray = expand(allWinningAthletesArray, allWinningAthletesArray.length+1);//adds the athlete to the winners array.
            allWinningAthletesArray[allWinningAthletesArray.length-1] = athleteName;
            // println(allWinningAthletesArray);

            allMedalEventsArray = expand(allMedalEventsArray, allMedalEventsArray.length+1);//adds the nation to the nations array.
            allMedalEventsArray[allMedalEventsArray.length-1] = event;

            allMedalWinDates = expand(allMedalWinDates, allMedalWinDates.length+1);//adds the nation to the nations array.
            allMedalWinDates[allMedalWinDates.length-1] = sourceAddressesByDateArray[i].substring(55, 63);

            fullDetailsArray[fullDetailsArray.length-1] = athleteName;
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+silverCountry;
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+event;
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+allWonMedalsArray[allWonMedalsArray.length-1];
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+allMedalWinDates[allMedalWinDates.length-1];
          }//end of silver.

          if(thisDaysEventsArray[n].indexOf("medalimage-B")>=0){//if there is a BRONZE medal in the current event..
            fullDetailsArray = expand(fullDetailsArray, fullDetailsArray.length+1);//adds a row to the full details array.
            int startGetBronzeCountry = thisDaysEventsArray[n].indexOf("medalimage-B")+12;
            int endGetBronzeCountry = thisDaysEventsArray[n].indexOf("&nbsp", startGetBronzeCountry)+9;
            String bronzeCountry = thisDaysEventsArray[n].substring(endGetBronzeCountry-3, endGetBronzeCountry);
            //   println(bronzeCountry+" bronzeCountry");

            allWinningNationalitiesArray = expand(allWinningNationalitiesArray, allWinningNationalitiesArray.length+1);//adds the nation to the nations array.
            allWinningNationalitiesArray[allWinningNationalitiesArray.length-1] = bronzeCountry;

            allWonMedalsArray = expand(allWonMedalsArray, allWonMedalsArray.length+1);//adds the medal to the totals array.
            allWonMedalsArray[allWonMedalsArray.length-1] = 'B';

            int lookFromIndex = thisDaysEventsArray[n].indexOf("medalimage-B");
            int preGetAthleteName = thisDaysEventsArray[n].indexOf("href", lookFromIndex)+4;
            int startGetAthleteName = thisDaysEventsArray[n].indexOf(">", preGetAthleteName)+1;
            int endGetAthleteName = thisDaysEventsArray[n].indexOf("<", startGetAthleteName);
            String athleteName = thisDaysEventsArray[n].substring(startGetAthleteName, endGetAthleteName);
            if((athleteName.length()>8) && (athleteName.substring(0, 8).equals("Complete") == true)){// if it finds a team event instead of a name, rename to the event name.
              println("COMPLETE! - renaming to team event.");
              int getResultsIndex = athleteName.indexOf("Results");
              String renamedTeamEvent = athleteName.substring(9, getResultsIndex-1);
              athleteName = "Team Event - "+renamedTeamEvent;
            }

            allWinningAthletesArray = expand(allWinningAthletesArray, allWinningAthletesArray.length+1);//adds the athlete to the winners array.
            allWinningAthletesArray[allWinningAthletesArray.length-1] = athleteName;

            allMedalEventsArray = expand(allMedalEventsArray, allMedalEventsArray.length+1);//adds the nation to the nations array.
            allMedalEventsArray[allMedalEventsArray.length-1] = event;

            allMedalWinDates = expand(allMedalWinDates, allMedalWinDates.length+1);//adds the nation to the nations array.
            allMedalWinDates[allMedalWinDates.length-1] = sourceAddressesByDateArray[i].substring(55, 63);

            fullDetailsArray[fullDetailsArray.length-1] = athleteName;
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+bronzeCountry;
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+event;
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+allWonMedalsArray[allWonMedalsArray.length-1];
            fullDetailsArray[fullDetailsArray.length-1] = fullDetailsArray[fullDetailsArray.length-1]+","+allMedalWinDates[allMedalWinDates.length-1];
          }//end of bronze.

          //      if(thisDaysEventsArray[n].indexOf("medalimage")<0){//if there are no medals to get for the event..
          //        println("No medals awarded for this event");
          //      }



        }//end of every event loop.
      }//end of group loop.
    }//end of if source != null.

  }//end of main loop.


}//end of setup.




void draw(){
  noLoop();//----------------------------------------------------------WHAT IS WRONG WITH THE ROTATION IN DRAW?
  noStroke();
  background(255);
  // println("ATHLETES!");
  // println(allWinningAthletesArray);
  // println(allWonMedalsArray);
  // println(allWinningNationalitiesArray);
  //  println(allMedalEventsArray);
  // println(allMedalWinDates);
  //println(fullDetailsArray);

  String[] fullDetailsArrayAlpha;
  fullDetailsArrayAlpha= sort(fullDetailsArray);//sorts full array by name order.
  println(fullDetailsArrayAlpha);

  int arrayLength = fullDetailsArray.length;
  float degreesPerMedal = 360/arrayLength;//calculates degrees of a circle per medal winner.
//-----------------------------//-----------------------------//-----------------------------//-----------------------------//-----------------------------

  String[] allNationalitiesOrdered;
  allNationalitiesOrdered = sort(allWinningNationalitiesArray);
  String allNationalitiesList = join(allNationalitiesOrdered,  " ");//orders and joins all nationalities array for counting.

 for(int i=0; i<allNationalitiesOrdered.length; i++){

   String nationalityNow = allNationalitiesOrdered[i];
   int index=0;
   int count=0;
   while(allNationalitiesList.indexOf(nationalityNow,index)>=0){
     count++;
     index=allNationalitiesList.indexOf(nationalityNow,index)+3; //search from after this occurance next time...
   }
   //println(count+" "+nationalityNow+" medals");

   for(int b=0; b<nationNumOfMedalsArray.length; b++){
     if(nationNumOfMedalsArray[b].indexOf(nationalityNow)<0){//if it doesnt find this country/medal in the array already continue...---------------------WORKS BUT ADDS FAR TOO MANY HERE!
       nationNumOfMedalsArray = append(nationNumOfMedalsArray, nationalityNow+" "+count);//adds nation + medalcount to a new array.
     }
   }
 }
  //println(nationNumOfMedalsArray);
//-----------------------------//-----------------------------//-----------------------------//-----------------------------//-----------------------------

  for(int i=0; i<allWonMedalsArray.length; i++){//goes through all medals won..
    if(allWonMedalsArray[i] == 'G'){//counts gold medals.
      goldMedalCounter = goldMedalCounter+1;
    }
    else if(allWonMedalsArray[i] == 'S'){//counts gold medals.
      silverMedalCounter = silverMedalCounter+1;
    }
    else if(allWonMedalsArray[i] == 'B'){//counts gold medals.
      bronzeMedalCounter = bronzeMedalCounter+1;
    }
  }

  //println(goldMedalCounter+" golds");
  //println(silverMedalCounter+" silvers");
  //println(bronzeMedalCounter+" bronzes");
  int[] medalTotalsArray = {
    goldMedalCounter, silverMedalCounter, bronzeMedalCounter  };
  float goldMedalsTotalMappedToCircle = map(goldMedalCounter, 0, arrayLength, 0, 360);
  float silverMedalsTotalMappedToCircle = map(silverMedalCounter, 0, arrayLength, 0, 360);
  float bronzeMedalsTotalMappedToCircle = map(bronzeMedalCounter, 0, arrayLength, 0, 360);
  ///println(goldMedalsTotalMappedToCircle+"goldMedalsTotalMappedToCircle");
  ///println(silverMedalsTotalMappedToCircle+"silverMedalsTotalMappedToCircle");
  ///println(bronzeMedalsTotalMappedToCircle+"bronzeMedalsTotalMappedToCircle");
  float[] medalTotalsMappedToCircleArray = {
    goldMedalsTotalMappedToCircle, silverMedalsTotalMappedToCircle, bronzeMedalsTotalMappedToCircle  };

  float goldMedalsAngle = goldMedalsTotalMappedToCircle/goldMedalCounter;
  float silverMedalsAngle = silverMedalsTotalMappedToCircle/silverMedalCounter;
  float bronzeMedalsAngle = bronzeMedalsTotalMappedToCircle/bronzeMedalCounter;

  for (int i = 0; i < medalTotalsMappedToCircleArray.length; i++){//draws 3 slices for medal colours.
    if(i == 0){//if its drawing the golds..
      fill(goldColour);
    }
    else if(i == 1){//if it's drawing silvers..
      fill(silverColour);
    }
    else if(i == 2){//if it's drawing bronzes..
      fill(bronzeColour);
    }
    arc(width/2, height/2, diameterOne, diameterOne, lastAng, lastAng+radians(medalTotalsMappedToCircleArray[i]));//draws an arc for g, s, & b.
    lastAng += radians(medalTotalsMappedToCircleArray[i]);//adds last angle on to make slices join properly.
    fill(255);
    ellipse(width/2, height/2, diameterOne*0.9, diameterOne*0.9);//clears the centre of the circle.
    textFont(bigFont);
    fill(0);
    textAlign(CENTER);
    text("Vancouver 2010", width/2, height/2);
    text("Medalists", width/2, (height/2)+bigFontSize);
    textFont(font);
    textAlign(LEFT);
  }

  int getMedalFromFinalArray;

  translate(width/2, height/2);//translates everything to centre.

  for(int i=0; i<fullDetailsArrayAlpha.length; i++){//loops through final collected array.
    // ---------------------
    getMedalFromFinalArray = fullDetailsArrayAlpha[i].indexOf(",G,");
    if(getMedalFromFinalArray>0){//if it finds a gold medal..
      goldCount = goldCount+1;
      int getCommaOneFromFinalArray = fullDetailsArrayAlpha[i].indexOf(",");//finds the first comma..
      String goldMedallist = fullDetailsArrayAlpha[i].substring(0, getCommaOneFromFinalArray);
      println(goldMedallist+" "+goldCount);
      fill(goldColour);
      pushMatrix();
      rotate(radians(((goldCount-1)*goldMedalsAngle)+degreesPerMedal));
      text(goldMedallist, diameterOne, 0);//lists names.

    int getCommaBeforeNationality = fullDetailsArrayAlpha[i].indexOf(",");
  int getCommaAfterNationality = fullDetailsArrayAlpha[i].indexOf(",", getCommaBeforeNationality+1);
  String nationality = fullDetailsArrayAlpha[i].substring(getCommaBeforeNationality+1, getCommaAfterNationality);//gets nationality.
  //println(nationality+" nationality");
  PImage flag = loadImage(nationality+".gif");
  println(flag.width+" "+flag.height);
  if(flag != null){
  image(flag, diameterOne/2, 0, 8, 5);
  }
      popMatrix();
    }
    //  ---------------------

    getMedalFromFinalArray = fullDetailsArrayAlpha[i].indexOf(",S,");
    if(getMedalFromFinalArray>0){//if it finds a silver medal..
      silverCount = silverCount+1;
      int getCommaOneFromFinalArray = fullDetailsArrayAlpha[i].indexOf(",");//finds the first comma..
      String silverMedallist = fullDetailsArrayAlpha[i].substring(0, getCommaOneFromFinalArray);
      println(silverMedallist+" "+silverCount);
      fill(silverColour);
      pushMatrix();
      rotate(radians(goldMedalsTotalMappedToCircle+(((silverCount-1)*silverMedalsAngle)+degreesPerMedal)));
      text(silverMedallist, diameterOne, 0);

  int getCommaBeforeNationality = fullDetailsArrayAlpha[i].indexOf(",");
  int getCommaAfterNationality = fullDetailsArrayAlpha[i].indexOf(",", getCommaBeforeNationality+1);
  String nationality = fullDetailsArrayAlpha[i].substring(getCommaBeforeNationality+1, getCommaAfterNationality);//gets nationality.
  //println(nationality+" nationality");
  PImage flag = loadImage(nationality+".gif");
  println(flag.width+" "+flag.height);
  if(flag != null){
  image(flag, diameterOne/2, 0, 8, 5);
  }
      popMatrix();
    }
    //  ---------------------

    getMedalFromFinalArray = fullDetailsArrayAlpha[i].indexOf(",B,");
    if(getMedalFromFinalArray>0){//if it finds a bronze medal..
      bronzeCount = bronzeCount+1;
      int getCommaOneFromFinalArray = fullDetailsArrayAlpha[i].indexOf(",");//finds the first comma..
      String bronzeMedallist = fullDetailsArrayAlpha[i].substring(0, getCommaOneFromFinalArray);
      println(bronzeMedallist+" "+bronzeCount);
      fill(bronzeColour);
      pushMatrix();
      rotate(radians(goldMedalsTotalMappedToCircle+silverMedalsTotalMappedToCircle+(((bronzeCount-1)*bronzeMedalsAngle)+degreesPerMedal)));
      text(bronzeMedallist, diameterOne, 0);

  int getCommaBeforeNationality = fullDetailsArrayAlpha[i].indexOf(",");
  int getCommaAfterNationality = fullDetailsArrayAlpha[i].indexOf(",", getCommaBeforeNationality+1);
  String nationality = fullDetailsArrayAlpha[i].substring(getCommaBeforeNationality+1, getCommaAfterNationality);//gets nationality.
  //println(nationality+" nationality");
  PImage flag = loadImage(nationality+".gif");
  println(flag.width+" "+flag.height);
  if(flag != null){
  image(flag, diameterOne/2, 0, 8, 5);
  }
      popMatrix();
    }

  }

  exit();
}//end of draw.

