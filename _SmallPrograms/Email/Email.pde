// Daniel Shiffman
// http://www.shiffman.net

// Simple E-mail Checking
// This code requires the Java mail library
// smtp.jar, pop3.jar, mailapi.jar, imap.jar, activation.jar
// Download:// http://java.sun.com/products/javamail/

import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Authenticator;

Parameters params;
Authenticator auth;

void setup()
{
  // Get parameters
  params = new Parameters(dataPath("ConnectionInformation.properties"));
  // Create authentication object
  auth = new Auth(
      params.getProperty("AuthUserName"),
      params.getProperty("AuthPassword"));

  // Function to send mail
  sendMail();

  // Function to check mail
  checkMail();

  exit();
}


