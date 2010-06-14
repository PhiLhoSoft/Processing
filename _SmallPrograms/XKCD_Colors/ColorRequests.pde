/*=== ColorName Class ===*/

class ColorName
{
  String name;
  int r;
  int g;
  int b;

  ColorName(String _name, int _r, int _g, int _b)
  {
    name = _name;
    r = _r;
    g = _g;
    b = _b;
  }
}

/*=== SQLite Section ===*/

void Connect()
{
  sqlite = new SQLite(this, "D:/Dev/PhiLhoSoft/XKCD_Colors");
  if (!sqlite.connect())
  {
    println("Cannot connect to database!");
    exit();
  }
}

int GetCount(String tableName)
{
  sqlite.query("SELECT COUNT(*) FROM " + tableName);
  sqlite.next();
  return sqlite.getInt(1);
}

// Unlikely to return a result...
ArrayList GetColorNames(color rgb)
{
  int r = (rgb >> 16) & 0xFF;
  int g = (rgb >> 8) & 0xFF;
  int b = rgb & 0xFF;
  sqlite.query("SELECT colorname FROM " + ANSWERS_TABLE_NAME +
      " WHERE r=" + r + " AND g=" + g + " AND b=" + b
  );
  ArrayList colorNames = new ArrayList();
  while (sqlite.next())
  {
    String cn = sqlite.getString(1);
    colorNames.add(cn);
  }
  println("For " + hex(r, 2) + hex(g, 2) + hex(b, 2) +
      " we have " + colorNames.size() + " color names");
  return colorNames;
}

// Wider
ArrayList GetColorNames(int r, int tr, int g, int tg, int b, int tb)
{
  String request = "SELECT colorname, r, g, b FROM " + ANSWERS_TABLE_NAME + " WHERE ";
  if (tr == 0) request += "r=" + r;
  else if (tr < 0) request += "r<" + (r - tr);
  else if (tr > 0) request += "r>" + (r - tr);
  request += " AND ";

  if (tg == 0) request += "g=" + g;
  else if (tg < 0) request += "g<" + (g - tg);
  else if (tg > 0) request += "g>" + (g - tg);
  request += " AND ";

  if (tb == 0) request += "b=" + b;
  else if (tb < 0) request += "b<" + (b - tb);
  else if (tb > 0) request += "b>" + (b - tb);

  println(request);
  sqlite.query(request);
  ArrayList colorNames = new ArrayList();
  while (sqlite.next())
  {
    String cn = sqlite.getString(1);
    int rr = sqlite.getInt(2);
    int rg = sqlite.getInt(3);
    int rb = sqlite.getInt(4);
    colorNames.add(new ColorName(cn, rr, rg, rb));
  }
  println("For " + hex(r, 2) + hex(g, 2) + hex(b, 2) +
      " we have " + colorNames.size() + " color names");
  return colorNames;
}
