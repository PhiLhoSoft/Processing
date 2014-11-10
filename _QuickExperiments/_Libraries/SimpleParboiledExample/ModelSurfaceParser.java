import org.parboiled.BaseParser;
import org.parboiled.Rule;

// Better be in a .java file, for Parboiled to find it
public class ModelSurfaceParser extends BaseParser<Object> 
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
