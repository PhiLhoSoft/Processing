// Random kanji generator - http://processing.org/discourse/yabb2/YaBB.pl?num=1267157349/1

boolean bDebug = false;
String[] fonts =
{
  "Arial Unicode MS", "MS Gothic", "MS Mincho",
  "Batang", "Datum", "Gulim",
  "MingLiU", "SimHei", "SimSun"
};
PFont[] jFonts = new PFont[fonts.length];
char character;
int posX, posY;

void setup()
{
  size(700, 700);
  frameRate(1); // 1 frame per second... OK for a slideshow!

  // Define a dummy charset (1 char to use less memory)
  // because Processing really creates the bitmap font
  // even if it won't use it in this mode...
  // So if we don't do that, we will get an out of memory error!
  char[] dummy = new char[1]; dummy[0] = ' ';
  // Create fonts having Japanese chars
  int count = 0;
  for (int i = 0; i < fonts.length; i++)
  {
    jFonts[count] = createFont(fonts[i], 128, true, dummy);
    if (jFonts[count].getFont().canDisplay(demoChars[0]))
    {
      // This font is on the system and supports CJK
      count++;
      println("Using " + fonts[i]);
    }
    else
    {
      println(fonts[i] + " not found.");
    }
  }
  // Discard unsupported fonts
  jFonts = (PFont[]) subset(jFonts, 0, count);
  println(count + " fonts with CJK support found on this system.");
}

char[] demoChars =
{
  // The 10 most frequently used kanji (according to kanjidic)
  0x65E5, 0x4E00, 0x4EBA, 0x56FD, 0x4F1A, 0x5E74, 0x5927, 0x5341, 0x4E8C, 0x672C,
  // Semi-randomly chosen chars
  0x98DF, 0x96FB, 38588, 0x9762 // Was '\u9762' but Processing 1.5.1 doesn't recognize this anymore
};

void draw()
{
  background(#556677);

  if (frameCount % 2 == 1)
  {
    float r = random(3);
    if (r < 1)
    {
      // Hiragana
      character = (char) (0x3041 + random(0x54));
    }
    else if (r < 2)
    {
      // Katakana
      character = (char) (0x30A1 + random(0x57));
    }
    else
    {
      character = demoChars[int(random(demoChars.length))];
    }
    println(hex(character));
    posX = int(5 + random(width - 140));
    posY = int(130 + random(height - 150));
  }

  fill(128 + int(random(128)), 128 + int(random(128)), 128 + int(random(128)));
  textFont(jFonts[int(random(jFonts.length))]);
  text(character, posX, posY);

  if (bDebug)
  {
    // Testing limits
    fill(#FF0000);
    text(character, 5, 130);
    text(character, 5, 680);
    text(character, 565, 130);
    text(character, 565, 680);
  }
}

