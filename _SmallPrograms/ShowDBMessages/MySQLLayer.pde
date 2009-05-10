/*
The MySQL layer, connecting to database and getting data from there.

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

import de.bezier.data.sql.*;
import java.sql.Timestamp;

static final String TABLE_NAME = "p5_messages";

public class MySQLLayer
{
  private MySQL m_mySQL;

  public MySQLLayer(PApplet pa)
  {
    m_mySQL = new MySQL(pa, "localhost", "tests", "PhiLho", "Foo#Bar");
    if (!m_mySQL.connect())
    {
      System.err.println("Cannot connect to database!");
      exit();
    }
  }

  public void Disconnect()
  {
    m_mySQL.close();
  }

  public int GetCount()
  {
    m_mySQL.query("SELECT COUNT(*) FROM " + TABLE_NAME);
    m_mySQL.next();
    return m_mySQL.getInt(1);
  }

  public ArrayList GetNewMessages(Timestamp previousDate)
  {
    String query = "SELECT creator, message, date_added FROM " + TABLE_NAME +
        " WHERE date_added > '" + FormatTimestamp(previousDate) + "'" +
        " ORDER BY date_added ASC";
//~     System.out.println(query);
    m_mySQL.query(query);

    ArrayList newMessageList = new ArrayList();
    while (m_mySQL.next())
    {
      String a = m_mySQL.getString(1);
      String m = m_mySQL.getString(2);
      Timestamp d = m_mySQL.getTimestamp(3);
      Message msg = new Message(a, m, d);
      newMessageList.add(msg);
    }
    println("Read " + newMessageList.size() + " messages");
    return newMessageList;
  }

  public Message GetMessage(int idx)
  {
    m_mySQL.query("SELECT creator, message, date_added FROM " + TABLE_NAME +
        " WHERE id=" + idx
    );
    m_mySQL.next();
    String a = m_mySQL.getString(1);
    String m = m_mySQL.getString(2);
    Timestamp d = m_mySQL.getTimestamp(3);
    return new Message(a, m, d);
  }

  public Message GetRandomMessage()
  {
    m_mySQL.query("SELECT creator, message, date_added FROM " + TABLE_NAME +
        " ORDER BY RAND() LIMIT 0, 1"
    );
    m_mySQL.next();
    String a = m_mySQL.getString(1);
    String m = m_mySQL.getString(2);
    Timestamp d = m_mySQL.getTimestamp(3);
    println("Read a random message");
    return new Message(a, m, d);
  }

  public String FormatHour(Timestamp ts)
  {
    DateFormat formatter = new SimpleDateFormat("HH:mm:ss");
    return formatter.format(ts);
  }

  public String FormatTimestamp(Timestamp ts)
  {
    DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    return formatter.format(ts);
  }
}
