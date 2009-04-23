int DISPLAY_TIME = 120;
color BACK_COLOR = color(200);

Drawer defaultDrawer = new PlainColor(#7F7F7F);

interface Drawer
{
  void Draw(String message, int x, int y);
}

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

class PlainColor implements Drawer
{
  color col;

  PlainColor(color c)
  {
    col = c;
  }
  void Draw(String message, int x, int y)
  {
    fill(col);
    text(message, x, y);
  }
}

WordAndDrawer[] triggers =
{
  new WordAndDrawer("blue", new PlainColor(#0000FF)),
  new WordAndDrawer("green", new PlainColor(#00FF00)),
  new WordAndDrawer("red", new PlainColor(#FF0000)),
  new WordAndDrawer("cyan", new PlainColor(#00FFFF)),
  new WordAndDrawer("magenta", new PlainColor(#FF00FF)),
  new WordAndDrawer("yellow", new PlainColor(#FFFF00)),
  new WordAndDrawer("black", new PlainColor(#000000)),
  new WordAndDrawer("white", new PlainColor(#FFFFFF))
};

String[] sentences =
{
  "Black Magic Woman",
  "Blue Velvet",
  "Yellow Submarine",
  "White Christmas",
  "Cyanide and Hapiness",
  "Brown Sugar",
  "Black Belt Ninja",
  "The Yellow Brick Road",
  "The Blues Brothers",
  "Greensleeves",
  "The Red Line",
  "Magenta is rare in song and film names..."
};

void setup()
{
  size(300, 500);
  PFont f = createFont("Arial Bold", 15);
  textFont(f);
}

void draw()
{
  background(BACK_COLOR);
  for (int s = 0; s < sentences.length; s++)
  {
    String sentence = sentences[s];
    Drawer drawer = defaultDrawer;
    for (int t = 0; t < triggers.length; t++)
    {
      if (sentence.toLowerCase().contains(triggers[t].word))
      {
        drawer = triggers[t].drawer;
        break;
      }
    }
    drawer.Draw(sentence, 10, 20 * (s + 1));
  }
}

