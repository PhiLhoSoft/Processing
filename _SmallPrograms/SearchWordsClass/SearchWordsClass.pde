int DISPLAY_TIME = 60;
color BACK_COLOR = color(200);

int currentSentenceIdx;
int startFrameCount;
int currentFrameCount;

class WordAndDrawer
{
  String word;
  Drawer drawer;

  WordAndDrawer(String w, Drawer a)
  {
    word = w;
    drawer = a;
  }
}

WordAndDrawer[] triggers =
{
  new WordAndDrawer("fade.*black", new Fade(BACK_COLOR, #000000)),
  new WordAndDrawer("fade.*gr[ea]y", new Fade(BACK_COLOR, #7F7F7F)),
  new WordAndDrawer(".*blue.*", new PlainColor(#0000FF)),
  new WordAndDrawer(".*green.*", new PlainColor(#00FF00)),
  new WordAndDrawer(".*red.*", new PlainColor(#FF0000)),
  new WordAndDrawer(".*cyan.*", new PlainColor(#00FFFF)),
  new WordAndDrawer(".*magenta.*", new PlainColor(#FF00FF)),
  new WordAndDrawer(".*yellow.*", new PlainColor(#FFFF00)),
  new WordAndDrawer("black.*", new PlainColor(#000000)), // Only if at start of sentence!
  new WordAndDrawer(".*white.*", new PlainColor(#FFFFFF))
};

String[] sentences =
{
  "Black Magic Woman",
  "Blue Velvet",
  "Fade to black",
  "Yellow Submarine",
  "White Christmas",
  "Cyanide and Hapiness",
  "Brown Sugar", // Voluntarily not matching
  "The Black Belt Ninja", // Voluntarily doesn't match
  "The Yellow Brick Road",
  "The Blues Brothers",
  "Greensleeves",
  "Fade to gray",
  "The Red Line",
  "Magenta is rare in song and film names..."
};

void setup()
{
  size(1000, 100);
  background(200);
  PFont f = createFont("Arial Bold", 50);
  textFont(f);
}

void draw()
{
  background(BACK_COLOR);
  String sentence = sentences[currentSentenceIdx];
  Drawer currentDrawer = defaultDrawer;
  for (int t = 0; t < triggers.length; t++)
  {
    if (sentence.toLowerCase().matches(triggers[t].word))
    {
      currentDrawer = triggers[t].drawer;
      break;
    }
  }
  currentDrawer.Draw(sentence, 10, height - 10, currentFrameCount);
  if (frameCount - startFrameCount > DISPLAY_TIME) // Display  a message for a given duration
  {
    currentSentenceIdx++;
    currentFrameCount = 0;
    startFrameCount = frameCount;
    if (currentSentenceIdx == sentences.length)
    {
      background(BACK_COLOR);
      noLoop();
    }
  }
  currentFrameCount++;
}

