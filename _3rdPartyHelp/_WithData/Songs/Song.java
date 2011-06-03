import java.util.Comparator;

public class Song {
 int year, week1, ch, high;

 Song(int year, int week1, int ch, int high){
   this.year = year;
   this.week1 = week1;
   this.ch = ch;
   this.high = high;
 }

 int getYear(){
   return year;
 }

 int getWeek1(){
   return week1;
 }


 public String toString() {
   return year + " - week1 " + week1 + " - ch " + ch + " - high "+high;
 };

}


enum SongComparator implements Comparator<Song> {
  YEAR_SORT {
    public int compare(Song s1, Song s2) {
      return Integer.valueOf(s1.getYear()).compareTo(s2.getYear());
    }},
   WEEK1_SORT {
     public int compare(Song s1, Song s2) {
       //return s1.getWeek1().compareTo(s2.getWeek1());
       return s1.week1 - s2.week1;
     }};

    public static Comparator<Song> decending(final Comparator<Song> other) {
      return new Comparator<Song>() {
        public int compare(Song s1, Song s2) {
          return -1 * other.compare(s1, s2);
        }
      };
    }

    public static Comparator<Song> getComparator(final SongComparator... multipleOptions) {
      return new Comparator<Song>() {
        public int compare(Song s1, Song s2) {
          for (SongComparator option : multipleOptions) {
          int result = option.compare(s1, s2);
          if (result != 0){
            return result;
          }
        }
        return 0;
      }
    };
  }
}

