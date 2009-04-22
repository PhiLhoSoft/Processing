class ColorNameAndValue
{
  String name;
  color value;

  ColorNameAndValue(String n, color c)
  {
    name = n;
    value = c;
  }
}

ColorNameAndValue[] triggers =
{
  new ColorNameAndValue("blue", #0000FF),
  new ColorNameAndValue("green", #00FF00),
  new ColorNameAndValue("red", #FF0000),
  new ColorNameAndValue("cyan", #00FFFF),
  new ColorNameAndValue("magenta", #FF00FF),
  new ColorNameAndValue("yellow", #FFFF00),
  new ColorNameAndValue("black", #000000),
  new ColorNameAndValue("white", #FFFFFF)
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
  background(200);
  PFont f = createFont("Arial Bold", 15);
  textFont(f);
  for (int s = 0; s < sentences.length; s++)
  {
    String sentence = sentences[s];
    color col = #7F7F7F;
    for (int c = 0; c < triggers.length; c++)
    {
      if (sentence.toLowerCase().contains(triggers[c].name))
      {
        col = triggers[c].value;
        break;
      }
    }
    fill(col);
    text(sentence, 10, 20 * (s + 1));
  }
}
