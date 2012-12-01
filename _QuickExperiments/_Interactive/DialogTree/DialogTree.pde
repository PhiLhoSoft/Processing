// https://forum.processing.org/topic/help-with-dialog-setup#25080000001811353

DialogLine[] dialogLines =
{
  new DialogLine("A", "Hello", "B", "C", "D"),
  new DialogLine("B", "Go away", "."),
  new DialogLine("C", "Hi, how are you?", "E", "F"),
  new DialogLine("D", "Who are you?", "G", "H"),
  new DialogLine("E", "Fine, and you?", "!"),
  new DialogLine("F", "Not so well...", "!"),
  new DialogLine("G", "I am John, do you remember me?", "I", "J"),
  new DialogLine("H", "Sorry, that's a mistake", "."),
  new DialogLine("I", "Hi, John", "C", "K"),
  new DialogLine("J", "Not at all, goodbye", "."),
  new DialogLine("K", "Nice to see you", "."),
  new DialogLine(".", "The END"),
  new DialogLine("!", "To Be Continued"),
};
// The dialog lines indexed by their id, for easy lookup
HashMap<String, DialogLine> dialogTree = new HashMap<String, DialogLine>();
// The line currently displayed
DialogLine currentLine;
// The dialog so far
ArrayList<String> dialog = new ArrayList<String>();

void setup ()
{
  size(400, 800);
  smooth();

  for (DialogLine dl : dialogLines)
  {
    dialogTree.put(dl.id, dl);
  }
  currentLine = dialogTree.get("A");
  dialog.add(currentLine.line);
}

void draw ()
{
  background(255);
  fill(#004499);
  textSize(20);
  text(currentLine.line, 10, 30);
  
  // Display the choice of answers
  fill(#0077EE);
  textSize(15);
  int y = 60;
  int toChoose = 1;
  for (String ch : currentLine.choices)
  {
    DialogLine choice = dialogTree.get(ch);
    text(toChoose++ + ": " + choice.line, 20, y);
    y += 22;
  }
  
  // Display the history of the dialog
  fill(#0055AA);
  textSize(12);
  y = 200;
  for (String line : dialog)
  {
    text(line, 20, y);
    y += 20;
  }
}

void keyPressed()
{
  int choiceNb = currentLine.choices.length;
  int choice = key - '1';
  if (choice < 0 || choice >= choiceNb)
    return; // Ignore
    
  String choiceId = currentLine.choices[choice];
  DialogLine chosenAnswer = dialogTree.get(choiceId);
  if (chosenAnswer != null)
  {
    currentLine = dialogTree.get(choiceId);
    dialog.add(currentLine.line);
  }
}

/**
 * A dialog line: an id, the line itself, and a list of choices,
 * ie. of possible answers to this line.
 */
class DialogLine
{
  String id;
  String line;
  String[] choices;

  DialogLine(String i, String l, String... c)
  {
    id = i;
    line = l;
    choices = c;
  }
  
  String toString()
  {
    return id + " - " + line + " (" + choices.length + ")";
  }
}


