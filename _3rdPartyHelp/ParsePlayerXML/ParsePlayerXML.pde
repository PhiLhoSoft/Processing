XMLElement xml;

void setup()
{
  ReadXMLData();
  println(moveList);
  exit();
}

ArrayList moveList = new ArrayList();
class MovePair
{
  Move movePlayer1;
  Move movePlayer2;

  void Add(Move move)
  {
    if (move.player == 0)
    {
      movePlayer1 = move;
    }
    else  // Assume always a pair of 'move' per 'moves'
    {
      movePlayer2 = move;
    }
  }

  String toString()
  {
    return "<" + movePlayer1 + ", " + movePlayer2 + ">";
  }
}
class Move
{
  int player;
  int timeFirst;
  int timeLast;
  int dice1;
  int dice2;
  int total;
  int fromPlace;
  int toPlace;

  void Add(String tag, String value)
  {
    if (tag.equals("player"))
    {
      player = Integer.valueOf(value);
    }
    else if (tag.equals("timeFirst"))
    {
      timeFirst = Integer.valueOf(value);
    }
    else if (tag.equals("timeLast"))
    {
      timeLast = Integer.valueOf(value);
    }
    else if (tag.equals("dice1"))
    {
      dice1 = Integer.valueOf(value);
    }
    else if (tag.equals("dice2"))
    {
      dice2 = Integer.valueOf(value);
    }
    else if (tag.equals("total"))
    {
      total = Integer.valueOf(value);
    }
    else if (tag.equals("fromPlace"))
    {
      fromPlace = Integer.valueOf(value);
    }
    else if (tag.equals("toPlace"))
    {
      toPlace = Integer.valueOf(value);
    }
    else
    {
      println("Unknown tag: " + tag + " with value: " + value);
    }
  }

  String toString()
  {
    return player + "[(" +
        timeFirst + ", " + timeLast + "), (" +
        dice1 + ", " + dice2 + "), " +
        total +
        fromPlace + ", " + toPlace + ")]";
  }
}

void ReadXMLData()
{
  xml = new XMLElement(this, "XML_final_2.xml"); // game
//~   println(xml.getName());
  for (int i = 0; i < xml.getChildCount(); i++)
  {
    XMLElement movesElt = xml.getChild(i); // moves
//~     println(moves.getName());
    MovePair mp = new MovePair();
    moveList.add(mp);
    for (int j = 0; j < movesElt.getChildCount(); j++) // Always 2?
    {
      XMLElement moveElt = movesElt.getChild(j); // move
//~       println(moveElt.getName());
      Move move = new Move();
      for (int k = 0; k < moveElt.getChildCount(); k++)
      {
        XMLElement e = moveElt.getChild(k);
        String t = e.getName();
        String c = e.getContent();
        move.Add(t, c);
      }
      mp.Add(move);
    }
  }
}
