import org.farng.mp3.*;
import org.farng.mp3.id3.*;
import org.farng.mp3.lyrics3.*;

void setup()
{
  PrintWriter output;

   String fileName = "E:/Archives/MM Jukebox Plus Upgrade.mp3";
//~   String fileName = "E:/Archives/MoonSwing.mp3";
//~   String fileName = "E:/Archives/Theme - Macguyver.mp3";
//~   String fileName = "E:/Archives/Theme - Fat Albert.mp3";
//~   String fileName = "E:/Archives/Theme - HeMan.mp3";
  output = new PrintWriter(System.out);
  ShowInfo(fileName, output);
  output.flush();
  output.close();

  output = createWriter("MP3_info.txt");
  ShowInfo(fileName, output);
  output.flush();
  output.close();

  delay(1000);
  exit();
}

void ShowInfo(String source, PrintWriter output)
{
  File sourceFile = new File(source);
  output.println("File: " + sourceFile.getAbsolutePath());
  RandomAccessFile raf = null;
  MP3File mp3file = null;
  ID3v1_1 tag = null;
  try
  {
    raf = new RandomAccessFile(sourceFile, "r");
  }
  catch (FileNotFoundException fnfe)
  {
    output.println("File not found: " + fnfe);
    return;
  }
/*
  try
  {
    mp3file = new MP3File(sourceFile);
  }
  catch (IOException ioe)
  {
    println("IOException: " + ioe);
    return;
  }
  catch (TagException te)
  {
    println("TagException: " + te);
    return;
  }

ID3v1_1 tag = new ID3v1_1(sourceFile);
ID3v1 tag = new ID3v1(sourceFile);
ID3v2_4 tag = new ID3v2_4(sourceFile);
ID3v2_3 tag = new ID3v2_3(sourceFile);
ID3v2_2 tag = new ID3v2_2(sourceFile);
*/
  try
  {
    tag = new ID3v1_1(raf);
  }
  catch (IOException ioe)
  {
    output.println("IOException: " + ioe);
    return;
  }
  catch (TagNotFoundException tnfe)
  {
    output.println("TagNotFoundException: " + tnfe);
    return;
  }
  finally
  {
    try { raf.close(); }
    catch (IOException ioe) { output.println("IOException: " + ioe); }
  }
  output.println("Title: " + tag.getSongTitle());
  output.println("Artist: " + tag.getLeadArtist());
  output.println("Album: " + tag.getAlbumTitle());
  output.println("Genre: " + tag.getSongGenre());
  output.println("");
  return;
}

