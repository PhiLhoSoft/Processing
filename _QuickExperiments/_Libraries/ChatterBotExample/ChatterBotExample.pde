import com.google.code.chatterbotapi.*;


ChatterBotSession bot1session, bot2session;

void setup()
{
  ChatterBotFactory factory = new ChatterBotFactory();
  ChatterBot bot1 = null, bot2 = null;
  try
  {
    bot1 = factory.create(ChatterBotType.CLEVERBOT);
    bot2 = factory.create(ChatterBotType.PANDORABOTS, "b0dafd24ee35a477");
  }
  catch (Exception e)
  {
    println("Error: " + e);
  }
  bot1session = bot1.createSession();
  bot2session = bot2.createSession();
}

String s = "Hi";

void draw()
{
  try
  {
    println("bot1> " + s);

    s = bot2session.think(s);
    println("bot2> " + s);

    s = bot1session.think(s);
  }
  catch (Exception e)
  {
    println("Error: " + e);
  }
}

