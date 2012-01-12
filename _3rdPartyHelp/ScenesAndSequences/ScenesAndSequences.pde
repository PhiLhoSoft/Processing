// https://forum.processing.org/topic/how-to-repeat-the-sequence

// repeat the sequence
int startTime;
 
void setup() {
  size(200, 200);
  frameRate(12);
}
 
void scene1() {
  text("s1", 20, 20);
  fill(255, 0, 0);
  rectMode(CENTER);
  rect(width/2, height/2, 50, 50);
}
 
void scene2() {
  text("s2", 20, 20);
  fill(0);
  ellipse(width/2, height/2, 50, 50);
}
 
void scene3() {
  text("s3", 20, 20);
  fill(255);
  line(0, 0, width, height);
}
 
int currentSeq = 1;
boolean seq1End = false;
int seq1Counter = 1;
boolean seq2End = false;
int seq2Counter = 1;
 
void draw() {
  background(127);
  fill(255);
  switch (currentSeq) {
  case 1:
    text("seq1 " + seq1Counter, 20, 40);
    seq1();
    if (seq1End) { // Last scene played
      seq1End = false; // To be restarted
      if (++seq1Counter > 3) { // If we havet exhausted the count of this sequence
        currentSeq++; // Go to next sequence
        seq2Counter = 1; // Which must start at 1
      }
    }
    break;
  case 2:
    text("seq2 " + seq2Counter, 20, 40);
    seq2();
    if (seq2End) {
      seq2End = false;
      if (++seq2Counter > 2) {
        currentSeq = 1; // Reset on last seq
        seq1Counter = 1;
      }
    }
    break;
  }
}
 
void seq1() {
  int m = millis() - startTime;
  if (m < 2000) {
    scene1();
  } else if (m < 4000) {
    scene2();
  } else if (m < 6000) {
    scene3();
  } else if (m < 8000) {
    startTime = millis();
    seq1End = true;
  }
}
 
void seq2() {
  int m = millis() - startTime;
  if (m < 2000) {
    scene3();
  } else if (m < 4000) {
    scene1();
  } else if (m < 6000) {
    scene2();
  } else if (m < 8000) {
    startTime = millis();
    seq2End = true;
  }
}

