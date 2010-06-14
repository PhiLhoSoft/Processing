/**
Get color names from the XKCD SQLite database and display them progressively.
http://blog.xkcd.com/2010/05/03/color-survey-results/
[url=http://processing.org/discourse/yabb2/YaBB.pl?num=1276447735]SQLite with big database[/url]

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2010/06/14 (PL) -- First version.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2010 Philippe Lhoste / PhiLhoSoft
*/

import de.bezier.data.sql.*;
import java.sql.Timestamp;

static final String USERS_TABLE_NAME = "users";
static final String ANSWERS_TABLE_NAME = "answers";
static final int CHECK_INTERVAL = 100; // milliseconds
static final int MESSAGE_DISPLAY_NB = 35;
int lastCheck = - CHECK_INTERVAL - 1;
boolean bStop;

SQLite sqlite;
PFont fontHeader;
PFont fontMessage;

int userNb;
int answerNb;
ArrayList colorNames_red;
ArrayList colorNames_green;
ArrayList colorNames_blue;
int lastMessageDisplayedIndex;
int totalMessageNb;

void setup()
{
  size(800, 700);
  smooth();
  fontHeader = createFont("Arial", 30);
  fontMessage = createFont("Verdana", 16);

  Connect();
  GetPureColors();
}

void stop()
{
  println("Stopping connection");
  sqlite.close();
}

