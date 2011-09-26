Map<Long, Tweet> tweets = new LinkedHashMap<Long, Tweet>();
ListIterator<Tweet> iterator;
Tweet currentTweet;

void setup() {
  size(910, 400);

  addTweet("Tweet1");
  addTweet("Tweet2");
  addTweet("Tweet3");
  addTweet("Tweet4");
  addTweet("Tweet5");
  addTweet("Tweet6");
  addTweet("Tweet7");

  ArrayList<Tweet> messages = new ArrayList<Tweet>(tweets.values());
  iterator = messages.listIterator();

  textAlign(CENTER, CENTER);
  textFont(createFont("Arial", 100));
}

void draw() {
  background(0);
  if (currentTweet != null) {
    text(currentTweet.toString(), width/2, height/2);
  }
}

void addTweet(String value) {
  tweets.put(Long.valueOf((long) random(4000000)), new Tweet(value));
}

void keyPressed() {
  if (key == CODED && keyCode == LEFT && iterator.hasPrevious()) {
    currentTweet = iterator.previous();
  }
  else if (key == CODED && keyCode == RIGHT && iterator.hasNext()) {
    currentTweet = iterator.next();
  }
}

class Tweet {
  String tweetMessage;

  Tweet(String msg) {
    tweetMessage = msg;
  }

  @Override String toString() {
    return tweetMessage;
  }
}

