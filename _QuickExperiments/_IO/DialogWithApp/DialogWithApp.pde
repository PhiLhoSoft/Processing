StringBuilder raResult;

void setup()
{
//  AppDesc app = new AppDesc("Zappa", "Zappa Chess Engine", false, "C:/PrgCmdLine");
  AppDesc app = new AppDesc("TriD", "TriD File Identifier", false, "C:/PrgCmdLine");
  RunApp ra = new RunApp(app, app.GetPath(), "");
  ra.SetProgramArgs(new String[] { "C:/PrgCmdLine/curl-ca-bundle.crt" });
  raResult = new StringBuilder();
  StreamGobbler gobbler = new StreamGobbler()
  {
    protected String HandleOutputLine(String line)
    {
      raResult.append(line).append("\n");
      return null;
    }
  };
  ra.SetOutputGobbler(gobbler);

  println("Running " + app.GetName());
  ra.Run();
  println("Done");
  println(raResult);

  raResult = new StringBuilder();
  PrintWriter printWriter = new PrintWriter(ra.GetOutputStream(), true);
  println("Sending command");
  printWriter.println("uci");
  println("Answer:");
  println(raResult);

  println("Done");
  exit();
}

