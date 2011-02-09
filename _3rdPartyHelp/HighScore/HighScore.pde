int score;
int highscore;
PFont fontS, fontG;
String highscoreFile = "highscore.txt";
final String SC = "Score: ";
final String HS = "Highscore: ";
final String PL = "Playing";
final String GO = "Game Over";
PrintWriter output;
BufferedReader reader;
 
int state = 'p';
 
void setup()
{
  size(900, 400);
  noStroke();

  fontG = createFont("Arial", 48);
  fontS = createFont("Tahoma", 16);
 
  importHighscore();
}
 
void draw()
{
  background(255);
  if (state == 'p') // Play
  {
    showGame(PL);
    upScore();
  }
  textFont(fontS);
  fill(110, 0, 255);
  text(SC + score, 25, 25);
  if (state == 'o') // Game over
  {
    text(HS + highscore, 700, 25);
    updateHighscore();
    showGame(GO);
  }
}
 
void showGame(String msg)
{
  textFont(fontG);
  fill(110, 50, 255);
  text(msg, (width - textWidth(msg)) / 2, height / 2);
} 
 
void upScore() {
  score += 10;
}
 
void updateHighscore() {
  if (highscore < score) {
    highscore = score;
    // Create a new file in the sketch directory
    output = createWriter(highscoreFile);
    output.println(highscore);
    output.close(); // Writes the remaining data to the file & Finishes the file
  }
}
 
void importHighscore() {
  // Open the file from the createWriter()
  reader = createReader(highscoreFile);
  if (reader == null) {
    highscore = 0;
    return;
  }
  String line;
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line != null) {
    highscore = int(line);
    println(highscore);
  }
  try {
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
}
 
void keyPressed() {
  if (key == 'c') // Clear score
  {
    score = 0;
    return;
  }
  if (key == 'C') // Clear highscore
  {
    highscore = 0;
    return;
  }
  
  state = key;
  if (key == ESC) {
    exit();
  }
}
