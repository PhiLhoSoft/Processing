import com.flagstone.transform.*;
import com.flagstone.transform.datatype.*;
import com.flagstone.transform.font.*;
import com.flagstone.transform.util.font.*;
import com.flagstone.transform.text.*;
import com.flagstone.transform.util.text.*;

class Sample
{
  processing.core.PApplet pa;
  
  Sample(processing.core.PApplet app)
  {
    pa = app;
  }
  
  void create()
  {
    int uid = 1;
    int layer = 1;

    final String str = "The quick, brown fox jumped over the lazy dog.";
    final Color color = WebPalette.BLACK.color();

    final String fontName = "Arial";
    final int fontSize = 24;
    final int fontStyle = java.awt.Font.PLAIN;

    // Load the AWT font.
    final AWTDecoder fontDecoder = new AWTDecoder();
    try
    {
      fontDecoder.read(new java.awt.Font(fontName, fontStyle, fontSize));
    }
    catch (Exception e)
    {
      pa.println(e.getMessage());
      return;
    }
    final Font font = fontDecoder.getFonts().get(0);

    // Create a table of the characters displayed.
    final CharacterSet set = new CharacterSet();
    set.add(str);

    // Define the font containing only the characters displayed.
    DefineFont2 fontDef = font.defineFont(uid++, set.getCharacters());

    // Generate the text field used for the button text.
    final TextTable textGenerator = new TextTable(fontDef, fontSize * 20);
    DefineText2 text = textGenerator.defineText(uid++, str, color);

    // Set the screen size to match the text with padding so the
    // text does not touch the edge of the screen.
    int padding = 1000;
    int screenWidth = text.getBounds().getWidth() + padding;
    int screenHeight = text.getBounds().getHeight() + padding;

    // Position the text in the center of the screen.
    final int xpos = padding / 2;
    final int ypos = screenHeight / 2;

    MovieHeader header = new MovieHeader();
    header.setFrameRate(1.0f);
    header.setFrameSize(new Bounds(0, 0, screenWidth, screenHeight));

    // Add all the objects together to create the movie.
    Movie movie = new Movie();
    movie.add(header);
    movie.add(new Background(WebPalette.LIGHT_BLUE.color()));
    movie.add(fontDef);
    movie.add(text);
    movie.add(Place2.show(text.getIdentifier(), layer++, xpos, ypos));
    movie.add(ShowFrame.getInstance());

    try
    {
      movie.encodeToFile(pa.sketchFile("example.swf"));
    }
    catch (Exception e)
    {
      pa.println(e.getMessage());
      return;
    }
  }
}

