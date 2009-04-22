import de.bezier.data.sql.*;
import java.sql.Timestamp;

static final String TABLE_NAME = "p5_messages";

static final int CHECK_INTERVAL = 5; // seconds
int lastCheck = - CHECK_INTERVAL - 1;
Timestamp lastTimestamp = new Timestamp(0L);
static final int MESSAGE_DISPLAY_DURATON = 10; // seconds
int lastMessageDisplayedIndex;
int lastMessageDisplayDuration = MESSAGE_DISPLAY_DURATON;
static final int MESSAGE_DISPLAY_NB = 4;

MySQL mysql;
PFont fontHeader;
PFont fontMessage;

ArrayList messageList = new ArrayList();

void setup()
{
  size(400, 700);
  smooth();
  fontHeader = createFont("Arial", 30);
  fontMessage = createFont("Verdana", 16);

  Connect();
//~   Message m = GetMessage(2);
//~   ShowMessage(m);
}

void stop()
{
  println("Stopping connection");
  mysql.close();
}

void draw()
{
  int time = millis() / 1000;
  if (time - lastCheck > CHECK_INTERVAL)
  {
    lastCheck = time;
    // On second though, no need for this!
//~     int newMessageNb = CheckNewMessages(lastTimestamp);
    int newMessageNb = GetNewMessages(lastTimestamp);
    int totalMessageNb = messageList.size();
    println("New messages: " + newMessageNb + ", total: " + totalMessageNb);
    if (newMessageNb > 0)
    {
      Message lastMessage = (Message) messageList.get(totalMessageNb - 1);
      lastTimestamp = lastMessage.m_date;
    }

    background(#225577);
    textFont(fontHeader, 36);
    fill(#FFCC88);
    text("Message Board", 10, 36);
    ShowCount();
    if (totalMessageNb == 0)
      return;

    lastMessageDisplayDuration -= CHECK_INTERVAL;
    if (lastMessageDisplayDuration <= 0 && lastMessageDisplayedIndex < totalMessageNb - 1)
    {
      lastMessageDisplayedIndex++;
    }
    for (int i = 0; i < MESSAGE_DISPLAY_NB; i++)
    {
      int idx = 1 + lastMessageDisplayedIndex - MESSAGE_DISPLAY_NB + i;
      if (idx < 0)
        continue;
      Message m = (Message) messageList.get(idx);
      ShowMessage(m, i);
    }
  }
}

void ShowCount()
{
  textFont(fontHeader, 20);
  fill(#AACC88);
  text("Number of messages: " + GetCount(), 10, 60);
}

void ShowMessage(Message m, int pos)
{
  int yPos = 100 + pos * 150;
  textFont(fontMessage);
  fill(#FF8855);
  text(m.m_author, 10, yPos);
  fill(#8855FF);
  text(FormatHour(m.m_date), 100, yPos);
  fill(#00EE77);
  text(m.m_message, 10, yPos + 10, width - 2, 200);
}

/*=== Message Class ===*/

class Message
{
  String m_author;
  String m_message;
  Timestamp m_date;
  int rank;

  Message(String author, String message, Timestamp date)
  {
    m_author = author;
    m_message = message;
    m_date = date;
    rank = messageList.size();
  }
}

/*=== MySQL Section ===*/

void Connect()
{
  mysql = new MySQL(this, "localhost", "tests", "PhiLho", "Foo#Bar");
  if (!mysql.connect())
  {
    println("Cannot connect to database!");
    exit();
  }
}

int GetCount()
{
  mysql.query("SELECT COUNT(*) FROM " + TABLE_NAME);
  mysql.next();
  return mysql.getInt(1);
}

int CheckNewMessages(Timestamp previousDate)
{
  mysql.query("SELECT COUNT(*) FROM " + TABLE_NAME +
      " WHERE date_added > '" + FormatTimestamp(previousDate) + "'"
  );
  mysql.next();
  return mysql.getInt(1);
}

int GetNewMessages(Timestamp previousDate)
{
  String query = "SELECT creator, message, date_added FROM " + TABLE_NAME +
      " WHERE date_added > '" + FormatTimestamp(previousDate) + "'";
  println(query);
  mysql.query(query);
  int newMessageNb = 0;
  while (mysql.next())
  {
    String a = mysql.getString(1);
    String m = mysql.getString(2);
    Timestamp d = mysql.getTimestamp(3);
    Message msg = new Message(a, m, d);
    messageList.add(msg);
    newMessageNb++;
  }
  return newMessageNb;
}

Message GetMessage(int idx)
{
  mysql.query("SELECT creator, message, date_added FROM " + TABLE_NAME +
      " WHERE id=" + idx
  );
  mysql.next();
  String a = mysql.getString(1);
  String m = mysql.getString(2);
  Timestamp d = mysql.getTimestamp(3);
  return new Message(a, m, d);
}

String FormatHour(Timestamp ts)
{
  DateFormat formatter = new SimpleDateFormat("HH:mm:ss");
  return formatter.format(ts);
}

String FormatTimestamp(Timestamp ts)
{
  DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  return formatter.format(ts);
}

