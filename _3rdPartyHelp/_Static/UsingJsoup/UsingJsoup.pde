import org.jsoup.Jsoup;
import org.jsoup.nodes.*;
import org.jsoup.select.*;

void setup() {
  Document doc = null;
  try {
    doc = Jsoup.parse(new File("H:/Temp/Manual.html"), "UTF-8");
  } catch (IOException e) {
    println(e.getMessage());
  }
  Elements starts = doc.select("[name=start]");
  println("S " + starts);
 
  for (Element start : starts) {
    start.after("<a href=\"start\"></a>");
  }
  String[] html = { doc.toString() };
  saveStrings("H:/Temp/Altered.html", html);
  println("Done");
  exit();
}

