class ProgressiveLine
{
  private final int anchorX, anchorY;
  private final int endX, evolX;
  private final int endY, evolY;
  public static final int PARAM_NB = 6;

  ProgressiveLine(int ax, int ay, int ex, int evx, int ey, int evy)
  {
    anchorX = ax;
    anchorY = ay;
    endX = ex; evolX = evx;
    endY = ey; evolY = evy;
  }

  void drawFull()
  {
    draw(1.0);
  }
  void draw(float linePercent)
  {
    line(anchorX, anchorY,
        endX + evolX * linePercent,
        endY + evolY * linePercent
    );
  }
}

ProgressiveLine[] lines;

void setup()
{
  size(280,320);
  frameRate (30);
  smooth();

  lines = new ProgressiveLine[data.length / ProgressiveLine.PARAM_NB];
  for (int i = 0, lineNb = 0; i < data.length; i += ProgressiveLine.PARAM_NB, lineNb++)
  {
    lines[lineNb] = new ProgressiveLine(
        data[i],     data[i + 1], data[i + 2],
        data[i + 3], data[i + 4], data[i + 5]
    );
  }
}

int[] data =
{
   98, 135,  98,  -3, 135, -3,
   95, 132,  95,  -7, 130,  0,
   88, 130,  88,  -8, 130,  0,
   80, 130,  80,  -7, 130,  2,
   73, 132,  73,  -7, 132,  4,
   66, 136,  66,   1, 136, -3,
   67, 133,  67,   6, 133, -5,
   73, 128,  73, -12, 128,  7,
   61, 135,  61,   0, 135,  3,
   61, 138,  61,   2, 138,  0,
   63, 138,  63,   0, 138,  3,
   63, 141,  63,  -3, 141,  3,
   60, 144,  60,   3, 144,  0,
   63, 144,  63,   4, 144,  2,
   67, 146,  67,   0, 146, -3,
   67, 143,  67,   8, 143, -6,
   75, 137,  75,   0, 137,  3,
   75, 140,  75,   3, 140,  5,
   78, 145,  78,   8, 145,  2,
   85, 147,  85,   7, 147, -3,
   92, 144,  92,   1, 144, -5,
   93, 139,  93,   1, 139, -5,
   94, 134,  94,   8, 134,  3,
  102, 137, 102,   4, 137,  4,
  106, 141, 106,   0, 141,  4,
  106, 145, 106,  -7, 145,  1,
   99, 146,  99,  -4, 146,  2,
   95, 148,  95,  -9, 148,  1,
   86, 149,  86,  -2, 149,  0,
   84, 149,  84,  -3, 149, -1,
   81, 148,  81,  -7, 148, -1,
   74, 147,  74,  -3, 147, -2,
   71, 145,  71,   4, 145, -5
};

int lineNb = 0;
float linePercent = 0;
boolean bFinished;

void draw()
{
  background(255);
  translate(-100, -200);
  scale(3);
  if (!bFinished)
  {
    linePercent += 0.1;
    if (linePercent > 1.0)
    {
      lineNb++;
      linePercent = 0;
      if (lineNb >= lines.length)
      {
        lineNb = lines.length - 1;
        linePercent = 1.0;  // Fully draw last line
        bFinished = true;
        println("Done!");
      }
    }
  }

  // Fully draw all the previous lines
  for (int i = 0; i < lineNb; i++)
  {
    lines[i].drawFull();
  }
  // Partially draw the current line
  lines[lineNb].draw(linePercent);
}

