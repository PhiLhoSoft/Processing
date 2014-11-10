import org.parboiled.Parboiled;
import org.parboiled.common.FileUtils;
import org.parboiled.parserunners.RecoveringParseRunner;
import org.parboiled.support.ParsingResult;

void setup()
{
  String[] lines = loadStrings("H:/Temp/Test.txt");
  String text = join(lines, "\n");
  ModelSurfaceParserI parser = Parboiled.createParser(SimpleParboiledExample.ModelSurfaceParserI.class);
  ParsingResult result = new RecoveringParseRunner(parser.Declaration()).run(text);
  exit();
}

import org.parboiled.BaseParser;
import org.parboiled.Rule;

static class ModelSurfaceParserI extends BaseParser<Object> 
{
  public Rule Declaration() 
  {
    return Sequence(
        WhiteSpace(), 
//        Prologue(), 
//        FirstOf(SelectQuery(), ConstructQuery(), DescribeQuery(), AskQuery()), 
        EOI);
  }

  public Rule WhiteSpace() 
  {
    return FirstOf(Ch(' '), Ch('\t'), Ch('\f'), EOL());
  }

  public Rule EOL() 
  {
    return AnyOf("\n\r");
  }

  public Rule DIGIT() 
  {
    return CharRange('0', '9');
  }

  public Rule COMMENT() 
  {
    return Sequence('#', ZeroOrMore(Sequence(TestNot(EOL()), ANY)), EOL());
  }
}
