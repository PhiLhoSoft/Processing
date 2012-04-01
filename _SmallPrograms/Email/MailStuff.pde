// Daniel Shiffman
// http://www.shiffman.net

// Example functions that check mail (pop3) and send mail (smtp)
// You can also do imap, but that's not included here

// A function to check a mail account
void checkMail()
{
  Logger logger = new Logger(sketchPath("POP3.log"));
  Properties props = System.getProperties();

  props.put("mail.pop3.host", params.getProperty("POP3ServerName"));

  // These are security settings required by server
  // May need different code depending on the account
  props.put("mail.pop3.port", "110");
//  props.put("mail.pop3.starttls.enable", "true");
//  props.setProperty("mail.pop3.socketFactory.fallback", "false");
//  props.setProperty("mail.pop3.socketFactory.class","javax.net.ssl.SSLSocketFactory");

  try
  {
    // Make a session
    logger.log("Connecting...");
    Session session = Session.getDefaultInstance(props, auth);
    Store store = session.getStore("pop3");
    store.connect();

    // Get inbox
    Folder folder = store.getFolder("INBOX");
    folder.open(Folder.READ_ONLY);
    logger.log(folder.getMessageCount() + " total messages");

    // Get array of messages and display them
    Message message[] = folder.getMessages();
    for (int i = 0; i < message.length; i++)
    {
      String content = message[i].getContent().toString();
      logger.log(new String[]
      {
        "---------------------",
        "Message # " + (i+1),
        "From: " + message[i].getFrom()[0],
        "Subject: " + message[i].getSubject(),
        "Message:",
        content
      });
    }

    // Close the session
    folder.close(false);
    store.close();
  }
  // This error handling isn't very good
  catch (Exception e)
  {
    logger.log(e.toString(), e.getStackTrace());
  }
}

final int SMTP_PORT = 587;

// A function to send mail
void sendMail()
{
  Logger logger = new Logger(sketchPath("SMTP.log"));
  // Create a session
  String host = params.getProperty("SMTPServerName");
  Properties props = new Properties();

  // SMTP Session
  props.put("mail.transport.protocol", "smtp");
  props.put("mail.smtp.host", host);
  props.put("mail.smtp.port", Integer.toString(SMTP_PORT));
  props.put("mail.smtp.auth", "true");
  // We need TTLS, which server requires
  //props.put("mail.smtp.starttls.enable", "true");
  String smtpUserName = params.getProperty("SMTPUserName");
  props.put("mail.smtp.user", smtpUserName);

  // Create a session
  logger.log("Authenticating...");
  Session session = Session.getDefaultInstance(props, auth);
  session.setDebug(true);

  try
  {
    // Make a new message
    MimeMessage message = new MimeMessage(session);

    // Who is this message from
    message.setFrom(new InternetAddress(params.getProperty("MessageFrom"), params.getProperty("MessageFromFullName")));

    // Who is this message to (we could do fancier things like make a list or add CC's)
    message.setRecipients(
        Message.RecipientType.TO,
        InternetAddress.parse(params.getProperty("MessageDest"), false));
    // or
    // message.addRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));

    // Subject and body
    message.setSubject("Processing can send mails");
    message.setText("This is an interesting message\nrunning on several lines\n\n-- \nSignature");

    // We can do more here, set the date, the headers, etc.
    // For un-authenticated mail
    //Transport.send(message);
    //*
    logger.log("Connecting...");
    Transport tr = session.getTransport("smtp");
    tr.connect(host, SMTP_PORT, smtpUserName, params.getProperty("SMTPPassword"));
    message.saveChanges();
    //tr.send(message);
    // or
    logger.log("Sending message");
    tr.sendMessage(message, message.getAllRecipients());
    tr.close();
    //*/

    logger.log("Mail sent!");
  }
  catch(Exception e)
  {
    logger.log(e.toString(), e.getStackTrace());
  }
}
