// A cell of the grid
class Cell
{
  // With one letter to display
  String letter;
  // And a size in pixels
  int size;
  // If true, cannot be changed
  boolean readOnly;
  
  Cell(char c, int s)
  {
    setLetter(c);
    size = s;
    readOnly = false;
  }
  
  Cell(char c, int s, boolean ro)
  {
    setLetter(c);
    size = s;
    readOnly = ro;
  }
  
  void setLetter(char c)
  {
    c = Character.toUpperCase(c);
    if (c < 'A' || c > 'Z')
    {
      if (c != ' ')
        return; // Ignore the request
    }
    letter = String.valueOf(c);
  }
  
  void draw()
  {
    // Draw the background and the border
    if (readOnly)
    {
      fill(#FDFAFC);
    }
    else
    {
      fill(#FAFAFA);
    }
    stroke(#225577);
    rect(0, 0, size, size);
    // Then the letter
    if (readOnly)
    {
      fill(#228855);
    }
    else
    {
      fill(#227755);
    }
    text(letter, size / 2, size / 2);
  }
}

