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
//~   println(sentence);
  // If we don't find a drawer, use this one
  Drawer drawer = defaultDrawer;
  for (int t = 0; t < triggers.length; t++)
  {
    // Check if matching
    if (triggers[t].matcher.IsMatching(sentence))
    {
      // Yeah, we will draw with this one!
      drawer = triggers[t].drawer;
      // And search no other (several matchers could match...)
      break;
    }
  }
  MessageDisplayer displayer = new MessageDisplayer(sentence, drawer);
  displayedMessages[i] = displayer;
}
