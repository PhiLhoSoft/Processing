String textToDisplay =
"Basic examples introduce the primary elements of computer programming and the fundamental elements of drawing with Processing. If you are new to programming, these examples can be a part of the learning process, but they are not detailed or descriptive enough to be used alone. If you have prior experience, they will show you how to apply what you know to using Processing.\n" +
"Topic examples build on the basics; they demonstate code for animation, drawing, interaction, interface, motion, simulation, file i/o, cellular automata, fractals, and l-systems.\n" +
"3D examples show the basics of drawing in 3D. Processing has two 3D renderers that can draw 3D shapes on screen and control lighting and camera parameters. The P3D renderer is an optimized software renderer and the OPENGL renderer uses JOGL to access OpenGL accelerated graphics cards (this creates an enormous speed improvement on computers with supported graphics cards.)" +
"Libraries examples demonstrate how to use some of Processing's many libraries. The libraries enable Processing to capture and play video, import SVG files, export PDF files, communicate using the Internet and RS-232 protocols, create and play sound files, and more... ";

boolean bTestI18N = true;

// Testing internationalization
Locale esLocale = new Locale("es");

ResourceBundle res;
String bundleName = "Localization";
PFont fa;
int i18bPos = 500;
int menuPos = i18bPos + 50;
int infoPos = menuPos + 50;

void setup()
{
  size(500, 800);
  smooth();
  background(#AAFFEE);

  // Get the strings corresponding to YOUR locale
  GetStrings(Locale.getDefault());
  frameRate(1);

//  PFont f = loadFont("Silkscreen-8.vlw");
  fa = loadFont("Arial-Black-12.vlw");

  if (!bTestI18N)
  {
    // Display long text wrapped and centered on a given width
    textFont(fa);
    textAlign(CENTER);
    fill(#000055);
    text(textToDisplay, 10, 10, width - 10, height - 10);

    // Testing colorization of letters and "natural" spacing

    textAlign(LEFT);
//    textMode(MODEL);
    String msg = "Processing is awesome!";
    int ml = msg.length();
    PFont fi = loadFont("Impact-48.vlw");
    textFont(fi);
    char[] msgChars = new char[ml];
    msg.getChars(0, ml, msgChars, 0);
    float pos1 = 10, pos2 = 10;
    for (int i = 0; i < ml; i++)
    {
      char c = msgChars[i];
      fill(60, 90, map(i, 0, ml, 0, 255));
      text(c, 10 + 18 * i, 340);

      text(c, pos1, 380);
      pos1 += fi.width[c];

      text(c, pos2, 420);
      pos2 += textWidth(c);
      println(c + " " + textWidth(c) + " " + fi.width[c]);
    }
    noLoop();
  }
}

void draw()
{
  if (bTestI18N)
  {
    background(#CAFEBA);
  }
  textFont(fa, 24);
  fill(#5599AA);
  textAlign(LEFT);
  text(appName + " (" + appAuth + ")", 50, i18bPos);
  textFont(fa);
  text(slogan, 50, i18bPos + 20);

  fill(#557799);
  textAlign(CENTER);
  text(en, 100, menuPos);
  text(es, 200, menuPos);
  text(fr, 300, menuPos);

  fill(#335577);
  textAlign(LEFT);
  text(title + ": " + titleValue, 50, infoPos);
  text(artist + ": " + artistValue, 50, infoPos + 20);
  text(album + ": " + albumValue, 50, infoPos + 40);
  text(genre + ": " + genreValue, 50, infoPos + 60);
}

void mouseReleased()
{
  boolean bAlt = keyPressed && key == CODED && keyCode == CONTROL;
  if (mouseY > menuPos - 20 && mouseY < menuPos + 20)
  {
    if (mouseX > 60 && mouseX < 140)
    {
      if (bAlt)
      {
        GetStrings(Locale.US); // Locale("en", "US")
      }
      else
      {
        GetStrings(Locale.ENGLISH); // Locale("en")
      }
    }
    else if (mouseX > 160 && mouseX < 240)
    {
      GetStrings(esLocale);
    }
    else if (mouseX > 260 && mouseX < 340)
    {
      if (bAlt)
      {
        GetStrings(Locale.CANADA_FRENCH); // Locale("fr", "CA")
      }
      else
      {
        GetStrings(Locale.FRENCH); // Locale("fr")
      }
    }
    else
    {
      GetStrings(Locale.getDefault());
    }
  }
//  println(mouseX + " " + mouseY);
}

String appName, appAuth, slogan;
String title, artist, album, genre;
String en, es, fr;
String titleValue = "Hey Jude", artistValue = "The Beatles",
    albumValue = "Abbey Road", genreValue = "Pop";
void GetStrings(Locale locale)
{
  res = UTF8ResourceBundle.getBundle(bundleName, locale,
      new ProcessingClassLoader(this));

  appName = res.getString("APP_NAME");
  appAuth = res.getString("APP_AUTH");
  slogan = res.getString("slogan");
  title = res.getString("Title");
  artist = res.getString("Artist");
  album = res.getString("Album");
  genre = res.getString("Genre");
  en = res.getString("en");
  es = res.getString("es");
  fr = res.getString("fr");
}
