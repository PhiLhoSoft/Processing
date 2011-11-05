// Daniel Shiffman
// http://www.shiffman.net

// Simple Authenticator
// Careful, this is terribly unsecure!!
// (a bit less since I put the data in a property file)

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Auth extends Authenticator
{
  private String m_userName;
  private String m_password;

  public Auth(String userName, String password)
  {
    super();
    m_userName = userName;
    m_password = password;
  }

  public PasswordAuthentication getPasswordAuthentication()
  {
    return new PasswordAuthentication(m_userName, m_password);
  }
}