void draw()
{
  int time = millis();
  if (!bStop && time - lastCheck > CHECK_INTERVAL)
  {
    lastCheck = time;

    background(128);
    textFont(fontHeader, 36);
    fill(#FFCC88);
    text("XKCD Colors", 10, 36);
//    ShowCount(); // Slow!

    if (lastMessageDisplayedIndex < totalMessageNb - 1)
    {
      lastMessageDisplayedIndex++;
    }
    else
    {
      lastMessageDisplayedIndex = 0;
    }

    ShowIndex(lastMessageDisplayedIndex);
    for (int i = 0; i < MESSAGE_DISPLAY_NB; i++)
    {
      int idx = 1 + lastMessageDisplayedIndex - MESSAGE_DISPLAY_NB + i;
      if (idx < 0)
        continue;
      ColorName cn = (ColorName) colorNames_red.get(idx);
      ShowColorName(cn, 0, i);
      cn = (ColorName) colorNames_green.get(idx);
      ShowColorName(cn, 1, i);
      cn = (ColorName) colorNames_blue.get(idx);
      ShowColorName(cn, 2, i);
    }
  }
}

void mousePressed()
{
  bStop = true;
}

void mouseReleased()
{
  bStop = false;
}

void keyPressed()
{
  if (key == 'p' || key == 'P')
  {
    GetPureColors();
  }
  else if (key == 'l' || key == 'L')
  {
    GetLightColors();
  }
  else if (key == 'o' || key == 'O')
  {
    GetOtherColors();
  }
  else if (key == 'd' || key == 'D')
  {
    GetDifferentColors();
  }
}

void DoStats()
{
  totalMessageNb = min(
      colorNames_red.size(),
      colorNames_green.size(),
      colorNames_blue.size()
  );
  if (totalMessageNb == 0)
  {
    println("Not much to show!");
    exit();
  }
  lastMessageDisplayedIndex = 0;
}

void GetPureColors()
{
  colorNames_red = GetColorNames(255, 0, 0, -20, 0, -20);
  colorNames_green = GetColorNames(0, -20, 255, 0, 0, -20);
  colorNames_blue = GetColorNames(0, -20, 0, -20, 255, 0);
  DoStats();
}

void GetLightColors()
{
  colorNames_red = GetColorNames(255, 0, 255, 20, 255, 20);
  colorNames_green = GetColorNames(255, 20, 255, 0, 255, 20);
  colorNames_blue = GetColorNames(255, 20, 255, 20, 255, 0);
  DoStats();
}

void GetOtherColors()
{
  colorNames_red = GetColorNames(255, 0, 127, -1, 127, -1);
  colorNames_green = GetColorNames(127, -1, 255, 0, 127, -1);
  colorNames_blue = GetColorNames(127, -1, 127, -1, 255, 0);
  DoStats();
}

void GetDifferentColors()
{
  colorNames_red = GetColorNames(255, 0, 128, 1, 128, 1);
  colorNames_green = GetColorNames(128, 1, 255, 0, 128, 1);
  colorNames_blue = GetColorNames(128, 1, 128, 1, 255, 0);
  DoStats();
}

void ShowIndex(int idx)
{
  textFont(fontHeader, 20);
  fill(#AACCFF);
  text("Idx: " + idx, width / 2 - 100, 20);
}

void ShowCount()
{
  if (userNb == 0)
  {
    userNb = GetCount(USERS_TABLE_NAME);
    answerNb = GetCount(ANSWERS_TABLE_NAME);
  }
  textFont(fontHeader, 20);
  fill(#AACC88);
  text("Number of users: " + userNb, width / 2, 20);
  text("Number of answers: " + answerNb, width / 2, 40);
}

void ShowColorName(ColorName colorName, int col, int pos)
{
  int xPos = 20 + col * (width - 20) / 3;
  int yPos = 100 + pos * 16;
  textFont(fontMessage);
  fill(color(colorName.r, colorName.g, colorName.b));
  text(colorName.name, xPos, yPos);
}

/*=== ColorName Class ===*/

class ColorName
{
  String name;
  int r;
  int g;
  int b;

  ColorName(String _name, int _r, int _g, int _b)
  {
    name = _name;
    r = _r;
    g = _g;
    b = _b;
  }
}

/*=== SQLite Section ===*/

void Connect()
{
  sqlite = new SQLite(this, "D:/Dev/PhiLhoSoft/XKCD_Colors");
  if (!sqlite.connect())
  {
    println("Cannot connect to database!");
    exit();
  }
}

int GetCount(String tableName)
{
  sqlite.query("SELECT COUNT(*) FROM " + tableName);
  sqlite.next();
  return sqlite.getInt(1);
}

// Unlikely to return a result...
ArrayList GetColorNames(color rgb)
{
  int r = (rgb >> 16) & 0xFF;
  int g = (rgb >> 8) & 0xFF;
  int b = rgb & 0xFF;
  sqlite.query("SELECT colorname FROM " + ANSWERS_TABLE_NAME +
      " WHERE r=" + r + " AND g=" + g + " AND b=" + b
  );
  ArrayList colorNames = new ArrayList();
  while (sqlite.next())
  {
    String cn = sqlite.getString(1);
    colorNames.add(cn);
  }
  println("For " + hex(r, 2) + hex(g, 2) + hex(b, 2) +
      " we have " + colorNames.size() + " color names");
  return colorNames;
}

// Wider
ArrayList GetColorNames(int r, int tr, int g, int tg, int b, int tb)
{
  String request = "SELECT colorname, r, g, b FROM " + ANSWERS_TABLE_NAME + " WHERE ";
  if (tr == 0) request += "r=" + r;
  else if (tr < 0) request += "r<" + (r - tr);
  else if (tr > 0) request += "r>" + (r - tr);
  request += " AND ";

  if (tg == 0) request += "g=" + g;
  else if (tg < 0) request += "g<" + (g - tg);
  else if (tg > 0) request += "g>" + (g - tg);
  request += " AND ";

  if (tb == 0) request += "b=" + b;
  else if (tb < 0) request += "b<" + (b - tb);
  else if (tb > 0) request += "b>" + (b - tb);

  println(request);
  sqlite.query(request);
  ArrayList colorNames = new ArrayList();
  while (sqlite.next())
  {
    String cn = sqlite.getString(1);
    int rr = sqlite.getInt(2);
    int rg = sqlite.getInt(3);
    int rb = sqlite.getInt(4);
    colorNames.add(new ColorName(cn, rr, rg, rb));
  }
  println("For " + hex(r, 2) + hex(g, 2) + hex(b, 2) +
      " we have " + colorNames.size() + " color names");
  return colorNames;
}

