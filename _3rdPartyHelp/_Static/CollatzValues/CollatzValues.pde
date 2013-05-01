// https://forum.processing.org/topic/how-to-get-collatz-values-into-a-graph

void setup() {
  size(1100, 400);
  strokeWeight(2);
  textSize(8);

  print(collatzValue(2));
  print(", ");
  print(collatzValue(6));
  print(", ");
  print(collatzValue(10));
  print(", ");
  print(collatzValue(25));
  print(", ");
  print(collatzValue(32));
  print(", ");
  print(collatzValue(42));
  print(", ");
  print(collatzValue(400));
}


int margin = 25;


void draw() {
  background(0);

  //XandY axis
  stroke(255);
  line(margin, margin, margin, height-margin); //line going down
  line(margin, height-margin, width-margin, height-margin); //line going horz

  //lines on the lines on X and Y axis
  final int TICK_NB = 11;
  float partitionLength = (height - 2 * margin) / (TICK_NB - 1);

  stroke(255, 0, 0);

  //lines on the Y axis
  for (int n = 0; n < TICK_NB; n++) {
    line(margin, margin + partitionLength*n, margin-6, margin + partitionLength*n);
  }


  //numbers on the Y axis
  int VMAX = 200;
  int averageV = VMAX / (TICK_NB - 1);
  float scaleY = (height - 2.0 * margin) / VMAX;

  textAlign(RIGHT);
  for (int i = 0; i < TICK_NB; i++) {
    text(averageV * i, margin - 8, height - margin - partitionLength * i + 4);
  }

  
  partitionLength = (width - 2 * margin) / (TICK_NB - 1);

  //lines on the X axis
  for (int n = 0; n < TICK_NB; n++) {
    line(margin + partitionLength * n, height-margin, margin + partitionLength * n, height-margin+6);
  }

  //numbers on the X axis
  int HMAX = 1000;
  int averageH = HMAX / (TICK_NB - 1);

  textAlign(CENTER);
  for (int i = 0; i < TICK_NB; i++) {
    text(averageH * i, margin + partitionLength * i, height - 10);
  }

  stroke(#FFFF00);
  strokeWeight(1);
  for (int i = 1; i < HMAX; i++)
  {
    int cv = collatzValue(i);
    point(margin + ((width - 2 * margin) * i / HMAX), height - margin - scaleY * cv);
  }
}

int collatzValue(int n) {
  int total = 0;
  for (int i = n; i > 1; total++) {
    if (i % 2 == 0)
      i = i / 2;
    else
      i = i * 3 + 1;
  }
  return total;
}

