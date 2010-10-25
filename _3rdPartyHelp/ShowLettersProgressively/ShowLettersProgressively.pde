int TIMER = 500; // ms
 
PFont f;
String letters = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z Ä Ü Ö 1 2 3 4 5 6 7 8 9 0 + - / * ! ? =";
String[] words = split(letters, ' ');
 
int letterCount;
int wordCount;
int textLine;
int letter;
int xcoor;
int ycoor = 50;
 
final int NEXTSCREEN = 0;
final int NEXTWORD = 1;
final int NEXTLETTER = 2;
int state = NEXTSCREEN;
 
long lastTime;
 
void setup() {
 
  size(1000, 500);
  f = createFont("Andale Mono", 20);
  textFont(f, 20);
  lastTime = millis();
  fill(0);
}
 
void draw() {
 
  if (millis() - lastTime < TIMER) return; // Don't do anything before the delay
  lastTime = millis();
 
  if (state == NEXTSCREEN) {
    background(255);
    wordCount = (int) random(1, 10); // call basic var
    textLine = 0;
    ycoor = 40;
    state = NEXTWORD;
//    println("word " + wordCount);
  }
  if (state == NEXTWORD) {
    xcoor = 30;
    letterCount = (int) random(1, 7);
    letter = 0;
    state = NEXTLETTER;
//    println("letter " + letterCount);
  }
 
  int letterChooser = (int) random(1, words.length);
  text(words[letterChooser], xcoor, ycoor);
//  print(words[letterChooser]);
 
  if (state == NEXTLETTER) {
    xcoor += 30; // letter spacing
    letter++;
    if (letter == letterCount) {
      letter = 0;
      state = NEXTWORD;
//    println("");
//    println("word");
    }
  }
  if (state == NEXTWORD) {
    ycoor += 40; // line break
    textLine++;
    if (textLine == wordCount) {
      state = NEXTSCREEN;
//      println("sceen");
    }
  }
}

