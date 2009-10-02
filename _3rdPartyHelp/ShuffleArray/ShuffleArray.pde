final int BALL_NB = 20;
URN urn = new URN(BALL_NB);

void setup() {
  size(400, 400);
  frameRate(10);
}

void draw() {
  int x = urn.get();
  print(x + " ");
  if (urn.isExhausted())
  {
    println(""); // New line
  }
}

class URN
{
  private int[] balls;
  private int ballNb = 10; // Default value
  private int num; // Set at 0 by default
  static final int LARGE_PRIME = 444443;

  // The constructor: same name as class, no return type
  public URN(int bn)
  {
    ballNb = bn;
    generateArray();
  }
  
  public int get()
  {
    if (num == ballNb) 
    {
      num = 0;
      generateArray();
    }
    return balls[num++];
  } 
  
  public boolean isExhausted()
  {
    return num == ballNb;
  }
  
  public int getNum()
  {
    return num;
  }
  
  // Private: only the class can use it
  private void generateArray()
  {
    balls = new int[ballNb]; // initialize or clear the array
    for (int i = ballNb - 1; i >= 0; i--)
    {
      int index = int(random(0, i + 1));
      balls[index] = i;
    }
    /*
    int index = int(random(0, ballNb));
    // Shuffle algorithm - Not perfect: with a same starting point, 
    // you get the same sequence. 
    // Can be spiced up by taking also a random large prime number...
    for (int i = 0; i < ballNb; i++) 
    {
      index = (index + LARGE_PRIME) % ballNb;
      balls[index] = i;
    }
    */
  }
}

