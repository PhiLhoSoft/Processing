void setup()
{
  size(280,320);
  frameRate (30);
  smooth();
}

int[] anchorsX =
{
  98, 95, 88, 80, 73, 66, 67, 73,
  61, 61, 63, 63, 60, 63, 67, 67,
  75, 75, 78, 85, 92, 93, 94, 102,
  106, 106, 99, 95, 86, 84, 81, 74,
  71
};
int[] anchorsY =
{
  135, 132, 130, 130, 132, 136, 133, 128,
  135, 138, 138, 141, 144, 144, 146, 143,
  137, 140, 145, 147, 144, 139, 134, 137,
  141, 145, 146, 148, 149, 149, 148, 147,
  145
};
int[] endsX =
{
  98,-3,
  95,-7,
  88,-8,
  80,-7,
  73,-7,
  66,1,
  67,6,
  73,-12,
  61,0,
  61,2,
  63,0,
  63,-3,
  60,3,
  63,4,
  67,0,
  67,8,
  75,0,
  75,3,
  78,8,
  85,7,
  92,1,
  93,1,
  94,8,
  102,4,
  106,0,
  106,-7,
  99,-4,
  95,-9,
  86,-2,
  84,-3,
  81,-7,
  74,-3,
  71,4
};
int[] endsY =
{
  135,-3,
  130,0,
  130,0,
  130,2,
  132,4,
  136,-3,
  133,-5,
  128,7,
  135,3,
  138,0,
  138,3,
  141,3,
  144,0,
  144,2,
  146,-3,
  143,-6,
  137,3,
  140,5,
  145,2,
  147,-3,
  144,-5,
  139,-5,
  134,3,
  137,4,
  141,4,
  145,1,
  146,2,
  148,1,
  149,0,
  149,-1,
  148,-1,
  147,-2,
  145,-5
};

int lineNb = 0;
float linePercent = 0;
boolean bFinished;

void draw()
{
  background(128);
  if (!bFinished)
  {
    linePercent += 0.1;
    if (linePercent > 1.0)
    {
      lineNb++;
      linePercent = 0;
      if (lineNb >= anchorsX.length)
      {
        lineNb = anchorsX.length - 1;
        bFinished = true;
      }
    }
  }

  // Fully draw all the previous lines
  for (int i = 0; i < lineNb; i++)
  {
    line(anchorsX[i], anchorsY[i],
        endsX[2*i] + endsX[2*i + 1],
        endsY[2*i] + endsY[2*i + 1]
    );
  }
  // Partially draw the current line
  line(anchorsX[lineNb], anchorsY[lineNb],
      endsX[2*lineNb] + endsX[2*lineNb + 1] * linePercent,
      endsY[2*lineNb] + endsY[2*lineNb + 1] * linePercent
  );
}

