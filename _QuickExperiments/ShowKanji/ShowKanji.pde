PFont fa, fg, fm;
char character;

void setup()
{
  size(200, 200);
  frameRate(1); // 1 frame per second... OK for a slideshow!
  
  // Define a dummy charset (1 char to use less memory)
  // because Processing really creates the bitmap font
  // even if it won't use it in this mode...
  // So if we don't do that, we will get an out of memory error!
  char[] dummy = new char[1]; dummy[0] = ' ';
  // Create fonts having Japanese chars
  fa = createFont("Arial Unicode MS", 128, true, dummy);
  fg = createFont("MS Gothic", 128, true, dummy);
  fm = createFont("MS Mincho", 128, true, dummy);
  // Also Batang, Datum, Gulim, Gungsuh,  MingLiU, SimHei, SimSun
  // support CJK (come with WinXP)
}

void draw()
{
  background(#F0FAFC);
  if (frameCount % 20 < 5)
  {
    character = 0x98DF; // or just '\u98DF'
    
    fill(#FFAA00);
    textFont(fa);
    text(character, 5, 120);
  }
  else if (frameCount % 20 < 10)
  {
    character = '\u9763';

    fill(#00AAFF);
    textFont(fg);
    text(character, 65, 185);
  }
  else if (frameCount % 20 < 15)
  {
    character = 0x96FB;

    fill(#88AA55);
    textFont(fm);
    text(character, 5, 185);
  }
  else if (frameCount % 20 < 20)
  {
    character = 0x96BC;

    fill(#55AA88);
    textFont(fa);
    text(character, 65, 120);
  }
}

