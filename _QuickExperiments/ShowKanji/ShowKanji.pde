PFont[] jFonts = new PFont[3];
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
  jFonts[0] = createFont("Arial Unicode MS", 128, true, dummy);
  jFonts[1] = createFont("MS Gothic", 128, true, dummy);
  jFonts[2] = createFont("MS Mincho", 128, true, dummy);
  // Also Batang, Datum, Gulim, Gungsuh,  MingLiU, SimHei, SimSun
  // support CJK (come with WinXP)
}

char[] demoChars = { 0x98DF, '\u9762', 0x96FB, 38588 };

void draw()
{
  background(#556677);

  if (frameCount % 6 == 1)
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
      character = demoChars[int(random(4))];
    }
    println(hex(character));
    posX = int(5 + random(width - 140));
    posY = int(140 + random(height - 140));
  }

  fill(128 + int(random(128)), 128 + int(random(128)), 128 + int(random(128)));
  textFont(jFonts[int(random(3))]);
  text(character, posX, posY);
}

