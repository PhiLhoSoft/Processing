import processing.data.*;

void setup()
{
  //String input = "{ \"data\" = [ 5, 7, 9, 11 ] }";
  String input = "{\"type\":\"grid\"," +
    "\"grid\":" +
    "[" +
    "[0,0,0,0,0]," +
    "[0,0,0,{\"x\":1,\"y\":3},0]," +
    "[0,0,{\"x\":2,\"y\":2},0,0]," +
    "[{\"x\":3,\"y\":0},{\"x\":3,\"y\":1},0,0,0]," +
    "[{\"x\":4,\"y\":0},0,0,0,0]" +
    "]}";
  JSONObject json = parseJSONObject(input);
  //println(json);
  String type = json.getString("type");
  JSONArray array = json.getJSONArray(type);
  //println(array);
  for (int i = 0; i < array.size(); i++)
  {
    JSONArray a = array.getJSONArray(i);
    println(i + " " + a);
    for (int j = 0; j < a.size(); j++)
    {
      try
      {
        int d = a.getInt(j);
        println(j + " " + d);
      }
      catch (RuntimeException e)
      {
        JSONObject d = a.getJSONObject(j);
        println(j + " " + d);
      }
    }
  }
  exit();
}

