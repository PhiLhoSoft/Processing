/*
Managament of messages coming from the database.

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
import de.bezier.data.sql.*;

public class DBMessages
{
  private MySQLLayer database;

  static final long DB_CHECK_INTERVAL = 5; // seconds
  private long lastCheck = - DB_CHECK_INTERVAL - 1;
  private Timestamp lastTimestamp = new Timestamp(0L);

  private ArrayDeque   messageList = new ArrayDeque();

  public DBMessages(PApplet pa)
  {
    database = new MySQLLayer(pa);
  }
  /**
   * Clean up routine, must be called at the end of the program.
   */
  public void Stop()
  {
    database.Disconnect();
  }

  /**
   * Gets the next message (oldest), removing it from the list.
   * If none is available, returns a random message from the database.
   */
  public Message GetMessage()
  {
    UpdateData();
    Message message = (Message) messageList.removeFirst();
    if (message == null)
    {
      // Empty queue, get a random message
      message = database.GetRandomMessage();
    }
    return message;
  }

  /**
   * When getting a message, if it is time to poll the database again,
   * gets all new messages and add them to the queue.
   */
  protected void UpdateData()
  {
    long time = System.currentTimeMillis() / 1000;
    if (time - lastCheck > DB_CHECK_INTERVAL)
    {
      lastCheck = time;
      ArrayList newMessages = (ArrayList) database.GetNewMessages(lastTimestamp);
      for (int i = 0; i < newMessages.size(); i++)
      {
        Message message = (Message) newMessages.get(i);
        messageList.addLast(message);
        lastTimestamp = message.m_date;
      }
    }
  }
}
