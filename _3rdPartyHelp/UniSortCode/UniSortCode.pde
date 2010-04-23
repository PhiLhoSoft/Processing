//SOURCE: http://www.hefce.ac.uk/finance/recurrent/2010/?o=2.
import processing.pdf.*;
import de.bezier.data.*;
XlsReader reader;
PFont font;

ArrayList uniArrayList;

float spacePerUni;


class CompareNames implements Comparator
{
  public int compare(Object o1, Object o2)
  {
    return ((UniversityObject) o1).uniName.compareTo(((UniversityObject) o2).uniName);
  }
}


class CompareFloats implements Comparator
{
  public int compare(Object o1, Object o2)
  {
    return int(1000.0*(((UniversityObject) o1).perChangeFloat - ((UniversityObject) o2).perChangeFloat));
  }
}


void setup(){
  size(400, 700, PDF, "file.pdf");
  background(255);
  font = createFont("Arial", 4);
  textFont(font);
  uniArrayList = new ArrayList();//create an empty list.
  reader = new XlsReader( this, "UniversityFunding10.xls" );
  int numCounter = reader.getFirstRowNum() + 1;//finds first cell with content. Skip title
  int lastCell = reader.getLastRowNum();
  boolean bReadNext = true;
  while (numCounter <= lastCell) // Never reach it if we have the "Total" cell.
  {
    String university = reader.getString(numCounter, 0);
    if (university.equals("Total"))
    {
      break;
    }
    int totalFunding = reader.getInt(numCounter, 1);
    int wideningParticipation = reader.getInt(numCounter, 2);
    int totalResearch = reader.getInt(numCounter, 3);
    int recurrentGrant = reader.getInt(numCounter, 6);
    float percentageChange = reader.getFloat(numCounter, 7);

    uniArrayList.add(new UniversityObject(numCounter, university, totalFunding,
        wideningParticipation, totalResearch, recurrentGrant, percentageChange, 0));
    numCounter++;
  }
  spacePerUni = (height-200)/uniArrayList.size();//finds how much vertical space for each uni.

  println(uniArrayList.size()+" arraylist '10 size");
}//end of setup.


void draw(){
  noLoop();

Collections.sort(uniArrayList, new CompareFloats());

for(int i=0; i<uniArrayList.size(); i++){
  UniversityObject uo = (UniversityObject) uniArrayList.get(i);
  uo.display(i);
}

  println("Done");
 exit();
}//end of draw.


class UniversityObject {//define my class.

    int num;//no. of uni in list..
    String uniName;//class variables.
    int totalFundingInt;
    int wideningParInt;
    int totalResearchInt;
    int recGrantInt;
    float perChangeFloat;
    color c;
    int yearsBack;

    UniversityObject(int tempNum, String tempUniName, int tempTotalFundingInt, int tempWideningParInt, int tempTotalResearchInt, int tempRecGrantInt, Float tempPerChangeFloat, int tempYearsBack) {// constructor.
    num = tempNum;
    uniName = tempUniName;
    totalFundingInt = tempTotalFundingInt;
    wideningParInt = tempWideningParInt;
    totalResearchInt = tempTotalResearchInt;
    recGrantInt = tempRecGrantInt;
    perChangeFloat = tempPerChangeFloat;
    if (perChangeFloat > 0)
    {
      c = color(0, 0, 255);
    }
    else
    {
      c = color(255, 0, 0, 100);
    }
    yearsBack = tempYearsBack;
  }

  void display(int i) {//function of the ojects created by the class.
    num = i;
    fill(c);
    noStroke();
    rect(width/2, 21 + num*5 - spacePerUni/2, perChangeFloat*10, spacePerUni);
    textAlign(LEFT);
    textSize(4);
    if(perChangeFloat>0){
      text(uniName + " " + perChangeFloat +"%", (width/2)+(perChangeFloat*10)+5, 22+(num*5));
    }else{
      fill(255, 0, 0);
      text(uniName + " " + perChangeFloat +"%", (width/2)+5, 22+(num*5));
    }
  }
}
