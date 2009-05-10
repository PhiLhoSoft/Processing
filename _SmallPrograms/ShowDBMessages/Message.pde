/*
Message to display.

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

public class Message
{
  public String m_author;
  public String m_message;
  public Timestamp m_date;

  public Message(String author, String message, Timestamp date)
  {
    m_author = author;
    m_message = message;
    m_date = date;
  }
}
