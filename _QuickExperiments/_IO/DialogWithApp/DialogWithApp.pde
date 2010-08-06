StringBuilder raResult;

void setup()
{
//~   AppDesc zappa = new AppDesc("Zappa", "Zappa Chess Engine", "C:/PrgCmdLine", null);
  AppDesc trid = new AppDesc("TriD", "TriD File Identifier", false, "C:/PrgCmdLine");
  RunApp ra = new RunApp(trid, trid.GetPath(), "");
  ra.SetProgramArgs(new String[] { "C:/PrgCmdLine/curl-ca-bundle.crt" });
  raResult = new StringBuilder();
  ra.SetOutputGobbler(new StreamGobbler()
  {
    protected String HandleOutputLine(String line)
    {
      raResult.append(line).append("\n");
      return null;
    }
  });

  ra.run();
  println(raResult);

  exit();
}

