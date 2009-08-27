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
PFont fDisplay, fTitle;
int i18bPos = 500;
int menuPos = i18bPos + 50;
int infoPos = menuPos + 50;

void setup()
{
  size(600, 800);
  smooth();
  background(#AAFFEE);

  // Get the strings corresponding to YOUR locale
  GetStrings(Locale.getDefault());
  frameRate(5);

//  fDisplay = loadFont("Silkscreen-8.vlw");
  fDisplay = loadFont("Arial-Black-12.vlw");
  fTitle = loadFont("Impact-48.vlw");

  if (!bTestI18N)
  {
    // Display long text wrapped and centered on a given width
    textFont(fDisplay);
    textAlign(CENTER);
    fill(#000055);
    text(textToDisplay, 10, 10, width - 10, height - 10);

    // Testing colorization of letters and "natural" spacing
    textAlign(LEFT);
//    textMode(MODEL);
    String msg = "Processing is awesome!";
    int ml = msg.length();
    textFont(fTitle);
    char[] msgChars = new char[ml];
    msg.getChars(0, ml, msgChars, 0);
    float pos1 = 10, pos2 = 10;
    for (int i = 0; i < ml; i++)
    {
      char c = msgChars[i];
      fill(60, 90, map(i, 0, ml, 0, 255));
      text(c, 10 + 18 * i, 340);

      text(c, pos1, 380);
      pos1 += fTitle.width[c];

      text(c, pos2, 420);
      pos2 += textWidth(c);
      println(c + " " + textWidth(c) + " " + fTitle.width[c]);
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
  textFont(fTitle);
  fill(#5599AA);
  textAlign(LEFT);
  text(appName + " (" + appAuth + ")", 5, i18bPos);
  textFont(fDisplay, 24);
  text(slogan, 50, i18bPos + 24);

  textFont(fDisplay);
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

  fill(#337755);
  text(releaseInfo, 50, infoPos + 80, width - 100, 50);
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
String en, es, fr, enC, esC, frC;
String titleValue = "Here Comes the Sun", artistValue = "The Beatles",
    albumValue = "Abbey Road", genreValue = "Pop";
String releaseInfo;
void GetStrings(Locale locale)
{
  res = UTF8ResourceBundle.getBundle(bundleName, locale,
      new ProcessingClassLoader(this));
  double[] pluralLimits = { 0, 1, 2 };

  appName = GetString("APP_NAME");
  appAuth = GetString("APP_AUTH");
  slogan = GetString("slogan");
  title = GetString("Title");
  artist = GetString("Artist");
  album = GetString("Album");
  genre = GetString("Genre");
  en = GetString("en");
  es = GetString("es");
  fr = GetString("fr");

  enC = GetString("EN");
  esC = GetString("ES");
  frC = GetString("FR");
  String country = { enC, esC, frC }[(int) random(0, 4)];
  String releaseInfoPat = GetString("release");
  String diskNbMsgPat = GetString("disk number");
  String [] diskNbPats =
  {
    GetString("DN.zero"),
    GetString("DN.one"),
    GetString("DN.more")
  };
  ChoiceFormat choice = new ChoiceFormat(pluralLimits, diskNbPats);

  int diskNb = (int) random(0, 4);
  int diskNbMore = (int) (diskNb * 1E6 + random(1000, 1E6));

  MessageFormat formatter = new MessageFormat("");
  formatter.setLocale(locale);

  formatter.applyPattern(diskNbMsgPat);
  Object[] diskStats =
  {
    diskNb, diskNbMore
  };
  String diskNbMsg = formatter.format(diskStats);

  formatter.applyPattern(releaseInfoPat);
  Object[] information =
  {
    country,
    new Date((long) random(1E8, 1E9)),
    diskNbMsg,
    diskNbMore / 1.42E5,
  };
  releaseInfo = formatter.format(information);
}

String GetString(String key)
{
  String value = null;
  try
  {
    value = res.getString(key);
  }
  catch (MissingResourceException e)
  {
    println("Key " + key + " not found");
    value = key; // Poor substitute, but hey, might give an information anyway
  }
  return value;
}

/*
Good question! Since lot of Processing code is purely graphical, I suppose not many people tried to make translatable sketches.
I just tried... and found out it was surprisingly hard! :-)
I love this kind of question because when trying to solve it, I have to do quite some researches, experiment with new code, and learn a lot in the process!

To summarize: i18n (internationalization) in Java is usually done by using ResourceBundle class.
This class basically just loads a property file (whole lines are made only of key = value pairs) chosen according to a locale, and provides a translation string corresponding to a key (ID of string to translate).
Somehow, we can do that manually with a simple loadString()...
But ResourceBundle is smarter than that: it can load a default file providing the untranslated, base strings (usually in English...), and override these strings with those defined in a file for a given language (say fr) and even override those with the ones defined in a country dialect (fr_FR, fr_CA, etc.).
This hierarchical loading is powerful, providing fallback strings for untranslated terms, and allowing to take in account dialects that usually change only a few strings.

The main problem in Processing that you probably encountered, is that ResourceBundle always get its resources from the classpath, ie. Processing libs and where the class files are, typically in a randomly named build folder in system's temp dir.
Fortunately, we can specify a specific class loader, which will look inside the data folder of the sketch instead.
Why there? Because files in this folder will be included when exporting the application. I haven't tried that, yet...

Another problem, generic to Java, is that property files must use the ISO-8859-1 encoding, which is quite an annoying limitation.
If you want to translate in Greek, Turkish, Russian, Arabic, Hebrew, or most Asian languages, to name but a few, you have to put Unicode escapes in these files (like \u2202 or similar!).
Java 1.6 allows a mechanism to load UTF-8 resource bundles, but I avoided using it because 32bit Mac users doesn't have it (at this time, it is coming with new version of MacOS X).
Fortunately, I found a hack allowing to load and convert UTF-8 properties.

These two tricks combined allow to use i18n in Processing. How cool is that? :-)

I made a demo sketch (reusing some other unrelated sketch), trying to highlight the hierarchical loading of resources.

*/
