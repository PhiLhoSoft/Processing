// [url=http://processing.org/discourse/yabb2/YaBB.pl?num=1272168116/0#4]String array - design question[/url]

PFont font;
int displayedWords = 32;
int nextWord = displayedWords + 1;

int lineHeight = 30;
int space = 10;
int margin = space * 4;

String s = "You've asked me what the lobster is weaving there with his golden feet? I reply, the ocean knows this. You say, what is the ascidia waiting for in its transparent bell? What is it waiting for?";

String[] vernacular = split(s, ' ');

Word[] words = new Word[displayedWords];

void setup(){
  size(600,400);
  frameRate(1);
  font = createFont("Times New Roman", 24);
  textFont(font);

  float xPos = margin;
  int row = 1;

  for(int i=0;i<words.length;i++){
    float wide = textWidth(vernacular[i]);
    words[i] = new Word(vernacular[i], xPos, row, wide);
    xPos = words[i].end;
  } 
  noLoop();
}

void draw(){
  background(0);
  int row = 0;
  for (int i = 0; i < words.length; i++) {
      if (words[i].end > width-margin) {
        // Beyond right margin, must wrap
        if (words[i-1].row == words[i].row)
        {
          // Previous word on same row, just wrap
          words[i].goNextRow();
        }
        else // Already wrapped on previous word
        {
          // Follows it
          words[i].row = words[i-1].row;
          if (words[i - 1].end + words[i].wide > width - margin)
          {
            // New pos beyond margin, wrap
            words[i].goNextRow();
          }
          else
          {
            // Really follow it
            words[i].xPos = words[i - 1].end;
          }
        }
        words[i].update();
      }
      words[i].display();
  }
}

class Word{
  String word;
  float xPos;
  float yPos;
  float wide;
  float end;
  float top;
  int row;

  //Constructor
  Word(String word, float xPos, int row, float wide){

    this.word = word;
    this.xPos = xPos;
    this.row = row;
    this.wide = wide;
    this.top = yPos - lineHeight;
    update();
  }

  void display(){   
    text(word, xPos, yPos);
    println(word + " " + xPos + " " + yPos);
  }

  void update(){
    end = xPos + wide + space;
    yPos = row * lineHeight;
  }
  
  void goNextRow() {
    row++;
    xPos = margin;
  }
}
