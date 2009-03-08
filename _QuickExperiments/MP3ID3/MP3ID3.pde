import org.farng.mp3.*;
import org.farng.mp3.id3.*;
import org.farng.mp3.lyrics3.*;


void setup()
{
  File sourceFile = new File("E:/Archives/MoonLight.mp3");
  RandomAccessFile raf = null;
  MP3File mp3file = null;
  ID3v1_1 tag = null;
  try
  {
    raf = new RandomAccessFile(sourceFile, "r");
  }
  catch (FileNotFoundException fnfe)
  {
    println("File not found: " + fnfe);
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
*/
  try
  {
    tag = new ID3v1_1(raf);
  }
  catch (IOException ioe)
  {
    println("IOException: " + ioe); 
    return;
  }
  catch (TagNotFoundException tnfe)
  {
    println("TagNotFoundException: " + tnfe); 
    return;
  }
  println("Title: " + tag.getSongTitle());
  println("Artist: " + tag.getLeadArtist());
  println("Album: " + tag.getAlbumTitle());
  println("Genre: " + tag.getSongGenre());
}


