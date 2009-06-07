// http://processing.org/discourse/yabb2/YaBB.pl?num=1244326390
PFont font;
int maxim;
String[] textArray;
boolean locked;
float pos, sPos, y;
int SCROLLBAR_HEIGHT = 50;
int SCROLLBAR_WIDTH = 6;
int LINE_HEIGHT = 14;
int MARGIN = 5;

void setup() {
  size(300, 400);
  background(0);
  font = createFont("Arial", 11);
  textFont(font);
  y = 1;
  sPos = SCROLLBAR_WIDTH/2;
  textArray = new String[]  {
    "00 Eyelash extensions are an entirely new method of",
    "enhancing the length and thickness of eyelashes.",
    "Extensions are applied on a lash-by-lash basis for",
    "a totally natural look. When properly applied,",
    "Lashes Couture® eyelash extensions can last from up" ,
    "to six to eight weeks. Lashextensions.ie® attracts",
    "everyone in Ireland who is looking for eyelash",
    "extensions. 00",
    "",
    "Lashes Couture® is one of the highest ranked eyelash",
    "extension systems in the world! A significant portion",
    "of this traffic is from potential clients seeking a",
    "professional, in their area, who can apply extensions",
    "to them. When your name is listed, you will understand", 
    "the value of an exceptional referral program. If you",
    "are a Lashes Couture Professional and want to attract",
    "new and potential clients in your area please contact",
    "us and we will be happy to list you on the first",
    "website in ireland dedicated to Lashes Couture Eyelash",
    "Extensions.",
    "",
    "We recieve hundreds of calls every month from people",
    "looking for the nearest Lashes Couture Professional",
    "in there area. Premium quality speaks for itself!",
    "When you carry the highest quality products, when you",
    "have received exceptional hands-on eyelash extension",
    "training and certification options from Lashes Couture®,",
    "your clients will be thrilled and grateful.",
    "", 
    "You owe it to yourself and to your clients to align",
    "yourself with the only company that is committed to",
    "upholding critical standards, committed to continual",
    "improvement and committed to the long term success of",
    "the eyelash extension industry. We welcome you as a",
    "member of our dedicated team of professionals.",
    "Lashes Couture® wants to be an integral part of your",
    "success in this revolutionary new and exciting industry."  ,
    "",
    "11 Lashes Couture® is one of the highest ranked eyelash",
    "extension systems in the world! A significant portion",
    "of this traffic is from potential clients seeking a",
    "professional, in their area, who can apply extensions",
    "to them. When your name is listed, you will understand", 
    "the value of an exceptional referral program. If you",
    "are a Lashes Couture Professional and want to attract",
    "new and potential clients in your area please contact",
    "us and we will be happy to list you on the first",
    "website in ireland dedicated to Lashes Couture Eyelash",
    "Extensions. 11",
    "",
    "22 Lashes Couture® is one of the highest ranked eyelash",
    "extension systems in the world! A significant portion",
    "of this traffic is from potential clients seeking a",
    "professional, in their area, who can apply extensions",
    "to them. When your name is listed, you will understand", 
    "the value of an exceptional referral program. If you",
    "are a Lashes Couture Professional and want to attract",
    "new and potential clients in your area please contact",
    "us and we will be happy to list you on the first",
    "website in ireland dedicated to Lashes Couture Eyelash",
    "Extensions. 22"
  };
  //doesnt work after 80 lines
  noStroke();
  smooth();
}

void draw() {
  background(0);
  fill(200);
  for (int i = 0; i < textArray.length; i++){
    text(textArray[i], MARGIN, (i + 1) * LINE_HEIGHT + y);
  }
  maxim = textArray.length*LINE_HEIGHT - height + SCROLLBAR_HEIGHT;
  pos = sPos/(height - SCROLLBAR_HEIGHT/2 - 2);
  y = MARGIN - pos*maxim;
  if (mousePressed && over() || locked) {
    locked = true;
    if (mouseY - SCROLLBAR_HEIGHT/2 <= 2) {
      sPos = SCROLLBAR_WIDTH/2;
    } 
    else if (mouseY + SCROLLBAR_HEIGHT/2 >= height - 2) {
      sPos = height - SCROLLBAR_HEIGHT - SCROLLBAR_WIDTH/2;
    } 
    else {
      sPos = mouseY - SCROLLBAR_HEIGHT/2;
    }
  }
  if (!mousePressed) {
    locked = false;
  }
  fill(250);
  rect(width - SCROLLBAR_WIDTH/2 - MARGIN, sPos, SCROLLBAR_WIDTH, SCROLLBAR_HEIGHT);
  ellipse(width - MARGIN, sPos, SCROLLBAR_WIDTH, SCROLLBAR_WIDTH);
  ellipse(width - MARGIN, sPos + SCROLLBAR_HEIGHT, SCROLLBAR_WIDTH, SCROLLBAR_WIDTH);

}
boolean over(){
  return mouseX > width - SCROLLBAR_WIDTH/2 - MARGIN && mouseX < width - 2 && 
      mouseY > sPos && mouseY < sPos + SCROLLBAR_HEIGHT;
}
