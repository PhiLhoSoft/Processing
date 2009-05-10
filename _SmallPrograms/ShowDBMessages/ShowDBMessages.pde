/*
Merging ShowMySQLData with SearchWordClass...
Read messages on the database and display new messages in ways depending on
what is found in the message.

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File history:
 *  1.00.000 -- 2009/05/07 (PL) -- Creation
 */
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2009 Philippe Lhoste / PhiLhoSoft
*/

import java.sql.Timestamp;

final color BACK_COLOR = color(200);
final int BASE_DISPLAY_FONT_SIZE = 50;
final int BASE_MESSAGE_DISPLAY_TIME = 4; // in seconds
final int MESSAGE_DISPLAY_NB = 5; // How many sentences are displayed simultaneously
final int DB_CHECK_INTERVAL = 5; // in seconds
int lastCheck = - DB_CHECK_INTERVAL - 1;

int startFrameCount;
int currentFrameCount;
String sentence;
Drawer drawer;

DBMessages dbMessageList;
MessageDisplayer[] displayedMessages = new MessageDisplayer[MESSAGE_DISPLAY_NB];


void setup()
{
  size(1000, 700);
  smooth();

  PFont f = createFont("Arial Bold", BASE_DISPLAY_FONT_SIZE);
  textFont(f);

  dbMessageList = new DBMessages(this);
  for (int i = 0; i < MESSAGE_DISPLAY_NB; i++)
  {
    UpdateMessageList(i);
  }
}

void stop()
{
//~   println("Stopping connection");
  dbMessageList.Stop();
}

void draw()
{
  background(BACK_COLOR);
  for (int i = 0; i < MESSAGE_DISPLAY_NB; i++)
  {
    MessageDisplayer displayer = displayedMessages[i];
    displayer.Draw();
    if (displayer.HasEnded())
    {
      println("Time to update " + i);
      // Animation for this message has ended, replace it with another message
      // from the queue
      UpdateMessageList(i);
    }
  }
}

void UpdateMessageList(int i)
{
  // Get a fresh new message (or a random old one)
  Message message = dbMessageList.GetMessage();

  // Sentence to display
  String sentence = message.m_message;
  MessageDisplayer displayer = GetDisplayer(sentence);
  displayedMessages[i] = displayer;
}

MessageDisplayer GetDisplayer(String sentence)
{
  Drawer drawer = null;
  String lowS = sentence.toLowerCase();
  if (lowS.indexOf("hide") >= 0)
  {
    drawer = new Shrinker(sentence, #2288FF);
  }
  else if (lowS.indexOf("free") >= 0)
  {
    drawer = new Grower(sentence, #992200);
  }
  else if (lowS.indexOf("yellow") >= 0 || lowS.indexOf("tang") >= 0)
  {
    drawer = new ColorMove(sentence, #FFFF55, #99FF22, BASE_MESSAGE_DISPLAY_TIME * random(0.5, 1.5));
  }
  else // Default
  {
    drawer = new ColorMove(sentence, #FFFFFF, #000000, BASE_MESSAGE_DISPLAY_TIME * random(1.0, 2.0));
  }
  
  return new MessageDisplayer(drawer);
}
