/**
Search words in a series of sentences (using a given matcher for each case) and
display the sentence using a class corresponding to the matcher.
http://processing.org/

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2009/04/23 (PL) -- Creation, based on SearchWordsColor and DrawingInSequence.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2009 Philippe Lhoste / PhiLhoSoft
*/

int DISPLAY_FONT_SIZE = 50;
int DISPLAY_TIME = 120; // 2 seconds at 60 FPS
color BACK_COLOR = color(200);

int currentSentenceIdx;
int startFrameCount;
int currentFrameCount;
String currentSentence;
Drawer currentDrawer;

/**
 * Associates a matcher (finding a word or some complex combination)
 * and a drawer (displaying a message in a more or less complex way).
 */
class MatcherAndDrawer
{
  Matcher matcher;
  Drawer drawer;

  MatcherAndDrawer(Matcher m, Drawer d)
  {
    matcher = m;
    drawer = d;
  }
}

/**
 * The demonstration matchers and drawers.
 */
MatcherAndDrawer[] triggers =
{
  new MatcherAndDrawer(new WordInside("grow"), new Growing()),
  new MatcherAndDrawer(new RegExMatcher("(tiny|small|little)", true), new Shrinking()),
  new MatcherAndDrawer(new RegExMatcher("fade.*black"), new Fade(BACK_COLOR, #000000)),
  new MatcherAndDrawer(new RegExMatcher("fade.*gr[ea]y"), new Fade(BACK_COLOR, #7F7F7F)),
  // Only if at start of sentence!
  new MatcherAndDrawer(new RegExMatcher("black.*"), new PlainColor(#000000)),
  new MatcherAndDrawer(new WordInside("white"), new PlainColor(#FFFFFF)),
  new MatcherAndDrawer(new WordInside("blue"), new PlainColor(#0000FF)),
  new MatcherAndDrawer(new WordInside("green"), new PlainColor(#00FF00)),
  new MatcherAndDrawer(new WordInside("red"), new PlainColor(#FF0000)),
  // Only as a separate word, but anywhere in the sentence
  new MatcherAndDrawer(new RegExMatcher("\\bcyan\\b", true), new PlainColor(#00FFFF)),
  new MatcherAndDrawer(new WordInside("magenta"), new PlainColor(#FF00FF)),
  new MatcherAndDrawer(new WordInside("yellow"), new PlainColor(#FFFF00))
};

/**
 * The demonstration sentences to display.
 */
String[] sentences =
{
  "Black Magic Woman",
  "Blue Velvet",
  "Fade to black",
  "Yellow Submarine",
  "Growing and Multiplying",
  "Cyanide and Hapiness",
  "White Christmas",
  "Brown Sugar", // Voluntarily not matching
  "Little House on the pairie",
  "My Baby (Cyan Sleep)",
  "The Black Belt Ninja", // Voluntarily doesn't match "black" matcher
  "The Yellow Brick Road",
  "The Blues Brothers",
  "Steven Spielberg Presents... Tiny Toon Adventures",
  "Greensleeves",
  "Fade to gray",
  "The Red Line",
  "Magenta is rare in song and film names..."
};

void setup()
{
  size(1000, 100);
  background(200);
  PFont f = createFont("Arial Bold", DISPLAY_FONT_SIZE);
  textFont(f);
  // Check drawer for first sentence
  UpdateData();
}

void draw()
{
  background(BACK_COLOR);
  currentDrawer.Draw(currentSentence, 10, height - 10, currentFrameCount);
  currentFrameCount++;
  if (frameCount - startFrameCount > DISPLAY_TIME) // Display  a message for a given duration
  {
    // Next sentence
    currentSentenceIdx++;
    if (currentSentenceIdx == sentences.length)
    {
      // We exhausted the sentences to display
      background(BACK_COLOR);
      // Just stop (can do exit() too)
      noLoop();
      return;
    }
    // Check which drawer to use
    UpdateData();
  }
}

void UpdateData()
{
  // Sentence to display
  currentSentence = sentences[currentSentenceIdx];
  println(currentSentence);
  // If we don't find a drawer, use this one
  currentDrawer = defaultDrawer;
  for (int t = 0; t < triggers.length; t++)
  {
    // Check if matching
    if (triggers[t].matcher.IsMatching(currentSentence))
    {
      // Yeah, we will draw with this one!
      currentDrawer = triggers[t].drawer;
      // And search no other (several matchers could match...)
      break;
    }
  }
  // Reset for this matcher
  currentFrameCount = 0;
  // And start counting time
  startFrameCount = frameCount;
}
