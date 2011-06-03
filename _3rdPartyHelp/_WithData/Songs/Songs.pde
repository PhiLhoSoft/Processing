import java.util.Arrays;
import java.util.Comparator;

//import static SongComparator.*;

Song[] songs = new Song[9];

void setup(){
  int i = 0;
 songs[i++] = new Song(2010, 55, 10, 4);
 songs[i++] = new Song(2010, 30, 15, 11);
 songs[i++] = new Song(2009, 14, 10, 7);
 songs[i++] = new Song(2009, 10, 10, 8);
 songs[i++] = new Song(2010, 70, 5, 3);
 songs[i++] = new Song(2008, 60, 4, 6);
 songs[i++] = new Song(2008, 40, 8, 7);
 songs[i++] = new Song(2010, 35, 7, 5);
 songs[i++] = new Song(2009, 20, 7, 4);
  //
  for(Song song : songs) {
    println(song);
  }
  Arrays.sort(songs, SongComparator.decending(SongComparator.getComparator(SongComparator.YEAR_SORT, SongComparator.WEEK1_SORT)));

  for(Song song : songs) {
    println(song);
  }
}

